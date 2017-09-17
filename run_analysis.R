library(data.table)
##Datasets common across training and test data sets-Activity and Feature
dtActivityLabels<-fread("activity_labels.txt")
colnames(dtActivityLabels)<-c("ActivityID","ActivityName")
features<-fread("features.txt")
colnames(features)<-c("FeatureID","FeatureName")


####################################Test data##############################################33
#Subject data- who performed the activity
dtSub<-fread(".\\test\\subject_test.txt")
#Proper column names 
colnames(dtSub)<-c("SubjectID")

#Read Testdata file and the corresponding Test activity
dtTest<-fread(".\\test\\x_test.txt")
dtTestActivity<-fread(".\\test\\y_test.txt")
colnames(dtTestActivity)<-c("ActivityID")


##This will ensure that the metrics and the type of Activity along with the subject is in one dataset
dtTest<-cbind(dtSub,dtTest,dtTestActivity)


#Unpivot the data, so the Features are in the rows, so that it is easier to read and perform operations on
dtTestClean<-melt(dtTest,id=c("SubjectID","ActivityID"))

#Give proper column names
colnames(dtTestClean)<-c("SubjectID","ActivityID","FeatureID","Value")

#Clean up the Feature column so that it can be joined to the Feature master set to get the Feature names
dtTestClean$FeatureID<-sub("V","",dtTestClean$FeatureID)
dtTestClean$FeatureID<-as.integer(dtTestClean$FeatureID)

#To merge the Feature name and the Activity Name
dtTestClean<-merge(x=dtTestClean,y=features,by.x="FeatureID",by.y = "FeatureID")
dtTestClean<-merge(x=dtTestClean,y=dtActivityLabels,by.x="ActivityID",by.y = "ActivityID")

#Extracts only the measurements on the mean and standard deviation for each measurement.
dtTestClean<-dtTestClean[grep("std()|mean()", dtTestClean$FeatureName),]

##Indicate this is Test Data which would be handy when we merge this dataset with the training dataset
dtTestClean$Type<-as.String("Test")



################################################Train Data####################################################

###Read the subject and Activity files for the training dataset and assign proper column names
dtTrainSub<-fread(".\\train\\subject_train.txt")
colnames(dtTrainSub)<-c("SubjectID")

dtTrainActivity<-fread(".\\train\\y_train.txt")
colnames(dtTrainActivity)<-c("ActivityID")

######Read the Traning dataset
dtTrain<-fread(".\\train\\x_train.txt")


##This will ensure that the metrics and the type of Activity along with the subject is in one dataset
dtTrain<-cbind(dtTrainSub,dtTrain,dtTrainActivity)

#Unpivot the data, so that it is easier to read
dtTrainClean<-melt(dtTrain,id.vars=c("SubjectID","ActivityID"))

#Give proper column names
colnames(dtTrainClean)<-c("SubjectID","ActivityID","FeatureID","Value")

###Cleanup the Feature variable in the dataset so that it is easier to combine with the master feature dataset
dtTrainClean$FeatureID<-sub("V","",dtTrainClean$FeatureID)
dtTrainClean$FeatureID<-as.integer(dtTrainClean$FeatureID)

#Merge features and Activity, so as to have the corresponding name
dtTrainClean<-merge(x=dtTrainClean,y=features,by.x="FeatureID",by.y = "FeatureID")
dtTrainClean<-merge(x=dtTrainClean,y=dtActivityLabels,by.x="ActivityID",by.y = "ActivityID")

#Extracts only the measurements on the mean and standard deviation for each measurement.
dtTrainClean<-dtTrainClean[grep("std()|mean()", dtTrainClean$FeatureName),]

##Indicate this is Training Data which will be used to merge with the test data and distinguish from the test data
dtTrainClean$Type<-as.String("Train")

####Merge training and Test data

mrg<-rbind(dtTrainClean,dtTestClean)

###Independent tidy data set with the average of each variable for each activity and each subject.

aggregateddata<-aggregate(x=mrg$Value,by=list(Activity=mrg$ActivityName,Feature=mrg$FeatureName,SubjectID=mrg$SubjectID),mean)
colnames(aggregateddata)<-c("Activity","Feature","SubjectID","Value")

##write output to file
write.table(x=aggregateddata,file="FinalOutput.txt",row.names = FALSE)