library(dplyr)
library(ggplot2)

# Question 1
mpg_first10rows <- head(mpg, 10)
mpg_first10rows
mpg_first10rows %>% distinct(class)

# Question 2
dim(mpg)
names(mpg)

# Question 3
class(mpg$fl)

# Question 4
mpg %>% distinct(fl, drv, class)

# Question 5
range(mpg$year)
unique(mpg$year)

# Question 6
mpg %>%
  filter(displ < 3 | displ > 6) %>%
  filter(hwy == max(hwy))

# Question 7
mpg %>%
  filter(manufacturer %in% c("ford", "nissan")) %>%
  group_by(manufacturer) %>%
  summarize(mean_cty = mean(cty))

# Question 8
mpg %>%
  filter(manufacturer %in% c("jeep", "hyundai", "lincoln")) %>%
  group_by(manufacturer) %>%
  summarize(mean_hwy = mean(hwy))

# Question 9
mpg %>%
  filter(manufacturer %in% c("jeep", "hyundai", "lincoln")) %>%
  summarize(overall_mean_hwy = mean(hwy))

# Question 10
new_mpg <- mpg %>% select(class, cty)
head(new_mpg, 10)

# Question 11
new_mpg %>%
  filter(class %in% c("minivan", "pickup")) %>%
  group_by(class) %>%
  summarize(mean_cty = mean(cty))

# Question 12
mpg %>%
  filter(manufacturer == "dodge") %>%
  arrange(desc(hwy)) %>%
  head(10)

# Question 13
mpg %>%
  group_by(class) %>%
  summarize(mean_cty = mean(cty))

# Question 14
mpg %>%
  group_by(class) %>%
  summarize(mean_cty = mean(cty)) %>%
  arrange(desc(mean_cty))

# Question 15
mpg %>%
  group_by(manufacturer) %>%
  summarize(mean_hwy = mean(hwy)) %>%
  arrange(desc(mean_hwy)) %>%
  head(5)

# Question 16
mpg %>%
  filter(class == "subcompact") %>%
  group_by(manufacturer) %>%
  summarize(n = n()) %>%
  arrange(desc(n))

# Question 17
max_displ <- mpg %>% filter(displ == max(displ))
write.csv(max_displ, "max_displ_car.csv", row.names = FALSE)

# Question 18
mpg$efficiency_group <- ifelse(mpg$hwy >= 30, "high",
                               ifelse(mpg$hwy >= 20, "medium", "low"))
table(mpg$efficiency_group)

# Question 19
mpg %>%
  group_by(drv) %>%
  summarize(avg_cty = mean(cty),
            avg_hwy = mean(hwy),
            n = n())

# Question 20
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point(color = "red", size = 2)

# Question 21
ggplot(mpg, aes(x = drv)) +
  geom_bar() +
  labs(
    title = "Frequency of Drivetrain Type",
    x = "Drivetrain Type",
    y = "Number of Vehicles")

# Question 22
drv_summary <- mpg %>%
  group_by(drv) %>%
  summarize(mean_hwy = mean(hwy))
ggplot(drv_summary, aes(x = drv, y = mean_hwy)) +
  geom_bar(stat = "identity") +
  labs(
    title = "Average Highway MPG by Drivetrain Type",
    x = "Drivetrain Type",
    y = "Mean Highway MPG")

# Question 23
ggplot(mpg, aes(x = drv, y = hwy)) +
  geom_boxplot() +
  labs(
    title = "Highway MPG by Drivetrain Type",
    x = "Drivetrain Type",
    y = "Highway MPG")

# Question 24
ggplot(mpg, aes(x = displ, y = hwy)) +
  geom_point() +
  xlim(3, 6) +
  ylim(10, 30) +
  labs(
    title = "Displacement vs Highway MPG",
    x = "Engine Displacement",
    y = "Highway MPG")
