#(1): Create an output log file.
lecture_log <- file("M3_SarahRedmon.txt")
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
# Extract the only required variables
library(dplyr)
exam <- read.csv("csv_exam.csv")
exam %>% select(math)     # extract a variable by math
exam %>% select(english)  # extract a variable by english

#
# Extract multiple variables
exam %>% select(class, math, english) # extract variables such as
                                      # class, math, and english

#
# Exclude a specific variable
exam %>% select(-math)            # discard a variable by math
exam %>% select(-math, -english)  # exclude two variables by math and english

# Combining the dplyr functions
#   Extracts only rows with class has 1 and then extract a variable by english
exam %>% filter(class == 1) %>% select(english)

# [Alternative] Extracts only rows with class has 1
# and then extract a variable by english
exam %>%
  filter(class == 1) %>%
  select(english)

# Print a part
exam %>%
  select(id, math) %>%  # extract variables by id and math
  head                  # print the first six rows
exam %>%
  select(id, math) %>%
  head(10)              # show the first 10 rows

# Sort in ascending order
exam %>% arrange(math)

# Sort in descending order
exam %>% arrange(desc(math))

# Specify multiple variables for sorting
exam %>% arrange(class, math) # sort class and math variables
                              # in ascending order

# Add a derived variable
exam %>%
  mutate(total = math + english + science) %>%
  head

# Add multiple derived variables with single command
exam %>%
  mutate(total = math + english + science,
         mean = (math + english + science) / 3) %>%
  head

# Apply ifelse() to the function mutate()
exam %>%
  mutate(test = ifelse(science >= 60, "pass", "fail")) %>%
  head

# Apply arrange() to the derived variable
exam %>%
  mutate(total = math + english + science) %>%
  arrange(total) %>%
  head

# To summarize by group
exam %>% summarize(mean_math = mean(math))
exam %>%
  group_by(class) %>%
  summarize(mean_math = mean(math))

# Calculate multiple summary statistics at once
exam %>%
  group_by(class) %>%
  summarize(mean_math = mean(math),
            sum_math = sum(math),
            median_math = median(math),
            n = n())

# To group again by each group
library(ggplot2)
mpg %>%
  group_by(manufacturer, drv) %>%
  summarize(mean_cty = mean(cty)) %>%
  head(10)

# Combine dplyr functions
mpg %>%
  group_by(manufacturer) %>%
  filter(class == "suv") %>%
  mutate(tot = (cty + hwy) / 2) %>%
  summarize(mean_tot = mean(tot)) %>%
  arrange(desc(mean_tot)) %>%
  head(5)

# Merge by column
#   Create a test 1 data
test1 <- data.frame(id = c(1, 2, 3, 4, 5),
                    midterm = c(60, 80, 70, 90, 85))
#   Create a test 2 data
test2 <- data.frame(id = c(1, 2, 3, 4, 5),
                    final = c(70, 83, 65, 95, 80))
test1 # print test1
test2 # print test2

# Merge by id
total <- left_join(test1, test2, by = "id")
total
# Caution: Enter double quotation marks before and after variable names
# when specifying variable names for "by".

# To add variables using different data
name <- data.frame(class = c(1, 2, 3, 4, 5),
                    teacher = c("kim", "lee", "park", "choi", "jung"))
name

# Merge by class
exam_new <- left_join(exam, name, by = "class")
exam_new

# Merge by row
group_a <- data.frame(id = c(1, 2, 3, 4, 5),
                    test = c(60, 80, 70, 90, 85))
group_b <- data.frame(id = c(6, 7, 8, 9, 10),
                      test = c(70, 83, 65, 95, 80))
group_a
group_b
group_all <- bind_rows(group_a, group_b)
group_all


#
#
#(5): Close the log file connection
sink()
close(lecture_log)
#
