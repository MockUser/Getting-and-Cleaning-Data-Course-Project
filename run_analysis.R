# Requires
require(utils)
require(plyr)
require(data.table)

# Download the files
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "data.zip", method="auto")

# Unzip files
unzip(zipfile = "data.zip")

# Load the files
features <- read.table("UCI HAR Dataset/features.txt")
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
xTest <- read.table("UCI HAR Dataset/test/X_test.txt")
xTrain <- read.table("UCI HAR Dataset/train/X_train.txt")
yTest <- read.table("UCI HAR Dataset/test/y_test.txt")
yTrain <- read.table("UCI HAR Dataset/train/y_train.txt")
subTest <- read.table("UCI HAR Dataset/test/subject_test.txt")
subTrain <- read.table("UCI HAR Dataset/train/subject_train.txt")

# 1. Merge the training and the test sets to create one data set
sensorData <- rbind(xTest, xTrain)
activityData <- rbind(yTest, yTrain)
subjectData <- rbind(subTest, subTrain)

# Assign column names
names(sensorData) <- features[,2]
names(activityData) <- "activity"
names(subjectData) <- "subject"

# Merge data sets all together
completeData <- cbind(sensorData, cbind(activityData, subjectData))

# 2. Extract only the measurements on the mean and standard deviation for each measurement
meanstdData <- completeData[,grep("mean\\(\\)|std\\(\\)|activity|subject", names(completeData))]

# 3. Use descriptive activity names to name the activities in the data set
# Convert the activity factor to character
meanstdData$activity <- as.character(meanstdData$activity)

# Update the activity value to the activity name
for(i in 1:nrow(activities)){
    meanstdData$activity[meanstdData$activity == i] <- as.character(activities[i,2])
}

# Convert back the character to factor
meanstdData$activity <- as.factor(meanstdData$activity)

# 4. Appropriately label the data set with descriptive variable names
names(meanstdData) <- gsub('\\.mean',".Mean",names(meanstdData))
names(meanstdData) <- gsub('\\.std',".StandardDeviation",names(meanstdData))
names(meanstdData) <- gsub('^f',"Frequency",names(meanstdData))
names(meanstdData) <- gsub('^t',"Time",names(meanstdData))
names(meanstdData) <- gsub('Acc',"Acceleration", names(meanstdData))
names(meanstdData) <- gsub('Gyro',"AngularSpeed",names(meanstdData))
names(meanstdData) <- gsub('Mag',"Magnitude",names(meanstdData))
names(meanstdData) <- gsub('GyroJerk',"AngularAcceleration",names(meanstdData))
names(meanstdData) <- gsub('\\(|\\)',"",names(meanstdData), perl = TRUE)

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
# Create the tidy data for each activity and subject
tidyData <- ddply(meanstdData, .(activity, subject), numcolwise(mean))

# Write the file without row names
write.table(tidyData, "tidyData.txt", row.names = FALSE)
