# Question 1: Use the mpg dataset available from the ggplot2 package
# to complete the following tasks:
#
# 1) Extract the "class" and "cty" variables from the 'mpg' dataset
# and create a new dataset with them. Print out the created dataset
# ensuring it contains only those two variables.
# Hint: Use select() to extract variables and then create a new dataset.
# Answer:
library(dplyr)
library(ggplot2)
mpg_subset <- mpg %>% select(class, cty)
mpg_subset

#
# 2) Determine if the city's fuel economy varies depending on vehicle class.
# Using the previously extracted data, identify which car class,
# either "suv" or "compact" has a higher average "cty" (city fuel economy).
# Hint: Extract the data with filter() and compute its average.
# Answer:
mpg_subset %>%
  filter(class %in% c("suv", "compact")) %>%
  group_by(class) %>%
  summarize(mean_cty = mean(cty))

# 3) Identify which "audi" car models have the highest highway fuel economy
# (hwy). Disply the top 5 car models from "audi" based on their "hwy" values.
# Hint: Utilize filter(), arrange(), and head() functions
# Answer:
mpg %>%
  filter(manufacturer == "audi") %>%
  arrange(desc(hwy)) %>%
  select(model, hwy) %>%
  head(5)

# 4) The "class" variable in the mpg dataset consists of seven different
# vehicle types assigned depending on the characteristics of the vehicle,
# such as 'suv', 'compact', 'minivan', etc. Compare which type of vehicle has
# the highest average city fuel efficiency by calculating the average of 'cty'
# per "class".
# Answer:
mpg %>%
  group_by(class) %>%
  summarize(mean_cty = mean(cty))

# 5) The result of the previous question 1-(4) is sorted alphabetically
# by class value. To make it easier to identify which vehicle type has a
# high urban fuel economy, print out the 'cty' values in descending order.
# Answer:
mpg %>%
  group_by(class) %>%
  summarize(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty))

# 6) Determine which car manufacturer has the highest
# 'hwy' (highway fuel efficiency). Print out the top three manufacturers
# with the highest average highway fuel efficiency.
# Answer:
mpg %>%
  group_by(manufacturer) %>%
  summarize(mean_hwy = mean(hwy)) %>%
  arrange(desc(mean_hwy)) %>%
  head(3)

# 7) Count the number of 'compact' cars produced by each manufacturer.
# Display the count of 'compact' vehicles per manufacturer in descending order.
# Answer:
mpg %>%
  filter(class == "compact") %>%
  group_by(manufacturer) %>%
  summarize(n = n()) %>%
  arrange(desc(n))


# Question 2: Use the mpg dataset from the ggplot2 package to perform
# the following data analysis tasks. This dataset includes
# two fuel economy metrics: 'hwy' (highway) and 'cty' (city),
# and a 'fl' variable indicating the fuel type. The following table
# summarizes the types of fuel and their corresponding prices:
#   fl  Type of fuel  Price(gallon, USD)
#   c   CNG           2.35
#   d   diesel        2.38
#   e   ethanol E85   2.11
#   p   premium       2.76
#   r   regular       2.22
#
# 1) For the variable analysis, we aim to integrate fuel economy
# instead of using two separate parameters, 'cty' and 'hwy'.
# To create the integrated economy, duplicate your mpg dataset (e.g., mpg_new)
# and add a new variable named 'total' to store values calculated as
# the sum of 'cty' and 'hwy'.
# Hint: Utilize mutate().
# Answer:
mpg_new <- mpg %>% mutate(total = cty + hwy)
mpg_new %>% select(model, cty, hwy, total)

# 2) From the 'total' variable created above, calculate
# the average fuel economy by dividing it by 2. Store the result
# in a new variable called 'avg'.
# Answer:
mpg_new <- mpg_new %>% mutate(avg = total / 2)
mpg_new %>% select(model, cty, hwy, total, avg)

# 3) Identify and display the top three vehicle records
# with the highest values of avg (average fuel economy).
# Hint: Use arrange() and head().
# Answer:
mpg_new %>%
  arrange(desc(avg)) %>%
  select(model, cty, hwy, total, avg) %>%
  head(3)

# 4) Create and print a single 'dplyr' command
# that addresses tasks 2-(1), 2-(2), and 2-(3).
# Utilize the original mpg dataset instead of a copy (e.g., mpg_new).
# Use the pipe operator (%>%) and write the entire command in one line.
# Answer:
mpg %>%
  mutate(total = cty + hwy, avg = total / 2) %>%
  arrange(desc(avg)) %>%
  select(model, cty, hwy, total, avg) %>%
  head(3)

# 5) Create a new data frame named fuel_price with the following two columns:
# 'fl' (the fuel type) and 'price_fl' (the corresponding fuel price).
# Use the above reference table summarizing the fuel types and their prices
# to construct this data frame.
# Answer:
fuel_price <- data.frame(fl = c("c", "d", "e", "p", "r"),
                         price_fl = c(2.35, 2.38, 2.11, 2.76, 2.22))

# 6) The mpg dataset includes a 'fl' variable indicating the fuel type,
# but lacks a variable indicating the fuel price. Add a 'price_fl' variable
# to the mpg dataset containing the fuel price corresponding to the fuel type,
# using the data frame 'fuel_price'.
# Answer:
mpg_price <- mpg %>% left_join(fuel_price, by = "fl")
mpg_price %>% select(model, fl, price_fl)

# 7) To verify that the fuel price variables have been successfully added
# in question 2-(6), extract the variables 'model', 'fl', and 'price_fl',
# then print out the first five rows.
# Answer:
mpg_price %>%
  select(model, fl, price_fl) %>%
  head(5)
