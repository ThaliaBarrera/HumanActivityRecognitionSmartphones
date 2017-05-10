# HumanActivityRecognitionSmartphones
One of the most exciting areas in all of data science right now is wearable computing. Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:  http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

# The R script run_analysis.R in this repository does the following:

1.  Merges the training and the test sets to create one data set.
2.  Extracts only the measurements on the mean and standard deviation for each measurement.
      * The variable names of the data set are extracted from the "features.txt" file, and only the columns that are related to mean and standard deviation measurements are kept in the data set. 
3.  Uses descriptive activity names to name the activities in the data set.
      * The activity labels for each observation in the data set are extracted from "y_train.txt" and "y_test.txt" files and  translated to meaningful names.
4.  Appropriately labels the data set with descriptive variable names.
      * The columns that were kept in step 2 are named based on the "feautures.txt" file.
5.  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
      * Two columns are added to the data set, one with the Activity labels, and another one with the Subject. The mean for each column is calculated per activity and per subject, generating another independent data set consisting of 180 rows (30 subjects * 6 activities) and 66 columns (measurements related to mean and std). 
