## Check if the data directory exists and create if it doesn't exist.
if(!file.exists("./data")) {
dir.create("./data")
}

## Download and unzip dataset.
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
tempFile <- tempfile()
download.file(fileURL, tempFile, method = "curl")
unzip(tempFile, exdir = "./data")

## Read all of the data in the training and the test sets.
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", header = F, stringsAsFactors = F, fill = T)
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt", header = F, stringsAsFactors = F, fill = T)
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", header = F, stringsAsFactors = F, fill = T)
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", header = F, stringsAsFactors = F, fill = T)
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt", header = F, stringsAsFactors = F, fill = T)
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", header = F, stringsAsFactors = F, fill = T)

## Step 1: Merge the training and the test sets to create one data set.
data <- cbind(rbind(subject_test, subject_train),
			rbind(y_test, y_train),
			rbind(X_test, X_train))
			
## Step 2: Extract only the measurements on the mean and standard deviation for each measurement. 
## Read the variables names from features.txt.
features <- read.table("./data/UCI HAR Dataset/features.txt", header = F, stringsAsFactors = F, fill = T)

## Set meaningful names for first columns
colnames(data)[1:2] <- c("Subject", "Activity")

## Set names for all other columns, those coming from X, according to features data frame
colnames(data)[3:563] <- features[, 2]

## Subset data to only include columns that have "mean", "std", "Activity" or "Subject" and do NOT have "meanFreq" in their name
data <- data[, grepl("mean()|std()|Activity|Subject", colnames(data)) & !grepl("meanFreq", colnames(data))]

## Step 3: Use descriprite activity names to name the activities in the data set. 
## Read activity names from activity_labels.txt
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt", header = F, stringsAsFactors = F, fill = T)

## Step 4: Appropriately label the data set with descriptive activity names.
data$Activity <- factor(data$Activity, levels = activities[, 1], labels = activities[, 2])

## Step 5: From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject. 
data2 <- aggregate(. ~Subject + Activity, data, mean)
data2 <- data2[order(data2$Subject,data2$Activity),]
write.table(data2, file = "tidydata.txt", row.names=FALSE)

