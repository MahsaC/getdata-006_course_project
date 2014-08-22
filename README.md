Course Project of Getting and Cleaning Data
===========================================

The "run_analysis.R" file contains the R code to get the clean data after performing the following 5 steps:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

----------------------
Describing the R Code
----------------------
1) The test (train) files will be read from its directory:
test_dir <- "UCI HAR Dataset/test"
test_files <- list.files(test_dir, full.names=TRUE)	
subject_test <- read.table(test_files[2])
X_test <- read.table(test_files[3])
Y_test <- read.table(test_files[4])

train_dir <- "UCI HAR Dataset/train"
train_files <- list.files(train_dir, full.names=TRUE)	
subject_train <- read.table(train_files[2])
X_train <- read.table(train_files[3])
Y_train <- read.table(train_files[4])


2) The mean and std columns will be extracted for the test (train) file. The coulmn names are found from "features.txt" file where "mean()" or "std()" is in the feature name. "needed_cols" stored all these columns. A python script is in the data set folder which gives the column name:
needed_cols <- c("V1", "V2", "V3", "V4", "V5", "V6", "V41", "V42", "V43", "V44", "V45", "V46", "V81", "V82", "V83", "V84", "V85", "V86", "V121", "V122", "V123", "V124", "V125", "V126", "V161", "V162", "V163", "V164", "V165", "V166", "V201", "V202", "V214", "V215", "V227", "V228", "V240", "V241", "V253", "V254", "V266", "V267", "V268", "V269", "V270", "V271", "V345", "V346", "V347", "V348", "V349", "V350", "V424", "V425", "V426", "V427", "V428", "V429", "V503", "V504", "V516", "V517", "V529", "V530", "V542", "V543")

extracted_test <- X_test[,needed_cols]

extracted_train <- X_train[,needed_cols]


3) The activity label will be given for each element of Y-test (train) by merging with "activity_labels.txt":
labels <- read.table("UCI HAR Dataset/activity_labels.txt")

labeled_Y_test <- merge(Y_test,labels,by.x="V1",by.y="V1")

labeled_Y_train <- merge(Y_train,labels,by.x="V1",by.y="V1")


4) The column name of each file will be set before merging all files together. descriptive_variable_names is stored all names given for each column:
colnames(subject_test) <- c("subject_name")
colnames(extracted_test) <- descriptive_variable_names
colnames(labeled_Y_test) <- c("V1","activity_label")

colnames(subject_train) <- c("subject_name")
colnames(extracted_train) <- descriptive_variable_names
colnames(labeled_Y_train) <- c("V1","activity_label")


5) Combine all coloumns(X,Y,subject) of file test(train).
test_combined <- cbind(extracted_test,labeled_Y_test["activity_label"],subject_test)

train_combined <- cbind(extracted_train,labeled_Y_train["activity_label"],subject_train)


6) Merge both test and train files by rbind:
total_merged <- rbind(test_combined ,train_combined )


7) Creates a data set with the average of each variable for each activity and each subject by aggregate function:
final_cleaning_result <- aggregate(as.matrix(total_merged[,1:66]),as.list(total_merged[,67:68]),FUN=mean)


8) Write the final_cleaning_result to a file and print it to screen:

write.table( final_cleaning, "final_cleaning_result_file.txt", row.names=FALSE)

print(final_cleaning_result)
