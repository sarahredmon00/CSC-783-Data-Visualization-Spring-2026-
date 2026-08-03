#(1): Create an output log file.
lecture_log <- file("M4_SarahRedmon.txt")
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
# PART 6
#
# Finding "NA" in dataset
#   Create a data with NA's
df <- data.frame(sex = c("M", "F", NA, "M", "F"),
                 score = c(5, 4, 3, 4, NA))
df
# Caution: No double quotation marks before and after NA.

#   Check NA's
is.na(df)
table(is.na(df))

#   Check NA's by Variable
table(is.na(df$sex))
table(is.na(df$score))

#   Analyze data with "NA"
mean(df$sex)
mean(df$score)

#
# Removing "NA" in dataset
#   Remove missing rows (i.e., a row with "NA")
library(dplyr)
df %>% filter(is.na(score))
df %>% filter(!is.na(score))

#
# Analyze with data excluding missing values
df_nomiss <- df %>% filter(!is.na(score))
mean(df_nomiss$score)
sum(df_nomiss$score)

#
# Extracting data without missing data at the same time for multiple variables
df_nomiss <- df %>% filter(!is.na(score) & !is.na(sex))
df_nomiss
df_nomiss2 <- na.omit(df)
df_nomiss2

#
# Use an internal function to delete "NA" - na.rm = T
mean(df$score, na.rm = T)
sum(df$score, na.rm = T)

#
# Use an internal function, na.rm = T into summarise() or summarize()
exam <- read.csv("csv_exam.csv")
exam[c(3, 8, 15), "math"] <- NA
exam %>% summarize(mean_math = mean(math))
exam %>% summarize(mean_math = mean(math, na.rm = T))

#
# Use "NA" - na.rm = T to other functions
exam %>% summarize(mean_math = mean(math, na.rm = T),
                   sum_math = sum(math, na.rm = T),
                   median_math = median(math, na.rm = T))

#
# Replace the symbol "NA" with Average
#   Calculate an average
mean(exam$math, na.rm = T)
exam$math <- ifelse(is.na(exam$math), 55, exam$math)
table(is.na(exam$math))
exam
mean(exam$math)

#
# Removing Outliers
#   Assume that sex 3 and score 6 are denoted as an outlier
outlier <- data.frame(sex = c(1, 2, 1, 3, 2, 1),
                      score = c(5, 4, 3, 4, 2, 6))
outlier
table(outlier$sex)
table(outlier$score)

#
# Handling an outlier
#   Replacing "3" with "NA"
outlier$sex <- ifelse(outlier$sex == 3, NA, outlier$sex)
outlier

#   If a score is not between 1 and 5, replace it with "NA"
outlier$score <- ifelse(outlier$score > 5, NA, outlier$score)
outlier

#
# Handling an outlier without "NA"
outlier %>%
  filter(!is.na(sex) & !is.na(score)) %>%
  group_by(sex) %>%
  summarise(mean_score = mean(score))

#
# Removing an outlier using boxplot
#   Create a boxplot for a hwy in the mpg dataset
mpg <- as.data.frame(ggplot2::mpg)
boxplot(mpg$hwy)

#   Output statistics from a boxplot
boxplot(mpg$hwy)$stats

#   Assign "NA" to hwy if its value is not 12 and 37
mpg$hwy <- ifelse(mpg$hwy < 12 | mpg$hwy > 37, NA, mpg$hwy)
table(is.na(mpg$hwy))

#   Calculate an average of hwy, excluding "NA"
mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy, na.rm = T))

#
# PART 7
#
# Package: ggplot2
#   Scatter Plot - Show the relationship between two sets of data using a dot
library(ggplot2)
mpg <- as.data.frame(ggplot2::mpg)

#   Set a background
ggplot(data = mpg, aes(x = displ, y = hwy))

#   Add a graph
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point()

#   Define a setting (axis range, color, label)
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)

#   Better coding style for readability
#     Use a single line:
ggplot(data = mpg, aes(x = displ, y = hwy)) + geom_point() + xlim(3, 6)
#     Use multiple lines by "+" (Better readability):
ggplot(data = mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30)

#
# EXERCISE
# Load a package, ggplot2 and use 'mpg' and 'midwest' data to solve
# the following questions.
#
# Q1. You need to know what the relationship between 'cty' and 'hwy'
# of the mpg data. Create a scatter plot which set 'cty' as the x-axis
# and 'hwy' as the y-axis.
ggplot(data = mpg, aes(x = cty, y = hwy)) + geom_point()
# Q2. You use the midwest data from the ggplot2 package,
# which contains demographics by region, to find out what the relationship is
# between the entire population and the Asian population. Make a scatter plot
# of the x-axis ('poptotal') and the y-axis ('popasian'). Set only areas
# with a total population of less than 500,000 and an Asian population
# of less than 10,000 to be marked on the scatter plot.
ggplot(data = subset(midwest, poptotal < 500000 & popasian < 10000),
       aes(x = poptotal, y = popasian)) +
  geom_point()

