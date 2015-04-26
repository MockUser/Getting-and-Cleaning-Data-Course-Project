# Getting and Cleaning Data - Course project

## Requirements

You should create one R script called run_analysis.R that does the following. 
* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement.
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Working instructions

* Set you working directory where you prefer
* Copy the __'run_analysis.R'__ script file in the working directory
* launch the script with __source("run_analysis.R")__
* the raw data file will be downloaded from the repository into the working directory
* the downloaded file will be unzipped in a subfolder named 'UCI HAR Dataset'
* the output file named __'tidyData.txt'__ will be created in the working directory

## Dependencies
* utils
* plyar
* data.tables


