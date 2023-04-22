# Getting-and-Cleaning-Data-Project

This is the submission for the Getting and Cleaning Data Final Project. Produced by myself, Francis Iloanya

The repo contains all the necessary files.

- This README.md
- The final data in the form required, named FinalData.txt
- The codebook as required.
- The R script that produces the data, named run_analysis.R

The R Script does the following;
1. Reads in the files as tables, test and train data, as well as generic features and activity lists (as tables) - using appropriate column names. Then merges test and train data
2. Using piping, keeps only relevant columns, 
3. Appends on activity names using common variable 'code'
4. Changes naming convention of features using series of gsub expressions
5. From this dataset, produces a final dataset of averages - first grouping by subject and activity

Finally the tidy dataset is output as FinalData.txt
