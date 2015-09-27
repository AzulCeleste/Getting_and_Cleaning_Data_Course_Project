##########################################################################################################

# run_analysis.R File

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merge the training and the test sets to create one data set.
# 2. Extract only the measurements on the mean and standard deviation for each measurement. 
# 3. Use descriptive activity names to name the activities in the data set
# 4. Appropriately label the data set with descriptive activity names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################

# 1. Merges the training and the test sets to create one data set.

setwd("C:/Users/210067772/Coursera/Dataset")

#Load data
xTrain <- read.table("./train/X_train.txt")
yTrain <- read.table("./train/y_train.txt")
subTrain <- read.table("./train/subject_train.txt")
xTest <- read.table("./test/X_test.txt")
yTest <- read.table("./test/y_test.txt") 
subTest <- read.table("./test/subject_test.txt")
features <- read.table("./features.txt")

# Assign column names
colnames(xTrain)   <- features[,2] 
colnames(xTest)    <- features[,2] 

#Merge data
oneSubject <- rbind(subTrain, subTest)
oneData  <- rbind(xTrain, xTest)
oneLabel <- rbind(yTrain, yTest)


# 2. Extracts only the measurements on the mean and standard 
# deviation for each measurement. 

# Create a vector with the names of the columns to search for stdev and mean 
Names  <-  colnames(oneData)

dataLogical <- (grepl("activity..",Names) | grepl("subject..",Names) | grepl("-mean..",Names) & !grepl("-meanFreq..",Names)| grepl("-std..",Names))
oneData <- oneData[dataLogical==TRUE] #66 measurements

# 3. Use descriptive activity names to name the activities in 
# the data set

activity <- read.table("./activity_labels.txt", header=FALSE, col.names=c('activityId','activityType'))


# Step4. Appropriately labels the data set with descriptive activity 
# names. 
oneLabel[, 1] = activity[oneLabel[, 1], 2]
names(oneLabel) <- "activity"
names(oneSubject) <- "subject"

tidyData <- cbind(oneSubject, oneLabel, oneData)
dim(tidyData) # 10299*68
write.table(tidyData, row.name= FALSE, "tidy_data.txt")
write.csv(tidyData, "tidy_Data.csv")

# Step5. Creates a second, independent tidy data set with the average of 
# each variable for each activity and each subject. 

measurements <- tidyData[, 3:dim(tidyData)[2]]
final_tidyData <- aggregate(measurements, by = list(tidyData$subject, tidyData$activity), mean)
names(final_tidyData)[1:2] <- c('subject', 'activity')
write.table(final_tidyData, row.name= FALSE, "final_tidy_data.txt") 
write.csv(final_tidyData, "final_tidy_data.csv")
