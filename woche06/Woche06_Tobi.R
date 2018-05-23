#############################################
# wie immer zuerst die nötigen Pakete laden:
library("dplyr")
library("ggplot2")

got_neu %>%
  filter(!is.na(Death_Year)) %>%
  ggplot(aes(x = Allegiances, fill = Allegiances)) +
  geom_bar(color = "black") +
  coord_flip() +
  labs(
    x = "Auto", y = "Häufigkeit",
    title = "Verluste der Häuser",
    subtitle = "der Bücher"
  ) +
  theme_classic()


got_neu %>%
  filter(!is.na(Death_Year)) %>%
  count(Allegiances) %>%
  ggplot(aes(x = reorder(Allegiances, n),
             y = n, fill = Allegiances)) +
    geom_col(color = "black") +
    coord_flip() +
    theme_classic()


got_neu %>%
  filter(!is.na(Death_Year)) %>%
  ggplot(aes(x = Book_Intro_Chapter, y = Death_Chapter)) +
    geom_point(size = 2, alpha = .3) +
    geom_smooth(method = "lm", se = F) +
    scale_color_brewer(palette = "Set1") +
    theme_classic()
