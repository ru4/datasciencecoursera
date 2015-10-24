require("reshape2")

#set the data path
dataSetPath <- "UCI HAR Dataset"

#load the data int data.table
xTrain <- read.table(file=paste(dataSetPath,"/train/","X_train.txt",sep=""),header=FALSE)
xTest  <- read.table(file=paste(dataSetPath,"/test/","X_test.txt",sep=""),header=FALSE)
yTrain <- read.table(file=paste(dataSetPath,"/train/","y_train.txt",sep=""),header=FALSE)
yTest  <- read.table(file=paste(dataSetPath,"/test/","y_test.txt",sep=""),header=FALSE)
sTrain <- read.table(file=paste(dataSetPath,"/train/","subject_train.txt",sep=""),header=FALSE)
sTest  <- read.table(file=paste(dataSetPath,"/test/","subject_test.txt",sep=""),header=FALSE)

#load the fetures file to assign lables to names to training and testing radings
features <- read.table(file=paste(dataSetPath,"features.txt",sep="/"),header=FALSE)

names(xTrain) <- features[,2]
names(xTest)  <- features[,2]
names(yTrain) <- "Class_Label"
names(yTest)  <- "Class_Label"
names(sTest)  <- "SubjectID"
names(sTrain) <- "SubjectID"

#now we merge the training with testing dataset
xData <- rbind(xTrain, xTest)
yData<- rbind(yTrain, yTest)
sData <- rbind(sTrain, sTest)

#we delete the unused dataset to free memory
xTrain=NULL
xTest=NULL
yTrain=NULL
yTest=NULL
sTrain=NULL
sTest =NULL

#unify all part
data <- cbind(xData, yData, sData)

#we will only subest the reqiured data (mean and standard deviation )
matchCols <- grep("mean|std|Class|Subject", names(data))
data <- data[,matchCols]

#give descriptive activity names to name the activities
#in data set using activity_labels.txt
activityNames <- read.table(file=paste(dataSetPath,"activity_labels.txt",sep="/"),header=FALSE)
names(activityNames) <- c("Class_Label", "Class_Title")
data <- merge(x=data, y=activityNames, by="Class_Label" )

#give descriptive variable names the Data and clean unwanted variables
names(data) <- gsub(pattern="[-]", replacement="_", names(data))
names(data) <- gsub(pattern="[()]", replacement="", names(data))
data <- data[,!(names(data) == "Class_Label" )]


#we melt the data and then cast it  to get the average 
#of each variable for each activity and each subject
melteddataset <- melt(data=data, id=c("SubjectID", "Class_Title"))
tidyData <- dcast(data=melteddataset, SubjectID + Class_Title ~ variable, mean)

#finally we rite the file
write.table(tidyData, file="TidyDataSet.txt", row.names=FALSE)
