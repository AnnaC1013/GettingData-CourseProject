#Getting and Cleaning Data Course Project

require(plyr)

#Set directory and get files
UCIHardDir <- "./UCI HAR Dataset"
featuresfile <- paste(UCIHardDir, "./features.txt", sep="")
act_labelsfile <- paste(UCIHardDir, "./act_labels.txt", sep="")
x_trainfile <- paste(UCIHardDir, "./train/X_train.txt", sep="")
y_trainfile <- paste(UCIHardDir, "./train/y_train.txt", sep="")
subject_trainfile <- paste(UCIHardDir, "./train/subject_train.txt", sep="")
x_testfile <- paste(UCIHardDir, "./test/x_test.txt", sep="")
y_testfile <- paste(UCIHardDir, "./test/y_test.txt", sep="")
subject_testfile <- paste(UCIHardDir, "./test/subject_test.txt", sep="")

#Load raw data
features <- read.table(featuresfile, colClasses=c("character"))
act_labels <- read.table(act_labelsfile, col.names=c("ActivityId", "Activity"))
x_train <- read.table(x_trainfile)
y_train <- read.table(y_trainfile)
subject_train <- read.table(subject_trainfile)
x_test <- read.table(x_testfile)
y_test <- read.table(y_testfile)
subject_test <- read.table(subject_testfile)
  

#1. Merges the training and test sets to create one data set
#Binding sensor data

training_sensordata <- cbind(cbind(x_train, subject_train), y_train)
test_sensordata <- cbind(cbind(x_test, subject_test), y_test)
sensordata <- rbind(training_sensordata, test_sensordata)

#Label columns

sensor_labels <- rbind(rbind(features, c(562, "Subject"), c(563, "ActivityId")))[,2]
names(sensordata) <- sensor_labels

#2. Extract only the measurements on the mean and SD for each measurement

sensordata_mean_sd <- sensordata[,grepl("Subject|ActivityId|mean|std", names(sensordata))]

#3. Use descriptive activity names to name the activities in the data set

sensordata_mean_sd <- join(sensordata_mean_sd, act_labels, by="ActivityId", match="first")
sensordata_mean_sd <- sensordata_mean_sd[,-1]

#4. Appropriately label the data set with descriptive variable names

#Remove parentheses
names(sensordata_mean_sd) <- gsub('\\(|\\)', "", names(sensordata_mean_sd))

#Make proper names
names(sensordata_mean_sd) <- make.names(names(sensordata_mean_sd))

#Clarify names
names(sensordata_mean_sd) <- gsub('Acc', "Acceleration", names(sensordata_mean_sd))
names(sensordata_mean_sd) <- gsub('Gyro', "AngularSpeed", names(sensordata_mean_sd))
names(sensordata_mean_sd) <- gsub('Mag', "Magnitude", names(sensordata_mean_sd))
names(sensordata_mean_sd) <- gsub('^t', "TimeDomain", names(sensordata_mean_sd))
names(sensordata_mean_sd) <- gsub('^f', "FrequencyDomain", names(sensordata_mean_sd))
names(sensordata_mean_sd) <- gsub('\\.mean', ".Mean", names(sensordata_mean_sd))
names(sensordata_mean_sd) <- gsub('\\.std', ".StandardDeviation", names(sensordata_mean_sd))
names(sensordata_mean_sd) <- gsub('Freq\\.', "Frequency.", names(sensordata_mean_sd))
names(sensordata_mean_sd) <- gsub('Freq$', "Frequency", names(sensordata_mean_sd))

##5. From 4., Create a second, tidy data set with average of each variable 
##    for each activity and each subject

tidyData = ddply(sensordata_mean_sd, .(Subject, Activity), numcolwise(mean))
write.table(tidyData, file = "tidyData.txt")

##6. Check for success

View(tidyData)
