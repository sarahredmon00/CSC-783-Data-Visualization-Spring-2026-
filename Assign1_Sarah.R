# Question 1: Create and Display Test Scores
# Five students took a test and received the following scores:
# 80, 60, 70, 50, 90.
# Write R code to create a variable that stores these scores
# and display the variable.
# Answer:
test_scores <- c(80, 60, 70, 50, 90)
test_scores

# Question 2: Calculate the Average Score
# Using the variable created in Question 1, calculate the overall
# average test score for the five students.
# Answer:
mean(test_scores)

# Question 3: Store and Display the Average
# Create a new variable that stores the overall average test score
# and display the variable.
# Answer:
mean_score <- mean(test_scores)
mean_score

# Question 4: Create a Bar Graph Using ggplot2
# Using the qplot() function from the ggplot2 package, create
# and display a bar graph showing the number of cars for each
# manufacturer in the mpg dataset.
# The y-axis must be labeled "Count."
# Hint: Use the ?qplot command to review the function documentation
# and specify geom = "bar".
# Answer:
library(ggplot2)
?qplot
qplot(data = mpg, x = manufacturer, ylab = "Count", geom = "bar")

# Question 5: Create a Data Frame
# Use the data.frame() and c() functions to create a data frame
# containing the information provided in Table 1: Fruit Sales.
# Display the completed data frame.
# Answer:
fruit_sales <- data.frame(
  fruit = c("Apple", "Strawberry", "Watermelon"),
  price = c(1800, 1500, 3000),
  volume = c(24, 38, 13)
)
fruit_sales

# Question 6: Calculate Summary Values from the Data Frame
# Using the data frame created in Question 5, calculate
# and display the following:
# * The average price of the fruits
# * The average volume of the fruits
# Answer:
mean_price <- mean(fruit_sales$price)
mean_volume <- mean(fruit_sales$volume)
mean_price
mean_volume
