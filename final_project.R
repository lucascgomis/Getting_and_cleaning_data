# Downloading the data
# change the variable wd to tour working directory
wd = 'C:/Users/Silvana/Desktop/Lucas/Coursera/Getting and Cleaning Data/project'
# setting your working directory
setwd(wd)
# cheking if the workind directory was set right
getwd()
if (!file.exists('data')){
  dir.create('data')
}


if (!file.exists('./data/getdata_projectfiles_UCI HAR Dataset.zip')){
  download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', './data/getdata_projectfiles_UCI HAR Dataset.zip')
}

unzip('./data/getdata_projectfiles_UCI HAR Dataset.zip', exdir = './data')



# 1. Merges the training and the test sets to create one data set.


# reading the packages
library(dplyr)

# reading test dataset
test_x = read.table('./data/UCI HAR Dataset/test/X_test.txt')
test_y = read.table('./data/UCI HAR Dataset/test/Y_test.txt')

# reading train data sets
train_x = read.table('./data/UCI HAR Dataset/train/X_train.txt')
train_y = read.table('./data/UCI HAR Dataset/train/Y_train.txt')

# merging trains datasets in one
train_y = train_y %>% rename('y'= V1)


train = cbind(train_x, train_y)
glimpse(train)

# merging test datasets in one
test_y = test_y %>% rename('y'= V1)
test = cbind(test_x, test_y)
glimpse(test)




# creating one data set merging test and train
dataSet = rbind(train, test)
glimpse(dataSet)


# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# reading the label of the features
features = read.table('./data/UCI HAR Dataset/features.txt')
features = features$V2


# reading and merging the subjects to the dataset
subject_test = read.table('./data/UCI HAR Dataset/test/subject_test.txt')
subject_train = read.table('./data/UCI HAR Dataset/train/subject_train.txt')
subjects = rbind(subject_train, subject_test)
dataSet = cbind(dataSet, subjects)

# renaming the columns of the dataset
names(dataSet) = c(features, 'activity', 'subject')
glimpse(dataSet)

#Extracting only the measurements on the mean and standard deviation for each measurement

columns = c(features, 'activity', 'subject')
filtered_columns = grep("subject|activity|[Mm][Ee][Aa][Nn]|[Ss][Tt][Dd]", columns)
mean_std_df = dataSet[filtered_columns]
glimpse(mean_std_df)


#3 Uses descriptive activity names to name the activities in the data set
dataSet[dataSet$activity == 1,562] = 'WALKING'
dataSet[dataSet$activity == 2,562] = 'WALKING_UPSTAIRS'
dataSet[dataSet$activity == 3,562] = 'WALKING_DOWNSTAIRS'
dataSet[dataSet$activity == 4,562] = 'SITTING'
dataSet[dataSet$activity == 5,562] = 'STANDING'
dataSet[dataSet$activity == 6,562] = 'LAYING'
glimpse(dataSet)

mean_std_df[mean_std_df$activity == 1,87] = 'WALKING'
mean_std_df[mean_std_df$activity == 2,87] = 'WALKING_UPSTAIRS'
mean_std_df[mean_std_df$activity == 3,87] = 'WALKING_DOWNSTAIRS'
mean_std_df[mean_std_df$activity == 4,87] = 'SITTING'
mean_std_df[mean_std_df$activity == 5,87] = 'STANDING'
mean_std_df[mean_std_df$activity == 6,87] = 'LAYING'
glimpse(mean_std_df)


#4 Uses descriptive activity names to name the activities in the data set
names(mean_std_df) =  gsub("Acc", "Accelerometer", names(mean_std_df))
names(mean_std_df) = gsub("Mag", "Magnitude", names(mean_std_df))
names(mean_std_df) = gsub("^t", "Time", names(mean_std_df))
names(mean_std_df) = gsub("tBody", "TimeBody", names(mean_std_df))
names(mean_std_df) = gsub("^f", "Frequency", names(mean_std_df))
names(mean_std_df) = gsub("-freq()", "Frequency", names(mean_std_df), ignore.case = TRUE)
glimpse(mean_std_df)

 
#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
df_step5 = mean_std_df %>% group_by(activity, subject) %>% summarise_all(list(mean))
write.table(df_step5, "./data/df_step5.txt", row.name=FALSE)
