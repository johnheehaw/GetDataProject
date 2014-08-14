setwd("d:/data/")

subject_test <- read.table("D:/data/UCI HAR Dataset/test/subject_test.txt", quote="\"")
# View(subject_test)
names(subject_test) <- "subject"

# table(subject_test)
# subject_test
# 2   4   9  10  12  13  18  20  24 
# 302 317 288 294 320 327 364 354 381 

X_test <- read.table("D:/data/UCI HAR Dataset/test/X_test.txt", quote="\"")
features <- read.table("D:/data/UCI HAR Dataset/features.txt", quote="\"")
names(X_test) <- features[,2]
# View(X_test)

y_test <- read.table("D:/data/UCI HAR Dataset/test/y_test.txt", quote="\"")
names(y_test) <- "activity"
# View(y_test)

# table(y_test)
# y_test
# 1   2   3   4   5   6 
# 496 471 420 491 532 537 

test <- cbind(subject_test,X_test,y_test)

subject_train <- read.table("D:/data/UCI HAR Dataset/train/subject_train.txt", quote="\"")
View(subject_train)
names(subject_train) <- "subject"

# table(subject_train)
# subject_train
# 1   3   5   6   7   8  11  14  15  16  17  19  21  22  23  25  26  27  28  29  30 
# 347 341 302 325 308 281 316 323 328 366 368 360 408 321 372 409 392 376 382 344 383 

X_train <- read.table("D:/data/UCI HAR Dataset/train/X_train.txt", quote="\"")
# view(X_train)
features <- read.table("D:/data/UCI HAR Dataset/features.txt", quote="\"")
names(X_train) <- features[,2]
View(X_train)

y_train <- read.table("D:/data/UCI HAR Dataset/train/y_train.txt", quote="\"")
names(y_train) <- "activity"
View(y_train)
# table(y_train)
# y_train
# 1    2    3    4    5    6 
# 1226 1073  986 1286 1374 1407

train <- cbind(subject_train,X_train,y_train)
# ad(train[c(1,2,563)])

# concatenate two datasets
table(train$subject)
table(test$subject)

combined <- rbind(train,test)
table(combined$subject)
# works!

# keep only mean and std measurements
head(combined[,c(1,563)])

names(combined)==
