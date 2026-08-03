#
# Question 1: Load the mpg dataset from the ggplot2 package (ggplot2::mpg).
# Determine whether there is a statistically significant difference
# in highway miles per gallon (hwy) between two groups in the drv column:
# front-wheel drive ("f") and rear-wheel drive ("r").
# * Perform an independent two-sample t-test.
# * State the null and alternative hypotheses.
# * Report the p-value and clearly justify your conclusion.
# Answer:
mpg <- as.data.frame(ggplot2::mpg)
library(dplyr)
mpg_diff <- mpg %>%
  select(drv, hwy) %>%
  filter(drv %in% c("f", "r"))
t_test <- t.test(data = mpg_diff, hwy ~ drv, var.equal = T)
t_test
str(t_test)
t_test$null.value
##    Null hypothesis: true difference in means
##    between group f and group r is equal to 0
t_test$alternative
##    Alternative hypothesis: true difference in means
##    between group f and group r is NOT equal to 0
t_test$p.value
##    p-value: 1.53e-12 or 1.53 x 10^-12 or ~0
##    The p-value is less than 0.05 (i.e., p-value < 0.05),
##    so reject null hypothesis.
##    There is a significant difference in hwy between f and r.


#
# Question 2: Load the economics dataset
# from the ggplot2 package (ggplot2::economics).
# * Calculate the correlation between personal consumption expenditures (pce)
# and the personal saving rate (psavert).
# * Indicate whether the relationship is positive, negative,
# or no linear relationship.
# * Report the correlation coefficient.
# Answer:
economics <- as.data.frame(ggplot2::economics)
cor_test <- cor.test(economics$pce, economics$psavert)
cor_test
##    The relationship between pce and psavert is strongly negative
##    because the correlation coefficient is below 0
##    (i.e., negative corr coeff). As pce increases, psavert tends to decrease.
str(cor_test)
cor_test$estimate
##    correlation coefficient: -0.7928546 (strongly negative relationship)
##    (close to -1))


#
# Question 3: Download and load the hurricane.csv file from Canvas.
# * Create a 7 x 7 correlation matrix using the following variables:
#     MasFem, MinPressure_before, Minpressure_Updated.2014, Gender_MF,
#     Category, alldeaths, NDAM
# * Print the resulting correlation matrix.
# Answer:
hur_csv <- read.csv("hurricanes.csv")
library(dplyr)
hur_sel <- hur_csv %>%
  select(MasFem, MinPressure_before, Minpressure_Updated.2014, Gender_MF,
         Category, alldeaths, NDAM)
hur_cor <- cor(hur_sel)
str(hur_cor)
round(hur_cor, 2)


#
# Question 4: Using the correlation matrix created in Question 3:
# * Create a heatmap where each cell represents
# the correlation coefficient values.
# * Identify and report the correlation coefficient
# between MinPressure_before and Minpressure_Updated.2014.
# Answer:
library(corrplot)
col <- colorRampPalette(
  c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))
corrplot(hur_cor,
         method = "color",
         col = col(200),
         type = "lower",
         order = "hclust",
         addCoef.col = "black",
         tl.col = "black",
         tl.srt = 45,
         diag = F)
str(hur_cor)
hur_cor["MinPressure_before", "Minpressure_Updated.2014"]
##    correlation coefficient: 0.9882956 (strongly positive relationship
##    (very close to +1))
