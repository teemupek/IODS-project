# Teemu Pekkarinen - 014451658
# 2.11.2020
# Exercise 2

# Clear encironment
rm(list = ls())

# Reading the text file from URL
learning2014 <- read.delim("http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS2-data.txt", header = T, sep = "\t")

# Structure of the data
str(learning2014)

# Dimensions of the data
dim(learning2014)

# We have 183 observations for 97 variables. The variables are either integers or numerics. The meta-file gives description for each variables.For instance, variable Gender takes value 1 if the observation is male and 2 if female.

# Subset the data for variables gender, age, attitude, deep, stra, surf and points
vars <- c("Gender", "Age", "Attitude", "Deep", "Stra", "Surf", "Points")
dataset <- learning2014[vars]

# Omit the observations where the exam points variable is zero
dataset2 <- subset(dataset, Points != 0)

# Combination variables
combvar <- c("Attitude","Deep","Stra","Surf")

# Scale the combination variables
dataset2["Attitude"] <- dataset2["Attitude"]/10
dataset2[c("Deep","Surf")] <- dataset2[c("Deep","Surf")]/12
dataset2["Stra"] <- dataset2["Stra"]/8

# Set the working directory
setwd("/Users/teemupekkarinen/IODS-project/data")

# Save the working dataset
write.csv(dataset2,"learning2014")

# Read the data
learning2014 <- read.csv("learning2014",row.names = 1)

# Summary of the working dataset
summary(learning2014)
