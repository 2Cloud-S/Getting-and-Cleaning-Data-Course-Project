# run_analysis.R

# Step 0: Download and unzip the dataset (if not already done)
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, destfile = "dataset.zip")
unzip("dataset.zip")

# Step 1: Merge the training and test sets
# Load training and test data
train_data <- read.table("UCI HAR Dataset/train/X_train.txt")
train_labels <- read.table("UCI HAR Dataset/train/y_train.txt")
train_subjects <- read.table("UCI HAR Dataset/train/subject_train.txt")

test_data <- read.table("UCI HAR Dataset/test/X_test.txt")
test_labels <- read.table("UCI HAR Dataset/test/y_test.txt")
test_subjects <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Merge training and test sets
merged_data <- rbind(train_data, test_data)
merged_labels <- rbind(train_labels, test_labels)
merged_subjects <- rbind(train_subjects, test_subjects)

# Step 2: Extract measurements on mean and standard deviation
features <- read.table("UCI HAR Dataset/features.txt")
mean_std_indices <- grep("mean\\(\\)|std\\(\\)", features$V2)
merged_data <- merged_data[, mean_std_indices]

# Step 3: Use descriptive activity names
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
merged_labels$V1 <- factor(merged_labels$V1, levels = activity_labels$V1, labels = activity_labels$V2)

# Step 4: Label the dataset with descriptive variable names
colnames(merged_data) <- features[mean_std_indices, 2]
colnames(merged_labels) <- "activity"
colnames(merged_subjects) <- "subject"
combined_data <- cbind(merged_subjects, merged_labels, merged_data)

# Step 5: Create a tidy dataset with averages for each activity and subject
library(dplyr)
tidy_data <- combined_data %>%
  group_by(subject, activity) %>%
  summarise_all(mean)

# Save the tidy dataset
write.table(tidy_data, "tidy_data.txt", row.names = FALSE)

# Optional: Save as CSV for easier inspection
write.csv(tidy_data, "tidy_data.csv", row.names = FALSE)
