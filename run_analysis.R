require(plyr)
#Read the first list of subjects into data frame,change variable name to ID & change type to factor
    subj <- read.table("./UCI/train/subject_train.txt", header = FALSE, sep = " ",stringsAsFactors=FALSE)
        colnames(subj)= "Subject_ID"
#Read the list of activity into data frame, label the variable, change type to factor and change the names
    act <- read.table("./UCI/train/y_train.txt", header = FALSE, sep = " ",stringsAsFactors=TRUE)
        colnames(act)= "Activities"
        act$Activities <- as.factor(act$Activities)
        act$Activities <- mapvalues(act$Activities, from = c("1","2","3","4","5","6"), to = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
#Read measurements into data frame and change column headers to reflect measurements
    meas <- read.table("./UCI/train/X_train.txt", header = FALSE, sep = "",stringsAsFactors=FALSE)
        #meas<- sapply(meas,as.numeric)
        feat <- read.table("./UCI/features.txt", header = FALSE, sep = "",stringsAsFactors=FALSE)
                feat <- feat$V2
        colnames(meas)=c(feat)
#Put the first list together
    list1 <- cbind(subj,act,meas)
#Read the second list of subjects into data frame,change variable name to ID & change type to factor
    subj2 <- read.table("./UCI/test/subject_test.txt", header = FALSE, sep = " ",stringsAsFactors=TRUE)
        colnames(subj2)= "Subject_ID"
#Read the list of activity into data frame, label the variable, change type to factor and change the names
    act2 <- read.table("./UCI/test/y_test.txt", header = FALSE, sep = " ",stringsAsFactors=TRUE)
        colnames(act2)= "Activities"
        act2$Activities <- as.factor(act2$Activities)
        act2$Activities <- mapvalues(act2$Activities, from = c("1","2","3","4","5","6"), to = c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
#Read measurements into data frame and change column headers to reflect measurements
    meas2 <- read.table("./UCI/test/X_test.txt", header = FALSE, sep = "",stringsAsFactors=FALSE)
        #meas2<- sapply(meas2,as.numeric)
        colnames(meas2)=c(feat)
#Put the second list together
    list2 <- cbind(subj2,act2,meas2)
#join the lists
    temp<- rbind(list1,list2)
        temp <- temp[order(temp$Subject_ID),]
#Get means and SDs for each measurement
    z<- temp[,3:563]
        means <- as.data.frame(apply(z,2,mean))
        sds <- as.data.frame(apply(z,2,sd))
#Set list of feats as measurements, then combine the data into a list. Finally, clean up.
   feat2<- as.data.frame(feat)
   analysis <- cbind(feat,means,sds)
       row.names(analysis)= NULL
        colnames(analysis)= c("Measurement","Mean","StandardDeviation")
    write.table(analysis,file="tidy_data.txt",sep=" ",row.names=TRUE,col.names=TRUE)
#Divide the data by subject ID and activity
aggdata <-aggregate(z,by=list(Activities=temp$Activities,Subject_ID=temp$Subject_ID),FUN=mean)
#Rearrange the data so it makes more sense logically.
aggdata <- aggdata[,c(2,1,3:563)]
#Write the tidy data file and clean up the global environment
write.table(aggdata,file="tidy_data2.txt",sep=" ",row.names=TRUE,col.names=TRUE)
rm(aggdata,analysis,act,act2,feat2,list1,list2,means,meas,meas2,sds,subj,subj2,temp,feat,z)