## [1. read data files]

test <- read.table("UCI HAR Dataset/test/X_test.txt")
test_y <- read.table("UCI HAR Dataset/test/Y_test.txt")
sub_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
train <- read.table("UCI HAR Dataset/train/X_train.txt")
train_y <- read.table("UCI HAR Dataset/train/Y_train.txt")
sub_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
labels <- read.table("UCI HAR Dataset/activity_labels.txt")
feat <- read.table("UCI HAR Dataset/features.txt")


## [2. Change colnames to descriptive activity names]

names(test) <- as.character(unlist(feat["V2"]))
names(train) <- as.character(unlist(feat["V2"]))


## [3. convert number values to labels in test_y and train_y]

for (i in 1:length(train_y$V1)) {
    train_y$V1[i] <- as.character(labels[train_y$V1[i],2])
}
for (i in 1:length(test_y$V1)) {
    test_y$V1[i] <- as.character(labels[test_y$V1[i],2])
}


## [4. bind labels and subjects to data]

test <- cbind(test_y, test)
test <- cbind(sub_test, test)
train <- cbind(train_y, train)
train <- cbind(sub_train, train)


## [5. Merge test and train data]

tt <- rbind(train, test)


## [6. Extract first 2 cols & mean()/stdev() for each measurement]

tt0 <- tt[, 1:2]
tt1 <- tt[, grepl("mean()", names(tt))]
tt1 <- tt1[, c(1:23, 27:29, 33:35, 39, 41, 43, 45)]
tt2 <- tt[, grepl("std()", names(tt))]


## [7. Rebind extracted dataframe]

d0 <- data.frame(cbind(tt0,tt1,tt2))
colnames(d0)[1] <- "Subject"
colnames(d0)[2] <- "Activity"
d0 <- d0[order(d0$Subject,d0$Activity), ]


## [8. Create df of ave/variable for each activity for each subject]

d0[,"Subject"]<-factor(d0[,"Subject"])
d0[,"Activity"]<-factor(d0[,"Activity"])
s <- split(d0, list(d0$Subject, d0$Activity))
cnames <- as.character(names(d0[, 3:68]))
d1 <- data.frame(lapply(s, function(x) colMeans(x[, cnames])))
d1 <- data.frame(t(d1))

## Dataframe d1 contains the average of mean and stdev variables
## for each activity for each subject in the UCI HAR Dataset