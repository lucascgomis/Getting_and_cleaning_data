# Codebook
This codebook contains all the steps I perfomed to do the required analisys in the final project of the "Getting and Cleaning Data" course. It also contains the intructions to run the final_project.R scrit on your computer.

1. Setting your working directory:
Here you should replace the variable wd with you working directory path, remember to use '/' on the working directory path in case using windowns. This is supposed to be the only necessary change to run the script properly. 

2. Download the data
The data folder wil be created and the zip file ('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip') will be downloaded and unziped in case it does not exist already


3. Reading the train and test datasets
Stored in the following variables:
- train_x ; train_y
- test_x ; test_y

4. merging train data sets in one, and the test data sets in one (variable train)
Stored in the following variables:
- train
- test

6. merging train and test datasets in one
Stored in the following variable:
- dataSet

7. reading the features and subejcts:
Stored in the following variables:
- features
- subject_test
- subjec_train

8. merging subject to the dataset
Stored in the following variable:
- subejects

9. renaming the columns of the dataset

10. Extracting only the measurements on the mean and standard deviation for each measurement
Subeteting of the variable dataSet

11. Uses descriptive activity names to name the activities in the data set

12. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

13. Export the tidy data set in a .txt file
