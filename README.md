# Coursera Getting and Cleaning Data Course Project

## OVERVIEW
##### This repository contains all the required work for the Getting and Cleaning Data Course Project
#### About the Raw Data
##### * The data used cam from a study as described in this [Samsung study]( http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)
##### * The file is zipped and should be unzipped before proceeding with the code
##### * My code unzips it in a 'data' folder in the current directory
##### * The unzipped files are in 'UCI HAR Dataset' folder

## Code Notes
1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive activity names.
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

## Working on the Project
###### Note1:  library(plyr) is required to run the code
###### Note2:  The following variables may have to be changed in the code if not using Windows OS:
###### * dataSetURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
###### * download.file(fileUrl,destfile="./data/Dataset.zip")

1. The first 3 lines of the code dowloads and unzips the files.  It will also create a 'data' folder in your working directory
2. Put run_analysis.R in the parent folder of UCI HAR Dataset, then set it as your working directory using setwd() function in RStudio.
3. Run source("run_analysis.R"), then it will generate a new file tiny_data.txt in your working directory.
