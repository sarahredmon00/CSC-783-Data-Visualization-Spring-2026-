#(1): Create an output log file.
lecture_log <- file("M2_Lecture4and5_Sarah.txt")
#(2): Write console output to the log file
sink(lecture_log, append = TRUE, type = "output")
#(3): Write the currently opened R script to the log file
cat(readChar(
  rstudioapi::getSourceEditorContext()$path,
  file.info(rstudioapi::getSourceEditorContext()$path)$size
))


#
#
#(4): LECTURE CODE

#
# Preparing Data
exam <- read.csv("csv_exam.csv")

#
# head() - Return the first part of an R object
head(exam)
head(exam, 10)

#
# tail() - Return the last part of an R object
tail(exam)
tail(exam, 10)

#
# View() - Invoke a spreadsheet-style data viewer
View(exam)
# CAUTION: The first "V" in View() is an UPPERCASE letter.

#
# dim() - Retrieve the dimension of an R object
dim(exam)

#
# str() - Display the internal structure of a R object
str(exam)

#
# summary() - Display a simple statistics of a R object
summary(exam)

#
# Package (dplyr): Data Manipulation
install.packages("dplyr")   # install dplyr
library(dplyr)              # load dplyr

#
# Create a data frame with two variables
df_raw <- data.frame(var1 = c(1, 2, 1),
                     var2 = c(2, 3, 2))
df_raw

#
# Create a copy of data frame
df_new <- df_raw
df_new

#
# Modify a column name
df_new <- rename(df_new, v2 = var2)
df_new
# CAUTION: In rename(), set "new variable name" = "old variable name".

#
# Comparison before and after modified the second column name using rename()
df_raw
df_new

#
# Create derived variables
df <- data.frame(var1 = c(4, 3, 8),
                 var2 = c(2, 6, 1))
df

#
# Create derived variable, Sum
df$var_sum <- df$var1 + df$var2
df

#
# Create a derived variable, Mean
df$var_mean <- (df$var1 + df$var2) / 2
df

#
# Create derived variables using conditional statements
mpg <- as.data.frame(ggplot2::mpg)
mpg$total <- (mpg$cty + mpg$hwy) / 2
summary(mpg$total)  # show a basic descriptive statistics
hist(mpg$total)     # create a histogram

#
# Create a decision variable from a conditional statement
# If greater than 20, pass, otherwise, fail:
mpg$test <- ifelse(mpg$total >= 20, "pass", "fail")
head(mpg, 20)

#
# View the number of vehicles that have been passed fuel efficiency
# by the frequency chart
table(mpg$test) # Create a contingency table of the counts at the feature

#
# Plot a frequency bar graph
library(ggplot2)  # load ggplot2
qplot(mpg$test)   # draw a quick plot (fuel's pass/fail vs fuel frequency)

#
# Create a variable using nested conditional statements
# Assign three ratings (A, B, C) to grade:
mpg$grade <- ifelse(mpg$total >= 30, "A",
                    ifelse(mpg$total >= 20, "B", "C"))
head(mpg, 20)
# CAUTION: ifelse() is repeated twice. Don't forget two opening brackets
# and two closing brackets and two commas each.

#
# Create a frequency chart and bar graph
table(mpg$grade)
qplot(mpg$grade)

#
# Create as many rating as you want
# Assign four ratings (A, B, C, D) to grade:
mpg$grade2 <- ifelse(mpg$total >= 30, "A",
                     ifelse(mpg$total >= 25, "B",
                            ifelse(mpg$total >= 20, "C", "D")))

#
# Extract the data that matches the condition
# Load the package dplyr and import data:
library(dplyr)
exam <- read.csv("csv_exam.csv")
exam

#
# Extract and print only if class is 1 in exam
exam %>% filter(class == 1)
# NOTE: Shortcut key (Command+Shift+M) inputs %>%

#
# Extract and print only if class is 2 in exam
exam %>% filter(class == 2)

#
# Extract and print only if class is NOT 1 in exam
exam %>% filter(class != 1)

#
# Extract and print only if math is greater than 50 in exam
exam %>% filter(math > 50)

#
# Extract and print only if math is less than 50 in exam
exam %>% filter(math < 50)

#
# Extract and print only if english is greater than or equal to 80 in exam
exam %>% filter(english >= 80)

#
# Extract rows that meet multiple conditions
exam %>% filter(class == 1 & math >= 50)
exam %>% filter(class == 2 & english >= 80)

#
# Extracting rows that meet one or more of the different conditions
exam %>% filter(math >= 90 | english >= 90)
exam %>% filter(english < 90 | science < 50)

#
# Extracting rows that correspond to a column value
exam %>% filter(class == 1 | class == 3 | class == 5)

#
# Operator %in%: identify if an element belongs to a vector
exam %>% filter(class %in% c(1, 3, 5))

#
# Create data from extracted rows
class1 <- exam %>% filter(class == 1)
class2 <- exam %>% filter(class == 2)
mean(class1$math)
mean(class2$math)


#
#
#(5): Close the log file connection
sink()
close(lecture_log)
#
