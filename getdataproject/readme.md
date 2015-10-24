Course Project - Getting and Cleaning Data
=================

## About the script


	- This R script takes data collected from the accelerometers from the Samsung Galaxy S smartphone.
	- The data was partitioned into two sets (training and test).
	- Merges the training and the test sets to create one data set.
	- Extracts only the measurements on the mean and standard deviation for each measurement. 
	- Uses descriptive activity names to name the activities in the data set.
	- Appropriately labels the data set with descriptive variable names. 
	- Creates a second, independent tidy data set with the average of each variable for each activity and each subject.


##Instructions


This script uses data from "Human Activity Recognition Using Smartphones Dataset" 
please downloaded and unzip it and puth the resulted "UCI HAR Dataset" folder in your working directory 
then run run_analysis.R.
the script will output the resuled tidy data to your working directory "/TidyDataSet.txt".


data : https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


##Dependencies


Require reshape2 library for the melt() function