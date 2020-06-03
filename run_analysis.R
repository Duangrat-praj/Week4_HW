train_x <- read.table("/Users/tangtarn/UCI HAR Dataset/train/X_train.txt",header=FALSE);
test_x <- read.table("/Users/tangtarn/UCI HAR Dataset/test/X_test.txt",header=FALSE);
col_x <- read.table("/Users/tangtarn/UCI HAR Dataset/features.txt",header=FALSE);
X <- rbind(train_x,test_x);
colnames(X) <- as.character(col_x[,2]);






train_y <- read.table("/Users/tangtarn/UCI HAR Dataset/train/Y_train.txt",header=FALSE);
test_y <- read.table("/Users/tangtarn/UCI HAR Dataset/test/Y_test.txt",header=FALSE);
col_y <- read.table("/Users/tangtarn/UCI HAR Dataset/activity_labels.txt",header=FALSE);
Y <- rbind(train_y,test_y);
Y <- merge(x = Y, y = col_y, by = "V1", all.y = TRUE);
colnames(Y) <- c("V1","Activity");


train_id <- read.table("/Users/tangtarn/UCI HAR Dataset/train/subject_train.txt",header=FALSE);
test_id <- read.table("/Users/tangtarn/UCI HAR Dataset/test/subject_test.txt",header=FALSE);
id <- rbind(train_id,test_id);
colnames(id) <- c("Subject");


data <- cbind(id,X,Y);


data_c <- data[, grep("mean\\(\\)|std\\(\\)", colnames(data))];
names(data_c) <- gsub(x = names(data_c), pattern = "mean\\(\\)", replacement = "Mean");
names(data_c) <- gsub(x = names(data_c), pattern = "std\\(\\)", replacement = "STD");
names(data_c) <- gsub(x = names(data_c), pattern = "\\-", replacement = "_");

tidy_data <- cbind(Subject=id,Activity=Y$Activity,data_c);
tidy_data <- aggregate(. ~ Subject + Activity, data = tidy_data, FUN = mean);

write.table(tidy_data, file = "tidy_data.txt",row.name=FALSE);
