#(1): Create an output log file.
lecture_log <- file("M1_Lecture3_Sarah.txt")
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
# Create a Variable
a <- 1
a
b <- 2
b
c <- 3
c
d <- 3.5
d
print(1:100)

#
# Variables calculation
a + b
a + b + c
4 / b
5 * b

#
# Create a Variable with multiple values
# 1) c()
var1 <- c(1, 2, 5, 7, 8)
var2 <- c(1:5)
var2
# 2) seq()
var3 <- seq(1, 5)
var3
var4 <- seq(1, 10, by = 2)
var5 <- seq(1, 10, by = 3)

#
# Calculate a Continuous Variable
var1 + 2
var1
var1 + var2

#
# Create a Character/String Variable
str1 <- "a"
str1
str2 <- "text"
str2
str3 <- "Hello World!"
str3

#
# Create a continuous character variable
str4 <- c("a", "b", "c")
str4
str5 <- c("Hello!", "World", "is", "good!")
str5

#
# Character variable calculation?
str1 + 2

#
# Using a function to handle numeric
x <- c(1, 2, 3)
x
mean(x)
max(x)
min(x)

#
# Using a function to handle string
str5
paste(str5, collapse = ",")

#
# Set options for a Function
paste(str5, collapse = " ")
x_mean <- mean(x)

#
# Create a new Variable as the result of a Function
str5_paste <- paste(str5, collapse = " ")
str5_paste

#
# Install/Load ggplot2
install.packages("ggplot2")
library(ggplot2)

#
# Use a Function under the Package ggplot2
x <- c("a", "a", "b", "c")
x
qplot(x)

#
# Change a Parameter in qplot()
#   x axis: cty (city miles per gallon)
qplot(data = mpg, x = cty)
#   x axis: drv, y axis: hwy
qplot(data = mpg, x = drv, y = hwy)
#   x axis: drv, y axis: hwy, Line graph form
qplot(data = mpg, x = drv, y = hwy, geom = "line")
#   x axis: drv, y axis: hwy, box plot form
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot")
#   x axis: drv, y axis: hwy, box plot form with a color label per drv
qplot(data = mpg, x = drv, y = hwy, geom = "boxplot", colour = drv)

#
# Use a Help (?) for additional functions
?qplot

#
# Create Data Frame
english <- c(90, 80, 60, 70)
english
math <- c(50, 60, 100, 20)
math
df_midterm <- data.frame(english, math)
View(df_midterm)
df_midterm
View(df_midterm)
View(df_midterm)
class <- c(1, 1, 2, 2)
class
df_midterm <- data.frame(english, math, class)
df_midterm
mean(df_midterm$english)
mean(df_midterm$math)

#
# Create a Data Frame with ONE command
df_midterm <- data.frame(english = c(90, 80, 60, 70),
                         math = c(50, 60, 100, 20),
                         class = c(1, 1, 2, 2))
df_midterm

#
# Use External data - Get accumulated test scores
install.packages("readxl")
library(readxl)
df_exam <- read_excel("excel_exam.xlsx")
class(df_exam)
df_exam
getwd()
setwd("/Users/sarahredmon/CSC 583/Wk1/CSC538-Lecture 3-data/data")
getwd()
mean(df_exam$english)
mean(df_exam$science)

#
# Open an external file using the path
getwd()
df_exam <- read_excel("/Users/sarahredmon/CSC 583/Wk1/CSC538-Lecture 3-data/data/excel_exam.xlsx")
df_exam
# 1) What if the first row of the Excel file is not the variable name?
df_exam_novar <- read_excel("excel_exam_novar.xlsx", col_names = F)
df_exam_novar
# 2) What if there are multiple sheets in the Excel file?
df_exam_novar <- read_excel("excel_exam_sheet.xlsx", sheet = 3)
df_exam_novar
# 1) continue
df_exam_sheet <- df_exam_novar
df_exam_sheet
df_exam_novar <- read_excel("excel_exam_novar.xlsx", col_names = F)
df_exam_novar

#
# Read a CSV file
df_csv_exam <- read.csv("csv_exam.csv")
df_csv_exam

#
# Reading a file containing characters
df_csv_exam <- read.csv("csv_exam.csv", stringsAsFactors = F)
df_csv_exam

#
# Create factor variable?
x <- factor(c("single", "married", "married", "single"))
x
class(x)
is.factor(x)
str(x)

#
# Save a data frame as a CSV file
df_midterm
write.csv(df_midterm, file = "df_midterm.csv")

#
# Save data frame as RData file
save(df_midterm, file = "df_midterm.rda")

#
# Open RData file
load("df_midterm.rda")
rm(df_midterm)
load("df_midterm.rda")
View(df_midterm)

#
#
#(5): Close the log file connection
sink()
close(lecture_log)
#
