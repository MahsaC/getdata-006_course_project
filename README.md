getdata-006_course_project
==========================

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

				************

2) The mean and std columns will be extracted for the test (train) file. The coulmn names are found from "features.txt" file where "mean()" or "std()" is in the feature name. "needed_cols" stored all these columns. A python script is in the data set folder which gives the column name:
needed_cols <- c("V1", "V2", "V3", "V4", "V5", "V6", "V41", "V42", "V43", "V44", "V45", "V46", "V81", "V82", "V83", "V84", "V85", "V86", "V121", "V122", "V123", "V124", "V125", "V126", "V161", "V162", "V163", "V164", "V165", "V166", "V201", "V202", "V214", "V215", "V227", "V228", "V240", "V241", "V253", "V254", "V266", "V267", "V268", "V269", "V270", "V271", "V345", "V346", "V347", "V348", "V349", "V350", "V424", "V425", "V426", "V427", "V428", "V429", "V503", "V504", "V516", "V517", "V529", "V530", "V542", "V543")

extracted_test <- X_test[,needed_cols]

extracted_train <- X_train[,needed_cols]

				************

3) The activity label will be given for each element of Y-test (train) by merging with "activity_labels.txt":
labels <- read.table("UCI HAR Dataset/activity_labels.txt")

labeled_Y_test <- merge(Y_test,labels,by.x="V1",by.y="V1")

labeled_Y_train <- merge(Y_train,labels,by.x="V1",by.y="V1")

				************

4) The column name of each file will be set before merging all files together. descriptive_variable_names is stored all names given for each column:
colnames(subject_test) <- c("subject_name")
colnames(extracted_test) <- descriptive_variable_names
colnames(labeled_Y_test) <- c("V1","activity_label")

colnames(subject_train) <- c("subject_name")
colnames(extracted_train) <- descriptive_variable_names
colnames(labeled_Y_train) <- c("V1","activity_label")

				************

5) Combine all coloumns(X,Y,subject) of file test(train).
test_combined <- cbind(extracted_test,labeled_Y_test["activity_label"],subject_test)

train_combined <- cbind(extracted_train,labeled_Y_train["activity_label"],subject_train)

				************

6) Merge both test and train files by rbind:
total_merged <- rbind(test_combined ,train_combined )

				************

7) Creates a data set with the average of each variable for each activity and each subject by aggregate function:
final_cleaning_result <- aggregate(as.matrix(total_merged[,1:66]),as.list(total_merged[,67:68]),FUN=mean)

				************

8) Write the final_cleaning_result to a file and print it to screen:

write.table( final_cleaning, "final_cleaning_result_file.txt", row.names=FALSE)

print(final_cleaning_result)
				************

-------------------------
Descriptive Column Names
-------------------------
1 tBodyAcc_mean_X
2 tBodyAcc_mean_Y
3 tBodyAcc_mean_Z
4 tBodyAcc_std_X
5 tBodyAcc_std_Y
6 tBodyAcc_std_Z
7 tGravityAcc_mean_X
8 tGravityAcc_mean_Y
9 tGravityAcc_mean_Z
10 tGravityAcc_std_X
11 tGravityAcc_std_Y
12 tGravityAcc_std_Z
13 tBodyAccJerk_mean_X
14 tBodyAccJerk_mean_Y
15 tBodyAccJerk_mean_Z
16 tBodyAccJerk_std_X
17 tBodyAccJerk_std_Y
18 tBodyAccJerk_std_Z
19 tBodyGyro_mean_X
20 tBodyGyro_mean_Y
21 tBodyGyro_mean_Z
22 tBodyGyro_std_X
23 tBodyGyro_std_Y
24 tBodyGyro_std_Z
25 tBodyGyroJerk_mean_X
26 tBodyGyroJerk_mean_Y
27 tBodyGyroJerk_mean_Z
28 tBodyGyroJerk_std_X
29 tBodyGyroJerk_std_Y
30 tBodyGyroJerk_std_Z
31 tBodyAccMag_mean
32 tBodyAccMag_std
33 tGravityAccMag_mean
34 tGravityAccMag_std
35 tBodyAccJerkMag_mean
36 tBodyAccJerkMag_std
37 tBodyGyroMag_mean
38 tBodyGyroMag_std
39 tBodyGyroJerkMag_mean
40 tBodyGyroJerkMag_std
41 fBodyAcc_mean_X
42 fBodyAcc_mean_Y
43 fBodyAcc_mean_Z
44 fBodyAcc_std_X
45 fBodyAcc_std_Y
46 fBodyAcc_std_Z
47 fBodyAccJerk_mean_X
48 fBodyAccJerk_mean_Y
49 fBodyAccJerk_mean_Z
50 fBodyAccJerk_std_X
51 fBodyAccJerk_std_Y
52 fBodyAccJerk_std_Z
53 fBodyGyro_mean_X
54 fBodyGyro_mean_Y
55 fBodyGyro_mean_Z
56 fBodyGyro_std_X
57 fBodyGyro_std_Y
58 fBodyGyro_std_Z
59 fBodyAccMag_mean
60 fBodyAccMag_std
61 fBodyBodyAccJerkMag_mean
62 fBodyBodyAccJerkMag_std
63 fBodyBodyGyroMag_mean
64 fBodyBodyGyroMag_std
65 fBodyBodyGyroJerkMag_mean
66 fBodyBodyGyroJerkMag_std
67 activity_label
68 subject_name


