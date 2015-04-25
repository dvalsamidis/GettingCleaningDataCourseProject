
#Read the train and test data
TrainData <- read.table("train/x_train.txt")
TestData <- read.table("test/x_test.txt")
TrainLabelCodes <- read.table("train/y_train.txt")
TestLabelCodes <- read.table("test/y_test.txt")
LabelNames <- read.table("activity_labels.txt")
ColumnNames <- read.table("features.txt")

#Load dplyr library
library(dplyr)


#Adding a new column with the Label codes translated in names from the LabelNames table
#The name of the column is "Activity"
#This answers the 3rd question

TrainData <- mutate(TrainData, Activity=LabelNames[match(TrainLabelCodes[,1],LabelNames[,1]),2])
TestData <- mutate(TestData, Activity=LabelNames[match(TestLabelCodes[,1],LabelNames[,1]),2])


#Adding a new column with the name of the file in the x_train and x_test data
#The column name will be "SourceFile"
#It will be used when we merge the data as a way to differentiate the data 
#between the different source files.

TrainData<-mutate(TrainData, SourceFile = "x_train")
TestData<-mutate(TestData, SourceFile = "x_test")


#Merge the 2 data files Train and Test Data 
MergedTable <-rbind(TrainData,TestData)

#Change tha names of the Merged Table based on the ColumnNames table (features.txt file)
#This will be used for the answer to question 4.
ColumnNames<-rbind(ColumnNames,data.frame(V1=562:563,V2=c("Activity","SourceFile")))
names(MergedTable)<-ColumnNames[,2]

#Create the final Table and remove the unecessary columns
FinalTable<-MergedTable[!duplicated(names(MergedTable))]
FinalTable <- select(FinalTable,SourceFile, Activity, contains("mean()"),contains("std()"))

#Save the Final Table as a new file with the tidy data
write.table(FinalTable,file="FinalTable.txt",row.names=FALSE)

#Answer 5: Second Table with the means for each of the 6 Activities for each column
TidySummaryTable<-select(FinalTable, -SourceFile)
TidySummaryTable<-TidySummaryTable %>% group_by(Activity) %>% summarise_each(funs(mean))

#Adding the "Average" word in every column of the second table
#apart from the first column
for (i in 2:ncol(TidySummaryTable)) colnames(TidySummaryTable)[i]<-paste("Average",colnames(TidySummaryTable)[i],sep=" ")


#Save the Tidy Summary Table as a new file with the tidy data
write.table(TidySummaryTable,file="TidySummaryTable.txt",row.names=FALSE)

