CodeBook.md


Overview of the Dataset:

Data was collected from 30 test subjects, who performed 6 activities. A wearable device with embedded sensors (smartphone) captured various datapoints.

Data source:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip


Data files contained in Dataset.zip

    Containing Folder:  "UCI HAR Dataset"
    README.txt
    features_info.txt
    features.txt # contains variable names used
    activity_labels.txt
    X_train.txt
    y_train.txt
    X_test.txt
    y_test.txt
    subject_train.txt
    
    
Variables:

The "Subject" and "Y" files in both the "train" and "test" folders were given the variable names "Subject" and "Activity_ID".  The tidy dataset including only those variable names that included "mean" or "std" as part of the variable name. 


For each record in the dataset, the following information is provided:

    Activity Label
    Triaxial acceleration (accelerometer data) (total acceleration) and and estimate of body acceleration
    Triaxial Angular velocity (gyroscope data)
    A 561-feature vector with time and frequency domain variables
    An identifier of the subject who carried out the experiment

Data Transformations:

The training and test sets were merged to create one data set. From that combined data set, only the mean and standard deviation for each measurement were used.

Descriptive activity names column were then added to this data set and labelled according to 'activity_labels.txt'. The subject column was also added to this data set before proceeding with the calculation of the average of each variable for each activity per subject. This was then all stored in a new data set before having it written out as a text file.




