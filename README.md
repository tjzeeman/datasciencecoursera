# Datascience Coursera

## Getting and Cleaning Data

The _run\_analysis.R_ script is for the course project for Getting and Cleaning Data.

The script expects the files from the dataset to be extracted to the current working directory. Any and all subdirectories present in the compressed dataset are expected to be there.

Running the script will start with reading all the test and training data files as well as the features.txt and activity_labels.txt files.

The dataset will be reduced to only work with the mean and standard error data points. The meanFreq is explicitly left out being not the mean we're looking for.
In the process the column names are replaced with more meaningful ones based on the names used in the features table.

The test and training data is then combined and the activity name is added for human readability.

Finally the script should group the data per activity and subject and calculate an average for each.