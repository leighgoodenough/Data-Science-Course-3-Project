# Data-Science-Course-3-Project
This repo contains content relating to the 'Getting and Cleaning Data' Course Project

The script that converts the UCI HAR dataset to a tidy dataset containing the averages of mean & stdev values per subject / per activity is contained in the run_analysis_R file.

A codebook pertaining to the dataset is conatined in this repo in the CodeBook.md file.

====
An explanation of how the run_analysis.R script works:

The script is broken into eight sections which are indicated by comments.

Section 1 reads eight data files from the UCI HAR dataset. These contain the test and train data, corresponding subject data, and sets of activity labels and data features.

Section 2 changes the column names of the test and train dataframes to descriptive names, indicating the data measures listed in the features dataframe.

Section 3 converts the numeric activity values to their descriptive labels, in the test_y and train_y dataframes.

Section 4 binds subject and label data to their corresponding measurement data in the test and train dataframes.

Section 5 merges the train and test dataframes together via rbind

Section 6 extracts the mean() and std() measures out of the merged dataframe (taking an extra step to remove meanfreq() measures), and also extract the Subject and Activity data. 

Section 7 binds together the extracted data and their accompanying Subject and Activity values. The resultant tidy data set is named d0.

Section 8 creates the second tidy data set, returning the averages of mean and standard deviation values per subject and per activity - this data set is named d1. The creation of this data set is undertaken by factorising the Subject and Activity columns of d0, and then using split and lapply to create a new data set (d1) where the mean (average) of values per Subject per Activity are tabulated.
