
# Packages
library(dplyr)

# Set working direction
setwd("~/IODS-project/data")

# Read the data files
studentPor <- read.csv(file = "student-por.csv", sep = ";")
studentMat <- read.csv(file = "student-mat.csv",  sep = ";")

# Dimensions of the data
dim(studentPor)
dim(studentMat)

# Summaries and structures of the data.
summary(studentPor)
summary(studentMat)
str(studentPor)
str(studentMat)

# Variables for the merged data
vars <- c("school", "sex", "age", "address", "famsize", "Pstatus", "Medu", "Fedu", "Mjob", "Fjob", "reason", "nursery","internet")

#Merge
mergedData <- merge(studentPor, studentMat, by = vars)

# Dimensions, summary, and structure
dim(mergedData)
summary(mergedData)
str(mergedData)

# Data containing variables used in merge
data <- select(mergedData, one_of(vars))

# Vector not used in merge 
notjoined_columns <- colnames(studentMat)[!colnames(studentMat) %in% vars]

# For-loop
for(column_name in notjoined_columns) {
  # Variables measuring same thing
  two_columns <- select(mergedData, starts_with(column_name))
  # take the first of these two variables
  first_column <- select(two_columns, 1)[[1]]
  
  # if that first column vector is numeric...
  if(is.numeric(first_column)) {
    # Average
    data[column_name] <- round(rowMeans(two_columns))
  } else { 
    # take the first variable in not numeric 
    data[column_name] <- first_column
  }
}

# Alcohol consumption variable
data <- mutate(data, alc_use = (Dalc + Walc) / 2)

# Indicator taking value 1 if alcohol consumption > 2 
data <- mutate(data, high_use = alc_use > 2 )

# Check
dim(data)
summary(data)

# Save
write.csv(data , file = "joinedData.csv")
