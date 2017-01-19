# title: "Data Wrangling 2"
# author: "Leigh Fonseca"
# date: "2017-01-18"


# library(tidyr)
library(dplyr)

# Load CSV file and create a data frame
titanic_original <- read.csv("~/workspace/found_data_sci/data_wrangling_2/titanic_original.csv", head= TRUE, sep = ",",blank.lines.skip = TRUE, strip.white = TRUE, na.strings=c("NA","NaN", ""," "))
titanic <- tbl_df(titanic_original)
# str(titanic)

# 1: Port of embarkation

replace_embark <- function(x) {
  x[sapply(x, is.na)] <-"S"
  return(x)
}
titanic$embarked <- replace_embark(titanic$embarked)
#titanic$embarked

# 2: Age - replace NA with mean

titanic$age <- ifelse(is.na(titanic$age), mean(titanic$age, na.rm = TRUE),titanic$age)
#titanic$age 

# 3: Lifeboat - replace NA with a dummy value: NB - no boat

titanic$boat <- ifelse(is.na(titanic$boat), "NB", titanic$boat)
#titanic$boat

# 4: Cabin - Many passengers don’t have a cabin number. Create a new column has_cabin_number
titanic$has_cabin_number <-as.numeric(!is.na(titanic$cabin))
#titanic$has_cabin_number

write.csv(titanic, file="titanic_clean.csv")

