
# dataset download
zipfile <- "dataset.zip"
datafolder <- "UCI HAR Dataset"
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

if(!file.exists(datafolder)){
  download.file(url, zipfile, method = "curl")
  unzip(zipfile)
}

# load data
features <- read.csv(paste(datafolder,'/features.txt',sep=""), sep=' ', header=FALSE, stringsAsFactors=FALSE)[, 2]
activities <- read.csv(paste(datafolder,'/activity_labels.txt',sep=""), sep=' ', header=FALSE, stringsAsFactors=FALSE)

xTest <- read.table(paste(datafolder,'/test/X_test.txt',sep=""), header=FALSE)
colnames(xTest) <- features
xTrain <- read.table(paste(datafolder,'/train/X_train.txt',sep=""), header=FALSE)
colnames(xTrain) <- features

yTest <- read.csv(paste(datafolder,'/test/y_test.txt',sep=""), header=FALSE)
colnames(yTest) <- "Activity"
yTrain <- read.csv(paste(datafolder,'/train/y_train.txt',sep=""), header=FALSE)
colnames(yTrain) <- "Activity"

yTest$Activity <- factor(yTest$Activity, levels=activities$V1, labels=activities$V2)
yTrain$Activity <- factor(yTrain$Activity, levels=activities$V1, labels=activities$V2)

subjectTest <- read.csv(paste(datafolder,'/test/subject_test.txt',sep=""), header=FALSE)
colnames(subjectTest) <- "Subject"
subjectTrain <- read.csv(paste(datafolder,'/train/subject_train.txt',sep=""), header=FALSE)
colnames(subjectTrain) <- "Subject"

# merge data
xMerged <- rbind(xTest, xTrain)
yMerged <- rbind(yTest, yTrain)
subjectMerged <- rbind(subjectTest, subjectTrain)

# extracts only the mean and standard deviation for each measurement
xMergedMeanSTD <- xMerged[, grep("-mean\\(\\)|-std\\(\\)", features)]

dataMerged <- cbind(yMerged, subjectMerged, xMergedMeanSTD)

# summarise data
library(reshape2)
dataMelt <- melt(dataMerged, id=c("Subject", "Activity"))
dataCast <- dcast(dataMelt, Subject + Activity ~ variable, fun.aggregate=mean)

# save datasets
write.table(dataMerged, file="tidy.csv", sep=",", row.names=FALSE)
write.table(dataCast, file="tidy_summary.csv", sep=",", row.names=FALSE)