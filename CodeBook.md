###Code Book

###Human Activity Recognition Using Smartphones Dataset
Version 1.0

###Study Design

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.


###Variables and Units

Original measurements include-

* Triaxial (X, Y, and Z) acceleration from the accelerometer (total acceleration) and the estimated body acceleration.

* Triaxial Angular velocity from the gyroscope. 

* A 561-feature vector with time and frequency domain variables. 

* Its activity label. 

* An identifier of the subject who carried out the experiment.

Notes:

* Features are normalized and bounded within [-1,1].

* Each feature vector is a row on the text file.


###Summary Choices for Output

In order to run data in the run_analysis.R script, the 'plyr' package must be installed in R.  Step descriptions for the script are preceded with a # sign.  The final dataset is a .txt file that displays the means and standard deviations for the X, Y, and Z measurements for the axial domains of acceleration from the accelerometer and velocity from the gyroscope.  There are 81 columns total, with the first column listing the participant and the second column listing the Activity.  The first half of the remaining columns refer to Time-domain measurements, and the second half refer to the Frequency-domain measurements.