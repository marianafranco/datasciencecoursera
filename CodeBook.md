Code Book
=========

The run_analysis.R script is used to download, clean and summarize data, in the form of a new csv file, from the Human Activity Recognition Using Smartphones Dataset Version 1.0.

Input
--------------------
- The Human Activity Recognition Using Smartphones Dataset Version 1.0
- URL = https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Output
--------------------
- A summary of the downloaded, cleaned and processed Human Activity Recognition Using Smartphones Dataset Version 1.0
- file name = tidy_summary.csv
- first row headers = TRUE
- variable separator = ","

Variables for tidy_summary.csv
----------------------------
- column 1 = Subject / subject who performed activity (integer)
- column 2 = Activity / description of activity (character)
- columns 3 to 68 = mean values for specified variables, relating to estimated means. These are described in more detail in the unzipped downloaded file: "/UCI HAR Dataset/README.txt", "/UCI HAR Dataset/features_info.txt" and "/UCI HAR Dataset/features.txt"

run_analysis.R steps
--------------------
- Downloads and unzips the data files (ignore if archive already there);
- Loads the the test and training data;
- Merge the training and the test sets to create one data set;
- Filters variables and leaves only those who describes mean or standard deviation;
- Creates the summary dataset with the average of each variable for each activity and each subject;
- Saves the merged and summary datasets to tidy.csv and tidy_summary.csv respectively.