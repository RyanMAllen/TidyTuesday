library(tidyverse)
library(data.table)
set.seed(12)

bird_collisions <- fread("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-30/bird_collisions.csv")
mp_light <- fread("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-30/mp_light.csv")

sbird <- bird_collisions[bird_collisions$locality == 'MP']

dt <- na.omit(left_join(mp_light, sbird, by = 'date'))

dt <- as.data.table(dt)
head(dt)
str(dt)

dt$date <- as.Date(dt$date, "%Y-%m-%d")
str(dt)

dt %>% filter(date > "2001-01-01" & date <"2001-12-31") %>% group_by(genus) %>% 
  count(light_score, genus) %>% 
  ggplot(aes(x=light_score, y=n, col=genus)) + geom_point(aes(col=genus))+ geom_line(aes(col=genus))

dt %>% filter(genus == "Setophaga") %>% add_count(light_score) %>% 
  ggplot(aes(x=light_score, y=n)) + geom_point()+ geom_line()
