# Question 1: Create a variable to store a data frame
# containing the mpg dataset from the ggplot2 package.
# You may choose any variable name for your data frame.
# Answer:
library(ggplot2)
mpg_var <- as.data.frame(ggplot2::mpg)

# Question 2: Write R code to identify and display a unique list
# of car manufacturers from the first 20 rows of the mpg data frame.
# You are encouraged to use functions from the dplyr package.
# Answer:
library(dplyr)
mpg_var %>%
  head(20) %>%
  group_by(manufacturer) %>%
  summarize()

# Question 3: Identify the data type of the displ column,
# which represents engine displacement in liters,
# in the mpg data frame.
# Answer:
class(mpg_var$displ)
str(mpg_var$displ)

# Question 4: Using the mpg data frame:
# * Determine the year of the oldest car model.
# * Calculate the average number of cylinders across all vehicles.
# Answer:
min(mpg_var$year)
mean(mpg_var$cyl)

# Question 5: The ggplot2 package provides a dataset named midwest,
# which contains demographic information for 437 counties
# in the Midwestern United States. Use this dataset to answer
# the questions below. You are encouraged to use functions from the dplyr
# and ggplot2 packages where applicable.
#
# a) Import the midwest dataset from the ggplot2 package and convert it
# into a data frame.
# * Use the six common statistical functions discussed in class to explore
# the structure and content of the data.
# * Rename the column poptotal to total and popasian to asian
# using the dplyr package.
# Answer:
mw_var <- as.data.frame(ggplot2::midwest) # mw = midwest
head(mw_var)
tail(mw_var)
View(mw_var)
dim(mw_var)
str(mw_var)
summary(mw_var)
mw_var <- rename(mw_var, total = poptotal, asian = popasian)
#
# b) Using the renamed total and asian columns:
# * Create a new derived variable that calculates the percentage
# of the Asian population in each county.
# * Create a histogram to visualize the distribution of this percentage
# across counties using ggplot2.
# Answer:
mw_var$asian_per <- (mw_var$asian / mw_var$total) * 100
ggplot(data = mw_var, aes(x = asian_per)) + geom_histogram() +
  labs(
    x = "Asian Population Percentage",
    y = "Count of Counties",
    title = "Distribution of Asian Population Percentage"
  )
#
# c) Calculate the overall average of the Asian population percentage
# created in part (b). Then, create a new categorical variable: label
# each county as 'large' if its percentage is greater than the average,
# and 'small' otherwise.
# Answer:
asian_mean <- mean(mw_var$asian_per)
mw_var$size <- ifelse(mw_var$asian_per > asian_mean, "large", "small")
#
# d) Create a frequency table that shows the count of counties
# labeled as 'large' and 'small', and visualize this distribution
# using a bar graph.
# Answer:
table(mw_var$size)
ggplot(data = mw_var, aes(x = size)) + geom_bar() +
  labs(
    x = "County Size Category",
    y = "Number of Counties",
    title = "Count of Large vs Small Counties"
  )

# Question 6: Use the 'mpg' dataset (i.e., ggplot2::mpg)
# to answer the following questions.
#
# a) You are examining whether highway fuel economy (hwy) differs
# based on engine displacement (displ).
# * Calculate the average highway fuel economy for cars
# with engine displacement less than 4 or greater than 5
# (i.e., where displ < 4 or displ > 5).
# Answer:
mpg_var %>%
  filter(displ < 4 | displ > 5) %>%
  summarize(hwy_mean = mean(hwy))
#
# b) You want to determine if city fuel economy (cty)
# varies by car manufacturer.
# * Calculate the average city fuel economy for cars manufactured
# by Toyota and Audi.
# Answer:
mpg_var %>%
  filter(manufacturer %in% c("toyota", "audi")) %>%
  group_by(manufacturer) %>%
  summarize(cty_mean = mean(cty))
#
# c) You aim to evaluate the highway fuel efficiency
# of selected manufacturers.
# * Calculate the overall average highway fuel economy
# for all cars manufactured by Chevrolet, Ford, and Honda combined.
# Answer:
mpg_var %>%
  filter(manufacturer %in% c("chevrolet", "ford", "honda")) %>%
  summarize(hwy_mean = mean(hwy))
