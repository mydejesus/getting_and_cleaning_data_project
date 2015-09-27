# Load data

# Download the file and put the file in the data folder
# Note:  The following variables may have to be changed in the code if not using Windows OS:

# dataSetURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

# download.file(fileUrl,destfile="./data/Dataset.zip")

# Set data URL
if(!file.exists("./data")){dir.create("./data")}
dataSetURL <- "http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(dataSetURL,destfile="./data/DataSet.zip")

# Unzip the file

unzip(zipfile="./data/DataSet.zip",exdir="./data")

# Set file Path
path_file <- file.path("./data" , "UCI HAR Dataset")

#step 1A: Merge training sets 

train.x <- read.table(file.path(path_file, "train" , "x_train.txt" ),header = FALSE)
train.y <- read.table(file.path(path_file, "train", "y_train.txt"), header = FALSE)
train.subject <- read.table(file.path(path_file, "train", "subject_train.txt"), header = FALSE)

#step 1B: Merge test sets 
test.x <- read.table(file.path(path_file, "test" , "x_test.txt" ),header = FALSE)
test.y <- read.table(file.path(path_file, "test", "y_test.txt"), header = FALSE)
test.subject <- read.table(file.path(path_file, "test", "subject_test.txt"), header = FALSE)


#step 1C: create single dateset of x, y and subject

x.series <- rbind(train.x, test.x)
y.series <- rbind(train.y, test.y)
subject.series <- rbind(train.subject, test.subject)

#step 2: Extracts only the measurements on the mean and standard deviation for each measurement

#set column names
features <- read.table(file.path(path_file, "features.txt"),head=FALSE)

#calculate mean and std dev
filtered.col <- grep("-(mean|std)\\(\\)", features[, 2])

# Extract columns
x.series <- x.series[, filtered.col]

#Label column names

names(x.series) <- features[filtered.col, 2]

#step 3: relabel activity names

activities <- read.table(file.path(path_file,"activity_labels.txt"), header=FALSE)

#relabel y-series 

y.series[, 1] <- activities[y.series[, 1], 2]
names(y.series) <- "activity"

#step 4: label data set with descriptive names

names(subject.series) <- "subject"

# merge all data

data <- cbind(x.series, y.series, subject.series)

#step 5: create a tidy data set with avg of each variable for each activity & subject

library(plyr)
tidy.average <- ddply(data, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(tidy.average, "tidy_data.txt", row.name = FALSE)
