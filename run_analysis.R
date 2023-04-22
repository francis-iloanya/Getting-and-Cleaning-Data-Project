# Assigning data frames 

features <- read.table("./features.txt", col.names = c("n", "functions"))
activities <- read.table("./activity_labels.txt", col.names =  c("code", "activity"))

y_train <- read.table("./y_train.txt", col.names = "code")
x_train <- read.table("./x_train.txt", col.names = features$functions)
subject_train <- read.table("./subject_train.txt", col.names = "subject")

y_test <- read.table("/Users/francisiloanya/Desktop/Data Science Specialisation/Getting and Cleaning Data/UCI HAR Dataset/test/y_test.txt", col.names = "code")
x_test <- read.table("/Users/francisiloanya/Desktop/Data Science Specialisation/Getting and Cleaning Data/UCI HAR Dataset/test/x_test.txt", col.names = features$functions)
subject_test <- read.table("/Users/francisiloanya/Desktop/Data Science Specialisation/Getting and Cleaning Data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")       

# stitch train and test on top of each other for data, labels, and subject (ID)

x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
id <- rbind(subject_train, subject_test)

# merge the dfs together side by side, IDs, then labels, then actual data then keep only mean and std columns, then merge on activity names

TidyData <- cbind(id, y, x) %>% 
                as_tibble() %>% 
                        select(contains(c("subject", "code", "mean", "std"))) %>%
                                join(activities, "code") %>% 
                                        as_tibble() %>%
                                                relocate("activity", .after = "code") %>%
                                                        select(-"code")
        

names(TidyData)<- gsub("subject", "Subject", names(TidyData))
names(TidyData)<- gsub("activity", "Activity", names(TidyData))
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("tBody", "TimeBody", names(TidyData))
names(TidyData)<-gsub("-mean()", "Mean", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-std()", "STD", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("-freq()", "Frequency", names(TidyData), ignore.case = TRUE)
names(TidyData)<-gsub("angle", "Angle", names(TidyData))
names(TidyData)<-gsub("gravity", "Gravity", names(TidyData))

# Getting averages

FinalData <- TidyData %>%
                group_by(Subject, Activity) %>%
                        summarise_all(funs(mean))
# Writing to folder

write.table(FinalData, "FinalData.txt", row.name=FALSE)