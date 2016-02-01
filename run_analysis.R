library(data.table)
library(dplyr)

#Check if file exists and download it into data directory, unzip the file.
url<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
name<-"Dataset.zip"
if(!file.exists("dataForProject")){
        dir.create("dataForProject")
        download.file(url,file.path("dataForProject",name))
        unzip(file.path("dataForProject",name))
}

#Read in the files from the unzipped directory
path<-file.path("UCI HAR Dataset")

#Read in Subject files
dfsubTrain<-data.table(read.table(file.path(path,"train","subject_train.txt")))
dfsubTest<-data.table(read.table(file.path(path,"test","subject_test.txt")))

#Read in Activity ID files
dfIDTrain<-data.table(read.table(file.path(path,"train","y_train.txt")))
dfIDTest<-data.table(read.table(file.path(path,"test","y_test.txt")))

#Read in Activity DataSets
dfActTrain<-data.table(read.table(file.path(path,"train","X_train.txt")))
dfActTest<-data.table(read.table(file.path(path,"test","X_test.txt")))

#Read in Feautures DataSet
dffeat<-data.table(read.table(file.path(path,"features.txt")))

#Read in Activity_Labels dataset 
dfLabel<-data.table(read.table(file.path(path,"activity_labels.txt")))


#Merge all of the datasets together to form one large dataset
#First merge equivalent train and test of each using rbind

dfsub<-rbind(dfsubTrain,dfsubTest)
setnames(dfsub,"V1","subject")
dfID<-rbind(dfIDTrain,dfIDTest)
setnames(dfID,"V1","activityLabel")
df<-rbind(dfActTrain,dfActTest)

#Now only include mean() and std() variables using the labels from the features dataset
names(df)<-as.character(dffeat[[2]])
meanstdCols<-grep("mean\\(\\)|std\\(\\)",dffeat[[2]])
df<-select(df,meanstdCols)

#Replace the ID in activityLabel descriptive activity titles (WALKING, LAYING, etc.) to dfID
#Clean up by using lower case, removing "_", and capitalizing the first letter
#of any second word.
dfID$activityLabel<-tolower(dfLabel[[2]][dfID$activityLabel])
dfID$activityLabel<-gsub("_u","U",dfID$activityLabel)
dfID$activityLabel<-gsub("_d","D",dfID$activityLabel)


#Merge all of the datasets together to create one dataset using cbind().
dfSubID<-cbind(dfsub,dfID)
df<-cbind(dfSubID,df)

#Create ID using subject and the activity label
id_label=c("subject","activityLabel")

#Measurement labels,
Meas_labels<-setdiff(names(df),id_label)

#Melt to create a long dataset with the id, the measurement, and the value.
melt_df<-melt(df,id=id_label,meas.vars=Meas_labels)

#Now create tidy dataset with average of each variable for each subject and activity.
tidy_df<-dcast(melt_df,subject+activityLabel~variable, mean)

#Create descriptive variable labels.
#Replace t with time and f with freq, remove "-" and "()", capitalize mean and std.
names(tidy_df)<-gsub("^f","freq",names(tidy_df))
names(tidy_df)<-gsub("^t","time",names(tidy_df))
names(tidy_df)<-gsub("-","",names(tidy_df))
names(tidy_df)<-gsub("mean()","Mean",names(tidy_df))
names(tidy_df)<-gsub("std()","Std",names(tidy_df))
names(tidy_df)<-gsub("\\(\\)","",names(tidy_df))

#Write tidy dataset to table
write.table(tidy_df, file = "./tidy_data.txt",row.names = FALSE)
