SCRIPT run_analysis.R

Scope: To create a Tidy data set and answer the 5 questions of the Course project for the module "Getting and Cleaning Data"

Questions answered:
1 Merges the training and the test sets to create one data set.
2 Extracts only the measurements on the mean and standard deviation for each measurement. 
3 Uses descriptive activity names to name the activities in the data set
4 Appropriately labels the data set with descriptive variable names. 
5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

Inputs files:
1 train/x_train.txt
2 test/x_test.txt
3 train/y_train.txt
4 test/y_test.txt
5 activity_labels.txt
6 features.txt

Output files:
1. FinalTable.txt
2. TidySummaryTable.txt

Libraries used:
1. dplyr

Script Description:
1. Initially the script reads the input files and loads the dplyr library.
2. The y_train and y_test file have codes for each ativity so the next functions are matching these codes with the actual activities by looking in the "activity_labels" file.
3. y_train file and x_train file have the same number of rows. The first one has the activities and the second has the data set. So the script adds a new column called "Activity" 
in the data set table. This new column is actually the column from the y_train file that now has the actual activity names.
4. The script repeats the same function for the test dataset.
5. Then, it adds a new column in both the test and train data set that is called "SourceFile" and shows the name of the source file. 
By performing this action we will be able in the future if we wish to split the finaltable.
6. It merges the train and test datasets by adding more rows and naming the table "MergedTable".
7. By using the names of the "features" file it names every column of the merged table apart from the last two that are already called "Activity" and "SourceFile".
8. It creates the first output file that is called "FinalTable" and it has the SourceFile, Activity columns and all the columns from the MergedTable
that have the words "mean()" and "std()" in their title.
9. Finally, it creates the "TidySummaryTable" that has all the columns apart from the "SourceFile" column with the average of each variable for each activity.
The names of this table have the word "Average " at the beginning of all the mean and std columns.

