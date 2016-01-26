#
#run_analysis.R
#
#Name:    Gene Livingston
#Course:  Coursera, Getting & Cleaning Data
#Date:    18 Jan 2016
#
#

library("data.table")

#get running OS:
os <- Sys.info()['sysname']
os <- tolower(os)
os

#set the working dir:

root_dir <- "data"

if(os == "windows") {
  win_root <- paste("C:\\",root_dir,sep="")
  setwd(paste(win_root,"\\get-clean-project\\UCI HAR Dataset",sep=""))
} else {
  setwd("~/data/get-clean-project/UCI HAR Dataset")
}

activity <- read.table("./activity_labels.txt")[,2]

#store column names
features <- read.table("./features.txt")[,2]

#map the mean & std
mean_std <- grepl("mean|std", features)
mean_std

# Load and process X_test & y_test data.
X_test <- read.table("./test/X_test.txt")
y_test <- read.table("./test/y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

names(X_test) = features

#
# #2: Extracts only the measurements on the mean and standard deviation for each measurement:
#

X_test = X_test[,features]

#
# #3: Uses descriptive activity names to name the activities in the data:
#

y_test[,2] = activity[y_test[,1]]
names(y_test) = c("Activity_ID", "Activity_Label")
names(subject_test) = "Subject"

#Bind
test_data <- cbind(as.data.table(subject_test), y_test, X_test)

# Load and process X_train & y_train data.
X_train <- read.table("./train/X_train.txt")
y_train <- read.table("./train/y_train.txt")

subject_train <- read.table("./train/subject_train.txt")

names(X_train) = features

#get the mean and standard deviation
X_train = X_train[,features]

#
# #3: Uses descriptive activity names to name the activities in the data:
#

y_train[,2] = activity[y_train[,1]]
names(y_train) = c("Activity_ID", "Activity_Label")
names(subject_train) = "Subject"

#Bind
train_data <- cbind(as.data.table(subject_train), y_train, X_train)

#look at the data dimensions (not required for assignment):
dim(X_test)  # 2947x561
dim(y_test)  #2947x2
dim(X_train) #7352x561
dim(y_train) #7352x2
dim(subject_train) #7352x1
dim(subject_test)  #2947x1

#
# #1: Merge the training and the test sets to create one data set:
#

data = rbind(test_data, train_data)

#
# #4: Appropriately labels the data set with descriptive variable names:
#

id_labels   = c("Subject", "Activity_ID", "Activity_Label")
data_labels = setdiff(colnames(data), id_labels)
melt_data      = melt(data, id = id_labels, measure.vars = data_labels)

#
# #5: From the data set in Step 4, creates a second, independent tidy data set with the averages
#     of each variable for each activity and each subject:
#
tidydata   = dcast(melt_data, Subject + Activity_Label ~ variable, mean)
tidydata

#write data to a file:
write.table(tidydata, file = "./tidydata.txt")


