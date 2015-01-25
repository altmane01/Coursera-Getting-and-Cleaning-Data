Coursera Getting and Cleaning Data Course Project Assignment 

In five steps the script run_analysis.R creates a second, independent tidy data set tidydata.txt that contains the relevant averages from the UCI HAR Dataset. 

    1. Merges the training and the test sets into data to create one data set using cbind function.
    2. Extracts only the measurements on the mean and standard deviation for each measurement into data. 
    3. Uses descriptive activity names to name the activities in the data set from activity_labels.txt. 
    4. Appropriately labels the data set with descriptive variable names. 
    5. From the data set in step 4, creates with write.table tidydata.txt, a second, independent tidy data set from data2 with the average of each variable for each activity and each subject. 


subject_test, X_test, y_test, subject_train, X_train and y_train contain data from the downloaded files.

data - merge the previous datasets to further analysis to extract only the measurements on the mean and standard deviation for each measurement.

features - contains the correct names for the data dataset.

data2 - independent tidy data set with the average of each variable for each activity and each subject.
 
