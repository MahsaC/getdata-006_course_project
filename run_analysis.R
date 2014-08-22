labels <- read.table("UCI HAR Dataset/activity_labels.txt")
needed_cols <- c("V1", "V2", "V3", "V4", "V5", "V6", "V41", "V42", "V43", "V44", "V45", "V46", "V81", "V82", "V83", "V84", "V85", "V86", "V121", "V122", "V123", "V124", "V125", "V126", "V161", "V162", "V163", "V164", "V165", "V166", "V201", "V202", "V214", "V215", "V227", "V228", "V240", "V241", "V253", "V254", "V266", "V267", "V268", "V269", "V270", "V271", "V345", "V346", "V347", "V348", "V349", "V350", "V424", "V425", "V426", "V427", "V428", "V429", "V503", "V504", "V516", "V517", "V529", "V530", "V542", "V543")
descriptive_variable_names <- c("tBodyAcc_mean_X", "tBodyAcc_mean_Y", "tBodyAcc_mean_Z", "tBodyAcc_std_X", "tBodyAcc_std_Y", "tBodyAcc_std_Z", "tGravityAcc_mean_X", "tGravityAcc_mean_Y", "tGravityAcc_mean_Z", "tGravityAcc_std_X", "tGravityAcc_std_Y", "tGravityAcc_std_Z", "tBodyAccJerk_mean_X", "tBodyAccJerk_mean_Y", "tBodyAccJerk_mean_Z", "tBodyAccJerk_std_X", "tBodyAccJerk_std_Y", "tBodyAccJerk_std_Z", "tBodyGyro_mean_X", "tBodyGyro_mean_Y", "tBodyGyro_mean_Z", "tBodyGyro_std_X", "tBodyGyro_std_Y", "tBodyGyro_std_Z", "tBodyGyroJerk_mean_X", "tBodyGyroJerk_mean_Y", "tBodyGyroJerk_mean_Z", "tBodyGyroJerk_std_X", "tBodyGyroJerk_std_Y", "tBodyGyroJerk_std_Z", "tBodyAccMag_mean", "tBodyAccMag_std", "tGravityAccMag_mean", "tGravityAccMag_std", "tBodyAccJerkMag_mean", "tBodyAccJerkMag_std", "tBodyGyroMag_mean", "tBodyGyroMag_std", "tBodyGyroJerkMag_mean", "tBodyGyroJerkMag_std", "fBodyAcc_mean_X", "fBodyAcc_mean_Y", "fBodyAcc_mean_Z", "fBodyAcc_std_X", "fBodyAcc_std_Y", "fBodyAcc_std_Z", "fBodyAccJerk_mean_X", "fBodyAccJerk_mean_Y", "fBodyAccJerk_mean_Z", "fBodyAccJerk_std_X", "fBodyAccJerk_std_Y", "fBodyAccJerk_std_Z", "fBodyGyro_mean_X", "fBodyGyro_mean_Y", "fBodyGyro_mean_Z", "fBodyGyro_std_X", "fBodyGyro_std_Y", "fBodyGyro_std_Z", "fBodyAccMag_mean", "fBodyAccMag_std", "fBodyBodyAccJerkMag_mean", "fBodyBodyAccJerkMag_std", "fBodyBodyGyroMag_mean", "fBodyBodyGyroMag_std", "fBodyBodyGyroJerkMag_mean", "fBodyBodyGyroJerkMag_std")

test_dir <- "UCI HAR Dataset/test"
test_files <- list.files(test_dir, full.names=TRUE)	
X_test <- read.table(test_files[3])
Y_test <- read.table(test_files[4])
subject_test <- read.table(test_files[2])
colnames(subject_test) <- c("subject_name")
extracted_test <- X_test[,needed_cols]
colnames(extracted_test) <- descriptive_variable_names
labeled_Y_test <- merge(Y_test,labels,by.x="V1",by.y="V1")
colnames(labeled_Y_test) <- c("V1","activity_label")
test_combined <- cbind(extracted_test,labeled_Y_test["activity_label"],subject_test)

train_dir <- "UCI HAR Dataset/train"
train_files <- list.files(train_dir, full.names=TRUE)	
X_train <- read.table(train_files[3])
Y_train <- read.table(train_files[4])
labeled_Y_train <- merge(Y_train,labels,by.x="V1",by.y="V1")
subject_train <- read.table(train_files[2])
colnames(subject_train) <- c("subject_name")
extracted_train <- X_train[,needed_cols]
colnames(extracted_train) <- descriptive_variable_names
labeled_Y_train <- merge(Y_train,labels,by.x="V1",by.y="V1")
colnames(labeled_Y_train) <- c("V1","activity_label")
train_combined <- cbind(extracted_train,labeled_Y_train["activity_label"],subject_train)

total_merged <- rbind(test_combined ,train_combined )
final_cleaning_result <- aggregate(as.matrix(total_merged[,1:66]),as.list(total_merged[,67:68]),FUN=mean)
write.table(final_cleaning_result,"final_cleaning_result_file.txt",row.names=FALSE)
print(final_cleaning_result)
