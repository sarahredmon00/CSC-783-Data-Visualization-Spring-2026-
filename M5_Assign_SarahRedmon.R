#
# Question 1: Revise the R code below by replacing
# group_by(group_religion, group_marriage) %>% summarise(n = n())
# with the count() function. Keep the remaining code unchanged.
# Your revised code should produce the same summary table.
# religion_marriage <- welfare %>%
#   filter(!is.na(group_marriage)) %>%
#   group_by(group_religion, group_marriage) %>%
#   summarise(n = n()) %>%
#   group_by(group_religion) %>%
#   mutate(percent = round(n / sum(n) * 100, 1))
# Answer:
#   PREPROCESSING
library(dplyr)
library(foreign)
library(ggplot2)
library(readxl)
raw_welfare <- read.spss(file = "Koweps_hpc10_2015_beta1.sav",
                         to.data.frame = T)
welfare <- raw_welfare
welfare <- rename(welfare,
                  sex = h10_g3,
                  birth = h10_g4,
                  marriage = h10_g10,
                  religion = h10_g11,
                  income = p1002_8aq1,
                  code_job = h10_eco9,
                  code_region = h10_reg7)
welfare$group_religion <- ifelse(welfare$religion == 1, "yes", "no")
welfare$group_marriage <- ifelse(welfare$marriage == 1, "marriage",
                                 ifelse(welfare$marriage == 3, "divorce", NA))
###  Revised code for Question 1: ###
religion_marriage <- welfare %>%
  filter(!is.na(group_marriage)) %>%
  count(group_religion, group_marriage) %>%
  group_by(group_religion) %>%
  mutate(percent = round(n / sum(n) * 100, 1))
religion_marriage


#
# Question 2: Use the USArrests dataset available in R.
# Write the R code to create an interactive choropleth map
# of the United States using the Assault variable.
# Answer:
library(ggiraphExtra)
library(maps)
library(tibble)
crime <- rownames_to_column(USArrests, var = "state")
crime$state <- tolower(crime$state)
states_map <- map_data("state")
ggChoropleth(data = crime,
             aes(fill = Assault,
                 map_id = state),
             map = states_map,
             interactive = T)


#
# Question 3: Use the economics dataset from ggplot2 (ggplot2:economics)
# to answer the following questions.
#
# a) Write the R code to create one interactive time-series graph
# that displays the following three variables:
# * personal consumption expenditures (pce)
# * personal savings rate (psavert)
# * number of unemployed (unemploy)
# Use dygraph() and divide pce by 1000 before plotting
# Answer:
library(dygraphs)
library(xts)
economics <- ggplot2::economics
eco_a <- xts(economics$pce/1000, order.by = economics$date)
eco_b <- xts(economics$psavert, order.by = economics$date)
eco_c <- xts(economics$unemploy, order.by = economics$date)
eco <- cbind(eco_a, eco_b, eco_c)
colnames(eco) <- c("pce", "psavert", "unemploy")
dygraph(eco) %>% dyRangeSelector()
#
# b) Using the interactive time-series graph from Question 3(a),
# hover over October 1999 to identify the values
# of pce, psavert, and unemploy.
# Then write the R code to display those values.
# Answer:
economics %>%
  filter(date == "1999-10-01") %>%
  mutate(pce = pce / 1000) %>%
  select(pce, psavert, unemploy)
