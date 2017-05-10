## Getting and cleaning data course project 

# Train and test data loaded into tran_data and test_data data frames. 

train_data <- read.table("train\\X_train.txt")
test_data <- read.table("test\\X_test.txt")

#1. Merges the training and the test sets to create one data set

data <- rbind(train_data, test_data) 

#2. Extracts only the measurements on the mean and standard deviation for each measurement

#Reading the features.txt file into a data set to know what each one of the variables in the train and test data mean
#Variable number is stored in column 1, and description in column 2 (561 rows, 2 cols)
#Only the features that contain "mean()" and "std()" string values are extracted, and stored in mean_std_var vector
#mean_std_data contains only the columns with mean and std measurements

features <- read.table("features.txt")
mean_std_var <- features[(grepl("mean[(][)]", features$V2) | grepl("std[(][)]", features$V2)), 1]
mean_std_data <- data[, mean_std_var]

#3. Uses descriptive activity names to name the activities in the data set

#This part of the code reads in labels for each observation and stores it in train_labels and test_labels
#Then numbers are replaced by meaningful names and both activity vectors are merged into train_test_labels

train_labels <- read.table("train\\y_train.txt")
test_labels <- read.table("test\\y_test.txt")

train_labels <- lapply(train_labels, sub, pattern = "1", replacement = "WALKING", x = train_labels$V1)
train_labels <- lapply(train_labels, sub, pattern = "2", replacement = "WALKING_UPSTAIRS", x = train_labels$V1)
train_labels <- lapply(train_labels, sub, pattern = "3", replacement = "WALKING_DOWNSTAIRS", x = train_labels$V1)
train_labels <- lapply(train_labels, sub, pattern = "4", replacement = "SITTING", x = train_labels$V1)
train_labels <- lapply(train_labels, sub, pattern = "5", replacement = "STANDING", x = train_labels$V1)
train_labels <- lapply(train_labels, sub, pattern = "6", replacement = "LAYING", x = train_labels$V1)

test_labels <- lapply(test_labels, sub, pattern = "1", replacement = "WALKING", x = test_labels$V1)
test_labels <- lapply(test_labels, sub, pattern = "2", replacement = "WALKING_UPSTAIRS", x = test_labels$V1)
test_labels <- lapply(test_labels, sub, pattern = "3", replacement = "WALKING_DOWNSTAIRS", x = test_labels$V1)
test_labels <- lapply(test_labels, sub, pattern = "4", replacement = "SITTING", x = test_labels$V1)
test_labels <- lapply(test_labels, sub, pattern = "5", replacement = "STANDING", x = test_labels$V1)
test_labels <- lapply(test_labels, sub, pattern = "6", replacement = "LAYING", x = test_labels$V1)

train_labels <- data.frame(train_labels)
test_labels <- data.frame(test_labels)
train_test_labels <- rbind(train_labels, test_labels)

#4. Appropriately labels the data ser with descriptive variable names

mean_std_names <- as.character(features[(grepl("mean[(][)]", features$V2) | grepl("std[(][)]", features$V2)), 2])
names(mean_std_data) <- mean_std_names

#5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

#Labels of the subjects are stored in train_subject and test_subject vectors, then merged together into train_test_subject
#Columns "Activity" and "Subject" containing the labels are added to the data set, these are used as indexes to use tapply function
#mean summary contains the independent tidy data set with the average of each variable for each activity and each subject
train_subject <- read.table("train\\subject_train.txt")
test_subject <- read.table("test\\subject_test.txt")
train_test_subject <- rbind(train_subject, test_subject)

mean_std_data <- cbind("Activity" = train_test_labels$V1, mean_std_data)
mean_std_data <- cbind("Subject" = train_test_subject$V1, mean_std_data)

#In this line the final data set is created, calculating the mean of all columns in mean_std_data, by Subject and by Activity
mean_summary <- apply(mean_std_data[, 3:68], 2, function(x) tapply(x, list(mean_std_data$Subject, mean_std_data$Activity), mean))

#The final data set is converted to a data frame and written in a txt file
mean_summary_df <- data.frame(mean_summary)
write.table(mean_summary, file = "meanSubjectActivity.txt", append = FALSE, quote = TRUE, sep = " ",
            eol = "\n", na = "NA", dec = ".", row.names = FALSE,
            col.names = TRUE, qmethod = c("escape", "double"),
            fileEncoding = "")


