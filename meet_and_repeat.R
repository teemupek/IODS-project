# Read the BPRS data
BPRS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/BPRS.txt", sep  =" ", header = T)

# Look at the (column) names of BPRS
names(BPRS)

# Look at the structure of BPRS
str(BPRS)

# Print out summaries of the variables
summary(BPRS)

# The data BPRS is available

# Access the packages dplyr and tidyr
library(dplyr)
library(tidyr)

# Factor treatment & subject
BPRS$treatment <- factor(BPRS$treatment)
BPRS$subject <- factor(BPRS$subject)

# Convert to long form
BPRSL <-  BPRS %>% gather(key = weeks, value = bprs, -treatment, -subject)

# Extract the week number
BPRSL <-  BPRSL %>% mutate(week = as.integer(substr(weeks,5,5)))

# Take a glimpse at the BPRSL data
glimpse(BPRSL)

# Set the working directory
setwd("/Users/teemupekkarinen/IODS-project/data")

# Save the working data set
write.csv(BPRSL,"BPRSL")

############################################################################################

# Read the RATS data
RATS <- read.table("https://raw.githubusercontent.com/KimmoVehkalahti/MABS/master/Examples/data/rats.txt", sep  ="", header = T)

# Look at the (column) names of RATS
names(RATS)

# Look at the structure of RATS
str(RATS)

# Print out summaries of the variables
summary(RATS)

# Factor ID & Group
RATS$ID <- factor(RATS$ID)
RATS$Group <- factor(RATS$Group)

# Convert to long form
RATSL <-  RATS %>% gather(key = Times, value = Rats, -ID, -Group)

# Extract the week number
RATSL <-  RATSL %>% mutate(Time = as.integer(substr(Times,3,nchar(Times))))

# Take a glimpse at the RATSL data
glimpse(RATSL)

# Save the working data set
write.csv(RATSL,"RATSL")