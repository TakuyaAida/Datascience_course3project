run_analysis <- function() {
    # Reading data from datasets
    subjecttest <- read.table("./Data/test/subject_test.txt")
    subjecttrain <- read.table("./Data/train/subject_train.txt")
    xtest <- read.table("./Data/test/X_test.txt")
    xtrain <- read.table("./Data/train/X_train.txt")
    ytest <- read.table("./Data/test/y_test.txt")
    ytrain <- read.table("./Data/train/y_train.txt")
    
    # Reading labels and converting it to a vector
    features <- read.table("./Data/features.txt")
    featureslabel <- features[,2]
    
    # Labeling data frames
    colnames(xtest) <- featureslabel
    colnames(xtrain) <- featureslabel
    colnames(ytest) <- "activity"
    colnames(ytrain) <- "activity"
    colnames(subjecttest) <- "person"
    colnames(subjecttrain) <- "person"
    
    # Merging subject_train, X_train, and y_train, subject_test, X_test, and y_test
    train <- cbind(subjecttrain, xtrain, ytrain)
    test <- cbind(subjecttest, xtest, ytest)

    # Adding label (either train or test) for each dataset. 
    trainlabel <- rep("train", 7352)
    train <- cbind(trainlabel, train)
    colnames(train)[1] <- "train/test"
    testlabel <- rep("test", 2947)
    test <- cbind(testlabel, test)
    colnames(test)[1] <- "train/test"
    
    # Merging all data into one big table called alldata.
    alldata <- rbind(train, test)
    print(dim(alldata))
    
    # Replacing numbers of activities to names of activities
    activitylabel <- read.table("./Data/activity_labels.txt")
    activitylabel <- activitylabel[,2]
    print(activitylabel)
    
    for(i in c(1:10299)) {
        numberofactivity <- alldata[i,564]
        alldata[i,564] <- activitylabel[numberofactivity]
    }
    
    print(head(alldata))
    
    # Creating index of means and stds
    index <- c(seq(1,6,1), seq(41,46,1), seq(81,86,1), seq(121,126,1), seq(161,166,1), 201, 202, 214,215,227,228,240,241,253,254, seq(266,271,1), seq(345,350,1), seq(424,429,1),503,504,516,517,529,530,542,543)
    index <- index + 2
    
    # Subsetting data
    meansandstds <- alldata[,c(1,2,index,564)]
    print(dim(meansandstds))
    
    
}