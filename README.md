##Module 3 (getting & cleaning data) programming assignment
The script in this repo performs the following: 
*downloads the zipped file from the URL specified in the assignment
*unzips the folder and loads the relevant files into memory as individual tables
*binds the Subject and Label columns to the training and test data tables
*binds the rows from test and training data tables together to create one data set
*remove all columns from this data set except Subject, Label, and mean and stdev values
*recode the Label values from 1:6 to descriptive terms as described in activity_labels.txt
*create a second table with mean values for all variables, aggregated according to Subject and Label
*clean up (i.e. remove all files and objects except the tables required)