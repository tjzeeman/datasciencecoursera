# Script to read and clean up data for running analysis on mean & std error

# Read in data files
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("subject"))
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/Y_test.txt", col.names = c("activity"))

subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("subject"))
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/Y_train.txt", col.names = c("activity"))

# get the column information
features <- read.table("UCI HAR Dataset/features.txt")
meanstd <- features[grep("(mean|std)\\(", features$V2),]

# strip info from X
X_test_subset <- subset(X_test, select = meanstd$V1)
X_train_subset <- subset(X_train, select = meanstd$V1)

# set meaningful names to the columns
colnames(X_test_subset) <- meanstd$V2
colnames(X_train_subset) <- meanstd$V2

# combine test files
test <- cbind(subject_test, X_test_subset, y_test)

# combine training files
train <- cbind(subject_train, X_train_subset, y_train)

# combine test and training files
dataset <- rbind(test, train)

# get the activity translation
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("activity", "activity_name"))

# perform analysis
data <- dataset %>% group_by(subject, activity) %>% summarise_each(funs(mean))

# merge activity
activity_ds <- merge(data, activity_labels, by = "activity", all.x = TRUE)

# write file output
write.table(activity_ds, file = "data.txt", row.name=FALSE)