#
# Package: ggplot2
#   Bar Chart - Display data using bars of different heights
library(ggplot2)

#   Average bar chart
library(dplyr)
df_mpg <- mpg %>%
  group_by(drv) %>%
  summarise(mean_hwy = mean(hwy))
df_mpg

#   Create a bar chart (Average bar chart - geom_col())
ggplot(data = df_mpg, aes(x = drv, y = mean_hwy)) + geom_col()

#   Sort by size
ggplot(data = df_mpg, aes(x = reorder(drv, -mean_hwy), y = mean_hwy)) +
  geom_col()

#   Frequency bar chart - geom_bar()
ggplot(data = mpg, aes(x = drv)) + geom_bar()
ggplot(data = mpg, aes(x = hwy)) + geom_bar()

#
# Package: ggplot2
#   Line Graphs:
#     Line Chart - A line graph of data
#     Time Series Chart/Graph - A graph that lines the time series data
#                               that is listed at a certain time interval
library(ggplot2)

#   Line Graph
ggplot(data = economics, aes(x = date, y = unemploy)) + geom_line()

#
# EXERCISE
# Use ggplot2::economics data to solve the following questions.
#
# Q1. Let's see how personal savings rate ('psavert') have changed over time.
# Create a time series graph showing changes in personal savings rate over time.
ggplot(data = economics, aes(x = date, y = psavert)) + geom_line()

#
# PART 8
#
# ggplot2 Box Plot
library(ggplot2)
ggplot(data = mpg, aes(x = drv, y = hwy)) + geom_boxplot()

#
# Prepare for data for data analysis
install.packages("foreign")
library(foreign)
library(dplyr)
library(ggplot2)
library(readxl)
raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)
welfare <- raw_welfare

#
# Data analysis project
#   Check data by simple statistics
head(welfare)
tail(welfare)
View(welfare)
dim(welfare)
str(welfare)
summary(welfare)

#
# Rename variables
#   Check data by simple statistics
welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_region = h10_reg7)

#
# Question 1: Is it different salary by gender?
#
# Check variables
class(welfare$sex)
table(welfare$sex)

#
# Preprocessing
table(welfare$sex)
welfare$sex <- ifelse(welfare$sex == 9, NA, welfare$sex)
table(is.na(welfare$sex))
welfare$sex <- ifelse(welfare$sex == 1, "male", "female")
table(welfare$sex)
qplot(welfare$sex)

#
# Explore a variable "income"
class(welfare$income)
summary(welfare$income)
qplot(welfare$income)
qplot(welfare$income) + xlim(0, 1000)

#
# Preprocessing for outlier in the variable "income"
summary(welfare$income)
welfare$income <- ifelse(welfare$income %in% c(0,9999), NA, welfare$income)
table(is.na(welfare$income))

#
# Create an average income table based on gender
sex_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(sex) %>%
  summarise(mean_income = mean(income))
sex_income

#
# Create a graph using a gender's average income table
ggplot(data = sex_income, aes(x = sex, y = mean_income)) + geom_col()

#
# Question 2: What age has the highest income?
#
# Check variables
class(welfare$birth)
summary(welfare$birth)
qplot(welfare$birth)

#
# Preprocessing
summary(welfare$birth)
table(is.na(welfare$birth))
welfare$birth <- ifelse(welfare$birth == 9999, NA, welfare$birth)
table(is.na(welfare$birth))

#
# Create a derived variable "age" (assumed that a current year is 2015)
welfare$age <- 2015 - welfare$birth + 1
summary(welfare$age)
qplot(welfare$age)

#
# Create an average income table based on age
age_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(age) %>%
  summarise(mean_income = mean(income))
head(age_income)

#
# Create a graph using an age's average income table
ggplot(data = age_income, aes(x = age, y = mean_income)) + geom_line()

#
# Question 3: What age range has the highest income?
#
# Preprocessing - create a derived variable "age range" (ageg)
welfare <- welfare %>%
  mutate(ageg = ifelse(age < 30, "young",
                       ifelse(age <= 59, "middle", "old")))
table(welfare$ageg)
qplot(welfare$ageg)

#
# Create an average income table based on age range
ageg_income <- welfare %>%
  filter(!is.na(income)) %>%
  group_by(ageg) %>%
  summarise(mean_income = mean(income))
ageg_income

#
# Create a graph using an age's range average income table
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) + geom_col()
ggplot(data = ageg_income, aes(x = ageg, y = mean_income)) +
  geom_col() +
  scale_x_discrete(limits = c("young", "middle", "old"))


#
#
#(5): Close the log file connection
sink()
close(lecture_log)
#
