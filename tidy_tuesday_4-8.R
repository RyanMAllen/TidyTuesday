player_dob <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-09/player_dob.csv")

grand_slams <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-09/grand_slams.csv")

grand_slam_timeline <- readr::read_csv("https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2019/2019-04-09/grand_slam_timeline.csv")


g <- grand_slams %>% 
  select(name,gender,rolling_win_count) %>%
  
group_by(name, gender) %>% 
  summarise(rolling_win_count = sum(rolling_win_count))
males <- filter(g, gender == "Male")
top_10m <- males %>% arrange(desc(rolling_win_count)) %>% top_n(10)



top_10F <- within(top_10, 
                   rolling_win_count <- factor(rolling_win_count, 
                                      levels=names(sort(table(rolling_win_count), 
                                                        decreasing=TRUE))))

chart <- ggplot(top_10, aes(x=name, y= rolling_win_count))
chart + geom_bar(stat='identity')



