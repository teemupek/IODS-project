
# Data Wrangling
hd <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv", stringsAsFactors = F)
gii <- read.csv("http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv", stringsAsFactors = F, na.strings = "..")

# Dimensions and structures of the data
dim(hd)
dim(gii)
str(hd)
str(gii)
summary(hd)
summary(gii)

# Column names and two new variables
colnames(hd) <- c("HDI.Rank","Country","HDI","Life.Exp","Edu.Exp","Edu.Mean","GNI","GNI.Minus.Rank")
colnames(gii) <- c("GII.Rank","Country","GII","Mat.Mor","Ado.Birth","Parli.F","Edu2.F","Edu2.M","Labo.F","Labo.M")
gii$Edu2.FM <- gii$Edu2.F / gii$Edu2.M
gii$Labo.FM <- gii$Labo.F / gii$Labo.M

# The join data
human <- merge(hd,gii,by="Country")

# Transform GNI to numeric
human$GNI <- as.numeric(gsub(",","",human$GNI))

# Remove all rows with missing values
# This also removes the observations which relate to regions instead of countries since the non-countries have NA-values
human <- na.omit(human)

# Exclude unneeded variables and define the row names of the data by the country names and remove the country name column from the data
row.names(human) <- human$Country
human <- subset(human,select=c("Edu2.FM", "Labo.FM", "Edu.Exp", "Life.Exp", "GNI", "Mat.Mor", "Ado.Birth", "Parli.F"))

# Set the working directory
setwd("/Users/teemupekkarinen/IODS-project/data")

# Save the working data set
write.csv(human,"human")
