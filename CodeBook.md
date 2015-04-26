## Overview
The data mentioned below was transformed from raw to tidy data by
* 1.	Merging the training and the test sets to create one data set.
	-This was done by using rbind() and cbind(), and names() was used to change the names correctly.
* 2.	Extracting only the measurements on the mean and standard deviation for each measurement.
	-This was done by using grep()
* 3.	Use descriptive activity names to name the activities in the data set
	-This was done by using read.table on the activity_labels.txt file
* 4.	Appropriately label the data set with descriptive variable names.
	-This was done by checking the number in the activity column, and if it matched a number it would be changed correctly.
* 5.	From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject.
	-This was done by using the plyr library package, aggregate(), order() and using write.table to export the data to a text file.
	
All of the above was done to the data and run_analysis.R script.

## Data & Data contents
Download the data from: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
Please make sure the files are unzipped and files not modified.
Information about the data source: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The main files used from the source are:
* y_test.txt
* y_train.txt
* subject_test.txt
* subject_train.txt
* X_test.txt
* X_train.txt
* features.txt
* activity_labels.txt

## Variables
* activityDataTest contains the activity test data
* activityDataTrain contains activity train data
* subjectDataTest contains the subject test data
* subjectDataTrain contains the subject train data
* featuresDataTest contains the features test data
* featuresDataTrain contains the features train data
* subjectData, activityData and featuresData are merged data of the previous variables
* featuresDataNames contains data from the features.txt file
* combinedData contains merged data of subjectData and activityData
* data contains merged data of featuresData and combinedData
* featuresNamesSubdata is extracting the names by mean and standard deviation
* Names contains the subject and activity names
* Data contains all the merged data
* activityLabels contains the descriptive activity names
* activityData contains the names of the different activities
* Data2 contains the tidy data used to export it to a text file
