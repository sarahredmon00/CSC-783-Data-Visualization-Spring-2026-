#(1): Create an output log file.
lecture_log <- file("M6_Lecture16_Sarah.txt")
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

## Lecture 16 ##

#
# t test for city fuel economy (cty) of 'compact'
# and 'suv' class

#   Preparing a dataset
mpg <- as.data.frame(ggplot2::mpg)
library(dplyr)
mpg_diff <- mpg %>%
  select(class, cty) %>%
  filter(class %in% c("compact", "suv"))
head(mpg_diff)
table(mpg_diff$class)

#   t test
t.test(data = mpg_diff, cty ~ class, var.equal = T)


#
# t test for city fuel economy (cty) of 'regular gasoline'
# and 'premium gasoline'

#   Preparing a dataset
mpg_diff2 <- mpg %>%
  select(fl, cty) %>%
  filter(fl %in% c("r", "p")) #r: regular, p: premium
table(mpg_diff2$fl)

#   t test
t.test(data = mpg_diff2, cty ~ fl, var.equal = T)


#
# Correlation between the number of unemployment
# and private consumption expenditure

#   Preparing a dataset
economics <- as.data.frame(ggplot2::economics)

#   Correlation analysis
cor.test(economics$unemploy, economics$pce)


#
# Create a heatmap of a correlation matrix

#   Preparing a dataset
head(mtcars)

#   Create a correlation matrix
car_cor <- cor(mtcars)
round(car_cor, 2) #round hundredths

#   Create a correlation heatmap
install.packages("corrplot")
library(corrplot)
corrplot(car_cor)

#   Use coefficient of correlation
corrplot(car_cor, method = "number")

#   Set corrplot parameters
col <- colorRampPalette(
  c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(car_cor,
         method = "color",
         col = col(200),
         type = "lower",
         order = "hclust",
         addCoef.col = "black",
         tl.col = "black",
         tl.srt = 45,
         diag = F)


#
#
#(5): Close the log file connection
sink()
close(lecture_log)
#
