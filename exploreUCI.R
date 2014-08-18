setwd("d:/data/")
# setwd("~/github_repo/GetDataProject")
# work
# useDir <- "/Users/johnhansen/Google Drive/School/coursera/SigTrack3 - Getting and Cleaning Data/wd/UCI HAR Dataset/" # home
useDir <- "D:/data/UCI HAR Dataset/" # WORK

# build test set

subject_test <- read.table(paste(useDir,"test/subject_test.txt",sep=""), quote="\"")  # HOME
# View(subject_test)
names(subject_test) <- "subject"

# table(subject_test)
# subject_test
# 2   4   9  10  12  13  18  20  24 
# 302 317 288 294 320 327 364 354 381 

X_test <- read.table(paste(useDir,"test/X_test.txt",sep=""), quote="\"") # WORK
features <- read.table(paste(useDir,"features.txt",sep=""), quote="\"")
names(X_test) <- features[,2]
# View(X_test)

y_test <- read.table(paste(useDir,"test/y_test.txt",sep=""), quote="\"")
names(y_test) <- "activityID"
# View(y_test)

# table(y_test)
# y_test
# 1   2   3   4   5   6 
# 496 471 420 491 532 537 

test <- cbind(subject_test,X_test,y_test)

# build train set

subject_train <- read.table(paste(useDir,"train/subject_train.txt",sep=""), quote="\"")
# View(subject_train)
names(subject_train) <- "subject"

# table(subject_train)
# subject_train
# 1   3   5   6   7   8  11  14  15  16  17  19  21  22  23  25  26  27  28  29  30 
# 347 341 302 325 308 281 316 323 328 366 368 360 408 321 372 409 392 376 382 344 383 

X_train <- read.table(paste(useDir,"train/X_train.txt",sep=""), quote="\"")
# View(X_train)
features <- read.table(paste(useDir,"features.txt",sep=""), quote="\"")
names(X_train) <- features[,2]
# View(X_train)

y_train <- read.table(paste(useDir,"train/y_train.txt",sep=""), quote="\"")
names(y_train) <- "activityID"
# View(y_train)
# table(y_train)
# y_train
# 1    2    3    4    5    6 
# 1226 1073  986 1286 1374 1407

train <- cbind(subject_train,X_train,y_train)

# concatenate two datasets
# table(test$subject)
# table(train$subject)

combined <- rbind(test,train)
table(combined$subject)
# works!

# keep only mean and std measurements
# i.e., subject (#1), vars that have string mean and std (grep these), and activity (#563)

smaller <- combined[,c(1,grep("mean" ,names(combined)),grep("std" ,names(combined)),563)]

# Creates a second, independent tidy data set with the average of each variable
# for each activity and each subject.

# sanity check
# write.table(smaller,"smaller.txt",col.names=TRUE,row.names=FALSE)

# merge in activity from activity labels
actLabels <- read.table(paste(useDir,"activity_labels.txt",sep=""), quote="\"")
names(actLabels) <- c("activityID","activity")
# View(actLabels)
smallLabeled <- merge(smaller,actLabels,by.x="activityID",by.y="activityID")
head(smallLabeled)
# write.table(smallLabeled,"smallLabeled.txt",col.names=TRUE,row.names=FALSE)

# get rid of activityID column
drops <- c("activityID")
tidySet <- smallLabeled[,!(names(smallLabeled) %in% drops)]
# head(tidySet)

summaryTidy <- aggregate(tidySet,by=list(subject = tidySet$subject,activity = tidySet$activity),mean)
head(summaryTidy)
finalSet <- summaryTidy[,2:82]
head(finalSet)
# write.table(finalSet,"finalSet.txt",col.names=TRUE,row.names=FALSE)
# looks good!
