Tidy Data dataset
#**Creating the Tidy Data datasets**#
##Prerequisites to analysis##
1. R Version 3.1.0 with R Studio and the default packages
2. The PlyR package
3. Download the UCI HAR Dataset from [this location](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
4. Place the UCI Har Dataset folder into your working directory and rename it to UCI
5. Modify the features.txt to make sure no variables are duplicated
        *Add -X to the end of features 303-344, -Y to features 382-423 and -Z to features 461-502 to represent that they are measurements on the X, Y & Z axes respectively

##How the script operates##

###Reading the files in###
1. Create 3 data frames from the training datasets using the read.table function. **subj** represents the subject number, **act** represents the activity and **meas** represents the measurements of each variable  

---All are done with header=FALSE since there is no header. Act is done with stringsAsFactors=True since they are factors

2. Change the column name for subj to "**Subject_ID**", act to "**Activities**" and meas to "**Measurements**"

---change activities to a factor variable with as.factor and then use the **mapvalues** function from plyr to change the names from numbers to activities based on _activity_labels.txt_

3. Create a features list with the read.table function on features.txt, thus creating the feat dataframe, then remove the first column.

4. Set the column names of meas as the feat dataframe with **colNames**(meas)
5. Bind the columns together using the order subj, meas, act

6. Repeat the process for the test dataset but change the names of each data frame to subj2, meas2 and act2. Features does not have to be re-read.

7. Use rbind to bind the variables together to create a composite dataset called **temp**, then order it by **Subject_ID** using the order command.

##Creating the first tidy dataset##
1. Create a dataframe(**z**) that specifies only the numerical values from temp, columns 3-563.
2. Get the means and standard deviations for each variable by applying the mean and sd function to the columns in **z**, convert it to a data frame and save it under the **means** and **sds** data frames respectively.
3. Bind the **feat**, **means** and **sds** data frames together using the cbind command to create a list of the means and standard devatiations for each variable
4. Write this file into **tidy_data.csv** using the write.csv function

##Creating the second tidy dataset##
1. Create the aggdata dataframe by aggregating **z** according to a list with the **Activities** and **Subject_ID** columns in the temp dataframe and set the function to mean.
    *This gives you the means for each subject by every activity for each feature
2. Clean up the file by switching columns 2 & 1 so that it makes more sense
3. Write this file into **tidy_data2.csv** using the write.csv function
4. Clean up the global environment using the rm() function.