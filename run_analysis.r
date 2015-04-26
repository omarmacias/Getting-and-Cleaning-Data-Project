# run_analysis.r script

## Read the files into variables and merge the training and test sets into
## one data set

activityDataTest <- read.table("test/y_test.txt", header = FALSE)
activityDataTrain <- read.table("train/y_train.txt", header = FALSE)

subjectDataTest <- read.table("test/subject_test.txt", header = FALSE)
subjectDataTrain <- read.table("train/subject_train.txt", header = FALSE)

featuresDataTest <- read.table("test/X_test.txt", header = FALSE)
featuresDataTrain <- read.table("train/X_train.txt", header = FALSE)

## Merging the data together
## Concatenating the data tables by rows

subjectData <- rbind(subjectDataTrain, subjectDataTest)
activityData <- rbind(activityDataTrain, activityDataTest)
featuresData <- rbind(featuresDataTrain, featuresDataTest)

## Adding names to the variables
names(subjectData) <- c("subject")
names(activityData) <- c("activity")
featuresDataNames <- read.table("features.txt", head = FALSE)
names(featuresData) <- featuresDataNames$V2

## Merging columns to create the data frame for all data

combinedData <- cbind(subjectData, activityData)
data <- cbind(featuresData, combinedData)

## Extracting the measurements on the mean and standard deviation
## for each measurement
# Subsetting the name of Features by mean & Standard Deviation
featuresNamesSubdata <- featuresDataNames$V2[grep("mean\\(\\)|std\\(\\)", featuresDataNames$V2)]

## Subsetting data by the subject and activity features
Names <- c(as.character(featuresNamesSubdata), "subject", "activity")
Data <- subset(data, select=Names)

## Use descriptive activity names to name the activities in the data set

## Reading the descriptive activity names from "activity_labels.txt"
activityLabels <- read.table("activity_labels.txt", header = FALSE)

## factorize activity label in the data frame Data using descriptive names
activityData[, 1] <- activityLabels[activityData[, 1], 2]
names(activityData) <- "activity"
## Correct the activity names
Data$activity <- as.character(Data$activity)
Data$activity[Data$activity == 1] <- "Walking"
Data$activity[Data$activity == 2] <- "Walking Upstairs"
Data$activity[Data$activity == 3] <- "Walking Downstairs"
Data$activity[Data$activity == 4] <- "Sitting"
Data$activity[Data$activity == 5] <- "Standing"
Data$activity[Data$activity == 6] <- "Laying"
Data$activity <- as.factor(Data$activity)

## Appropriately labels the data set with descriptive variable names

names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data))

## Create a second, independent tidy data set
## Load the plyr package
library(plyr)
Data2 <- aggregate(. ~subject + activity, Data, mean)
Data2 <- Data2[order(Data2$subject,Data2$activity),]
write.table(Data2, file = "tidydata.txt", row.name = FALSE)