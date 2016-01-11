#CodeBook
The codebook that provides the description of the data, varaibles, and any transformations of the data in the run_analysis.r script.

##Original Dataset
Dataset:  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

Description: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

###Dataset Information
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

##Files in the dataset
* 'README.txt'

* 'features_info.txt': Shows information about the variables used on the feature vector.

* 'features.txt': List of all features.

* 'activity_labels.txt': Links the class labels with their activity name.

* 'train/X_train.txt': Training set.

* 'train/y_train.txt': Training labels.

* 'test/X_test.txt': Test set.

* 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

* 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

* 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

* 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

* 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 

**Note: The Inertial Signal files are not included as the instructions for the project were to use the train and test datasets**


##Variables in the dataset

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals timeAcc-XYZ and timeGyro-XYZ. These time domain signals were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (timeBodyAcc-XYZ and timeGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (timeBodyAccJerk-XYZ and timeBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (timeBodyAccMag, timeGravityAccMag, timeBodyAccJerkMag, timeBodyGyroMag, timeBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing freqBodyAcc-XYZ, freqBodyAccJerk-XYZ, freqBodyGyro-XYZ, freqBodyAccJerkMag, freqBodyGyroMag, freqBodyGyroJerkMag. (Note the 'freq' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

* timeBodyAcc-XYZ
* timeGravityAcc-XYZ
* timeBodyAccJerk-XYZ
* timeBodyGyro-XYZ
* timeBodyGyroJerk-XYZ
* timeBodyAccMag
* timeGravityAccMag
* timeBodyAccJerkMag
* timeBodyGyroMag
* timeBodyGyroJerkMag
* freqBodyAcc-XYZ
* freqBodyAccJerk-XYZ
* freqBodyGyro-XYZ
* freqBodyAccMag
* freqBodyAccJerkMag
* freqBodyGyroMag
* freqBodyGyroJerkMag

In this code, only the mean and standard deviation of the signals are selected and reported.  These variables have a suffix of Mean or Std respectively.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

* gravityMean
* tBodyAccMean
* tBodyAccJerkMean
* tBodyGyroMean
* tBodyGyroJerkMean

There are 30 test subjects, ranging from 1-30.  The average of each measurement for the 6 activities (laying, sitting, standing, walking, walkingDownstairs, walkingUpstairs) for each of the subjects is included in the tidy dataset.

##Transformations

1. If there is no directory called data, a data directory is created.  Then the file is downloaded and unzipped.
2. Merges the equivalent train and test files using rbind()
3. Selects only the columns from dataset which include the variable name mean(mean()) or standard deviation (std()) using "features.txt" and select().
4. Gets descripitive activity names from "activity_labels.txt" in place of the activity id.  Removes "_" and replaces and captialize the letter of any second word.
5. Merge each of the subject, activity label, and activity datasets using cbind().
6. Creates a second, indepedent tidy dataset with the average of each variable for each of the subjects and activities.
7. Clean up variable names by using gsub to change prefix "t" to time and "f" to freq, removing "-", capitalizing mean and std, and removing "()".
8. Write the tidy dataset to tidy_data.txt.

##Running the code
The code assumes the data.table and dplyr packages have been installed.  To run the code just:

1. Copy the repo to your local directory.
2. Run source("run_analysis.r").
