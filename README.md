# Getting and Cleaning Data Course Project
## Merging the training and test data set with different features , activities and subjects and to obtain metrices on the mean and standard deviation related measures

### Common Steps
1. Read the files common to both the training and test datasets, namely the Activity lables and the Features datasets

### Steps Involved in Reading the Test Dataset
1. Read the Test data in X_test.txt
2. Read the type of the activity in Y_test.txt, associated with the Test data read in step 2.
3. Read the subject who performed the activity in subject_test.txt file.
4. Combine the files read in the step 2,3 and 4 so that the data is one single dataframe.
5. To be easily able to read the features and create metrices out of it, unpivot the dataframe obtained in step 5, so that the features are put in rows instead of column. This makes working with it a lot easier. After this step, all the features would be in rows in the column FeatureID.
6. Clean the FeatureID column (removing the v) so that it can be merged with the Features master file (read in the common steps), to also have the Feature Name in the dataframe.
7. Merge the dataframe with the Features and Activity labels dataframes , so that now both the Activity Labels and Feature names are in one single dataframe.
8. Filter out the features which are not derived from mean or standard deviation.
9. Add a column which states that this is the Test dataset. This will come in handy while merging this dataset with the training dataset.

### Steps Involved in Reading the Training Dataset
1. Read the training data in X_train.txt
2. Read the type of the activity in Y_train.txt, associated with the Training data read in step 2.
3. Read the subject who performed the activity in subject_train.txt file.
4. Combine the files read in the step 2,3 and 4 so that the data is one single dataframe.
5. To be easily able to read the features and create metrices out of it, unpivot the dataframe obtained in step 5, so that the features are put in rows instead of column. This makes working with it a lot easier. After this step, all the features would be in rows in the column FeatureID.
6. Clean the FeatureID column (removing the v) so that it can be merged with the Features master file (read in the common steps), to also have the Feature Name in the dataframe.
7. Merge the dataframe with the Features and Activity labels dataframes , so that now both the Activity Labels and Feature names are in one single dataframe.
8. Filter out the features which are not derived from mean or standard deviation.
9. Add a column which states that this is the training dataset. This will come in handy while merging this dataset with the test dataset.

### Merge the Training and Test datasets
1. Merge the 2 datasets obtained above using the rbind function. This simply puts all the rows associated with both the datasets in one single dataframe. The Type column that was introduced earlier can be used to distinguish between the two datasets

### Aggregate Data
1. Aggregate the data obtained after the merge in the step obove, using the agrregate function. The by parameters would be the SubjectID , ActivityID and the FeatureID

### Write the output to a file
1. Write the output of the aggregate obtained above to a file named FinalOutput.txt
