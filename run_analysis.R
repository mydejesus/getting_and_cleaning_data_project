# Getting and Cleaning Data Course Project
# Instructions for project
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject.




# Download the file and put the file in the data folder
# Note:  The following variables may have to be changed in the code if not using Windows OS:

# dataSetURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# download.file(fileUrl,destfile="./data/Dataset.zip")

if(!file.exists("./data")){dir.create("./data")}
dataSetURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataSetURL,destfile="./data/DataSet.zip")


# Unzip the file

unzip(zipfile="./data/DataSet.zip",exdir="./data")


# Read data from the files into the variables

#Read the Activity files
# *ACT* for Activity
# *SUBJ* for Subject
# *FEAT* for Features

ACTdataTest <- read.table(file.path(path_file, "test" , "Y_test.txt" ),header = FALSE)
ACTdataTrain <- read.table(file.path(path_file, "train", "Y_train.txt"),header = FALSE)
SUBJdataTest  <- read.table(file.path(path_file, "test" , "subject_test.txt"),header = FALSE)
SUBJdataTrain <- read.table(file.path(path_file, "train", "subject_train.txt"),header = FALSE)
FEATdataTest <- read.table(file.path(path_file, "test" , "X_test.txt" ),header = FALSE)
FEATdataTrain <- read.table(file.path(path_file, "train", "X_train.txt"),header = FALSE)



# Merges the rows of the training and the test sets to create one data set
# Concatenate the data tables by rows

ACTMerge <- rbind(ACTdataTest, ACTdataTrain)
SUBJMerge <- rbind(SUBJdataTest, SUBJdataTrain)
FEATMerge <- rbind(FEATdataTest,  FEATdataTrain)

# Name the variables
FEATdataNames <- read.table(file.path(path_file, "features.txt"),head=FALSE)
names(ACTMerge) <- c("activity")
names(SUBJMerge) <-c("subject")
names(FEATMerge) <- FEATdataNames$V2

# Merge columns to get the data frame Data for all data

dataColMerge <- cbind(ACTMerge, SUBJMerge)
FinalData <- cbind(FEATMerge, dataColMerge)

# Extract Data subset 

FEATsubNames<-FEATdataNames$V2[grep("mean\\(\\)|std\\(\\)", FEATdataNames$V2)]

# Merge into FinalData
combineNames <-c(as.character(FEATsubNames), "subject", "activity" )
FinalData <-subset(FinalData,select=combineNames)

# Read descriptive activity names from “activity_labels.txt”

ACTLabels <- read.table(file.path(path_file, "activity_labels.txt"),header = FALSE)

# Renames Labels
# 't' is replaced by 'Time'
# 'Acc' is replaced by 'Accelerometer'
# 'Gyro' is replaced by 'Gyroscope'
# 'prefix' f is replaced by 'Frequency'
# 'Mag' is replaced by 'Magnitude'
# 'BodyBody' is replaced by 'Body'

names(FinalData)<-gsub("^t", "Time", names(FinalData))
names(FinalData)<-gsub("^f", "Frequency", names(FinalData))
names(FinalData)<-gsub("Acc", "Accelerometer", names(FinalData))
names(FinalData)<-gsub("Gyro", "Gyroscope", names(FinalData))
names(FinalData)<-gsub("Mag", "Magnitude", names(FinalData))
names(FinalData)<-gsub("BodyBody", "Body", names(FinalData))

# create Tidy Data set
library(plyr);
TidyData <-aggregate(. ~subject + activity, FinalData, mean)
TidyData <-TidyData[order(TidyData$subject,TidyData$activity),]
write.table(TidyData, file = "tidydata.txt",row.name=FALSE)


