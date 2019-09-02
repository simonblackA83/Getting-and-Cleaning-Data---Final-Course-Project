#Source of Data
'https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip'

###Getting Data From Local Folder
test_file_x = 'C:/Users/simon/Documents/data/UCI HAR Dataset/test/X_test.txt'
test_file_y = 'C:/Users/simon/Documents/data/UCI HAR Dataset/test/y_test.txt'
test_file_s = 'C:/Users/simon/Documents/data/UCI HAR Dataset/test/subject_test.txt'

x_test = read.table(test_file_x)
y_test = read.table(test_file_y)
s_test = read.table(test_file_s)

train_file_x = 'C:/Users/simon/Documents/data/UCI HAR Dataset/train/X_train.txt'
train_file_y = 'C:/Users/simon/Documents/data/UCI HAR Dataset/train/y_train.txt'
train_file_s = 'C:/Users/simon/Documents/data/UCI HAR Dataset/train/subject_train.txt'

train_x = read.table(train_file_x)
train_y = read.table(train_file_y)
train_s = read.table(train_file_s)

#Merging Test/Train
merged_x = rbind(train_x,x_test)
merged_y = rbind(train_y,y_test)
merged_s = rbind(train_s,s_test)

#Getting activities & features from txt file
#activity names to name the activities in the data set
features = read.table('C:/Users/simon/Documents/data/UCI HAR Dataset/features.txt')
features = features[,2]
features = gsub("[\\(\\)-]", "", features)#Remove Special Charcters
features_vec = as.vector(features)

lables = read.table('C:/Users/simon/Documents/data/UCI HAR Dataset/activity_labels.txt')
lables[,2] = as.character(lables[,2])

library(plyr)
joint_lables = join(merged_y, lables, 
                    by = 'V1', type = "left", match = "all")#match IDs and activity

#Appropriately labels the data set with variable names
features_vec = gsub("mean", "Mean", features_vec)
features_vec = gsub("std", "StandardDeviation", features_vec)

names(merged_x) = features_vec

#Extract only measurements for mean/std
m = str_detect(features_vec, 'Mean'); std = str_detect(features_vec, 'StandardDeviation')
names_m = features_vec[m]; names_std = features_vec[std]
names_m_std = c(names_m, names_std)

merged_x = merged_x[names_m_std]

#Convert Full Data Set to Selected
full = cbind(merged_s,joint_lables,merged_x)
extra_lables = c('Subject_ID','Activity_ID','Activity')
names(full)[1:3] = extra_lables

selected_set = cbind(full[,1:3],full[names_m_std])

#Take grouped means
library(tidyverse)
grouped_tidy_means = selected_set %>% 
  group_by(Subject_ID, Activity) %>% 
  summarise_all( mean)

write.csv(grouped_tidy_means, file = "grouped_tidy_means.csv")




