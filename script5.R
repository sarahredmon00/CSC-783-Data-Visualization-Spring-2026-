#(1): Create an output log file.
lecture_log <- file("M5_SarahRedmon.txt")
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
# PART 9
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

# PREPROCESSING
#   From last week: Rename variables
welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_region = h10_reg7)
#   From last week: Create a derived variable "age"
welfare$age <- 2015 - welfare$birth + 1
#   From last week: Create a derived variable "age range"
welfare <- welfare %>%
  mutate(ageg = ifelse(age < 30, "young",
                       ifelse(age <= 59, "middle", "old")))

# Question 4: Will religious people get divorced less?
#
# Check variables (religion) in welfare
class(welfare$religion)
table(welfare$religion)

# Preprocessing - label if a religion exists or not
welfare$religion <- ifelse(welfare$religion == 1, "yes", "no")
table(welfare$religion)
qplot(welfare$religion)

# Explore a variable to check marriage status
class(welfare$marriage)
table(welfare$marriage)

# Preprocessing - create a derived variable "group marriage"
# to add a "divorce" case
welfare$group_marriage <- ifelse(welfare$marriage == 1, "marriage",
                                 ifelse(welfare$marriage == 3, "divorce", NA))
table(welfare$group_marriage)
table(is.na(welfare$group_marriage))

# Preprocessing - check divorce and marriage by quick plot
qplot(welfare$group_marriage)

# Create a table of divorce rates based on religious status
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(religion, group_marriage) %>%
  summarize(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))
religion_marriage

# Use count() in dplyr package
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  count(religion, group_marriage) %>%
  group_by(religion) %>%
  mutate(pct = round(n/sum(n)*100, 1))

# Create a divorce rate table
divorce <- religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(religion, pct)
divorce

# Create a graph (i.e., bar chart)
ggplot(data = divorce, aes(x = religion, y = pct)) + geom_col()
#   Will religious people get divorced less? ANSWER: Yes

# Analyze divorce rate by age group and religion - Create divorce rate tables
# by age group
ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  group_by(ageg, group_marriage) %>%
  summarize(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))
ageg_marriage

# Use count() in dplyr package
ageg_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  count(ageg, group_marriage) %>%
  group_by(ageg) %>%
  mutate(pct = round(n/sum(n)*100, 1))

# Create a divorce rate graph by age group
# - Note that we exclude young people prior to extracting divorce cases
ageg_divorce <- ageg_marriage %>%
  filter(ageg != "young" & group_marriage == "divorce") %>%
  select(ageg, pct)
ageg_divorce

# Create a graph (i.e., bar chart)
ggplot(data = ageg_divorce, aes(x = ageg, y = pct)) + geom_col()

# Create a table of divorce rates based on age group and religious presence
# - i.e., a table of rates by age group, religion status, and marital status
ageg_religion_marriage <- welfare %>%
  filter(!is.na(group_marriage) & ageg != "young") %>%
  group_by(ageg, religion, group_marriage) %>%
  summarize(n = n()) %>%
  mutate(tot_group = sum(n)) %>%
  mutate(pct = round(n/tot_group*100, 1))
ageg_religion_marriage

# Use count() in dplyr package
ageg_religion_marriage <- welfare %>%
  filter(!is.na(group_marriage) & ageg != "young") %>%
  count(ageg, religion, group_marriage) %>%
  group_by(ageg, religion) %>%
  mutate(pct = round(n/sum(n)*100, 1))

# Create a table of a divorce rate table by age group and religion
df_divorce <- ageg_religion_marriage %>%
  filter(group_marriage == "divorce") %>%
  select(ageg, religion, pct)
df_divorce

# Create a divorce rate graph based on age group and religion
ggplot(data = df_divorce, aes(x = ageg, y = pct, fill = religion)) +
  geom_col(position = "dodge")


#
# PART 10
#
# Create US state-wide violent crime rate map
install.packages("ggiraphExtra")
library(ggiraphExtra)

# Prepare US state-specific crime data
str(USArrests)
head(USArrests)
library(tibble)
crime <- rownames_to_column(USArrests, var = "state")
crime$state <- tolower(crime$state)
str(crime)

# Prepare US state map data
library(ggplot2)
library(maps)
states_map <- map_data("state")
str(states_map)

# Create a choropleth map
library(mapproj)
ggChoropleth(data = crime,
             aes(fill = Murder,
                 map_id = state),
             map = states_map)

# Create an interactive choropleth map
ggChoropleth(data = crime,
             aes(fill = Murder,
                 map_id = state),
             map = states_map,
             interactive = T)

# Create Interactive Graphs in Plotly package
install.packages("plotly")
library(plotly)

#   Step 1: create a graph with ggplot2
library(ggplot2)
p <- ggplot(data = mpg, aes(x = displ, y = hwy, col = drv)) + geom_point()

#   Step 2: create an interactive graph
ggplotly(p)
p <- ggplot(data = diamonds, aes(x = cut, fill = clarity)) +
  geom_bar(position = "dodge")
show(p)
ggplotly(p)

# Create Interactive Time Series Graphs in dygraphs Package
install.packages("dygraphs")
library(dygraphs)

# Preparing data, ggplot2:economics
economics <- ggplot2::economics
head(economics)

# Use xts to change an original data type to data type
# with the chronological order
library(xts)
eco <- xts(economics$unemploy, order.by = economics$date)
head(eco)

# Draw an interactive time series graph
dygraph(eco)

# Select date range
dygraph(eco) %>% dyRangeSelector()

# Express multiple values
eco_a <- xts(economics$psavert, order.by = economics$date)
eco_b <- xts(economics$unemploy/1000, order.by = economics$date)

# Merge data and rename variables
eco2 <- cbind(eco_a, eco_b)
colnames(eco2) <- c("psavert", "unemploy")
head(eco2)

# Draw an interactive time series graph
dygraph(eco2) %>% dyRangeSelector()



#
#
#(5): Close the log file connection
sink()
close(lecture_log)
#
