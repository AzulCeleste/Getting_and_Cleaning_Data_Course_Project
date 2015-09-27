Getting and Cleaning Data Course Project
========================================

## Files

The code takes for granted that you have already downloaded and unzipped the original data and all the data is present in the same folder without any previous processing of the data.

`CodeBook.md` describes the variables, the data, and any transformations or work that was performed to clean up the data.

`run_analysis.R` contains all the code to perform the analyses.

The output of the script is called `final_tidy_data.txt`, and it's available in the repo.

# run_analysis.R

This R script performs the following steps, as per the project assignment instructions:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Run the analysis

In your R enviroment (in the same folder where the data files are), load the script:

```
source('run_analysis.R')
```

## Final tidy dataset

Each row in the final, clean dataset contains 'subject', 'activity', and 'measurements' for all required features (i.e., mean or standard deviation).
