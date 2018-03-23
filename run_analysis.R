##load dplyr package
library(dplyr)

##downnload zipped file
download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", "temp.zip")

##extract zipped file then delete zipped folder
unzip("temp.zip")
unlink("temp.zip")

##load the training and test data sets into data tables
training_tbl <- read.table('UCI HAR Dataset/train/X_train.txt')
test_tbl <- read.table('UCI HAR Dataset/test/X_test.txt')

##load the feature (variable) names
feature_names <- read.table('UCI HAR Dataset/features.txt')

##apply the variable names to each table
colnames(training_tbl) <- feature_names[,2]
colnames(test_tbl) <- feature_names[,2]

##load the training and test set labels into memory, set column names to "Label"
training_labels <- read.table('UCI HAR Dataset/train/y_train.txt')
test_labels <- read.table('UCI HAR Dataset/test/y_test.txt')
colnames(training_labels) <- "Label"
colnames(test_labels) <- "Label"

##load the training and test subject IDs into memory, set column names to "Subject"
training_subjects <- read.table('UCI HAR Dataset/train/subject_train.txt')
test_subjects <- read.table('UCI HAR Dataset/test/subject_test.txt')
colnames(training_subjects) <- "Subject"
colnames(test_subjects) <- "Subject"

##bind Subject and Label columns to each table
training_tbl <- bind_cols(training_subjects, training_labels, training_tbl)
test_tbl <- bind_cols(test_subjects, test_labels, test_tbl)

##bind the rows of training and test sets together (in that order)
big_tbl <- bind_rows(training_tbl, test_tbl)
big_tbl <- tbl_df(big_tbl)

##clean up
rm(training_tbl, training_subjects, training_labels, test_labels, test_subjects, test_tbl, feature_names)
unlink("UCI HAR Dataset", recursive=TRUE)

##Extract only the mean and std columns for each measurement
big_tbl <- select(big_tbl, Subject, Label, contains("mean"), contains("std"))

##Change Label values to descriptive terms
big_tbl$Label <- recode(big_tbl$Label, "1"="WALKING", "2"="WALKING_UPSTAIRS", "3"="WALKING_DOWNSTAIRS", "4"="SITTING", "5"="STANDING", "6"="LAYING")

##create a second table with mean values for all variables aggregated according to Subject and Label 
number_of_columns <- length(names(big_tbl))
grouped_table <- aggregate(big_tbl[,3:number_of_columns], by=list(Subject=big_tbl$Subject, Label=big_tbl$Label), mean)
rm(number_of_columns)


