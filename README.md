# Getting-and-Cleaning-Data---Final-Course-Project
All the used data comes from the source: 'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'
Contained is data in different text files. These include x(measurements), y(activity which is measured) and subject(the test).

The present R script "run_analysis.R" executes the following:

Reads all data including x, y, s(subject), lables(activity).
Merges the test and train data set to a full set (100%) of the x and y data.
Matches the subject_id (simply an integer) with the respective activity.
The activities and their IDs are as follows:

1 WALKING
2 WALKING_UPSTAIRS
3 WALKING_DOWNSTAIRS
4 SITTING
5 STANDING
6 LAYING

Further the script enhances the data set by giving the different variables some meaningfull headings. Thus, abbreviations are modified for readability. E.g. std becomes StandardDeviation.

We extract only measurements which include the 'condition' Mean and Standard Deviation in their variable name. Hence, we only define these ones as relevant.

For the specified relevant data set, we calculate grouped means of each variable considering the activity and subject as groups.
This becomes our output data frame written to a text file again.
