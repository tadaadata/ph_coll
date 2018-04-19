# Daten einlesen ----

# Packages installieren!
# install.packages("readr")
# install.packages("readxl")
library("readr")
library("readxl")

# R ----
gotdeaths_R <- read_rds("daten/gotdeaths_R.rds")

# Excel ----
gotdeaths_excel <- read_excel("daten/gotdeaths_excel.xls")

# CSV ----
# delim = delimiter = Trennwert zwischen Werten, in diesem Fall ";" (besser für Excel)
# Gängige delimiter sind comma, tab, etc.
gotdeaths_csv <- read_delim("daten/gotdeaths_csv.csv", delim = ";")

# Alternativ: Import Dataset-Button oben rechts in RStudio (Code kopieren!)

# Game of Thrones deaths: Daten angucken ----

library(ggplot2)

# Simples Balkendiagramm
ggplot(data = gotdeaths_R, aes(x = death_season)) +
  geom_bar()

# Geschmückt
ggplot(data = gotdeaths_R, aes(x = death_season)) +
  geom_bar(color = "black", fill = "black", alpha = 0.25) +
  scale_x_continuous(breaks = 1:6) +
  labs(title = "Game of Thrones (show only)",
       subtitle = "Tode pro Staffel",
       x = "Staffel", y = "Anzahl der Tode")

# Gefärbt nach Staffel
ggplot(data = gotdeaths_R, aes(x = death_season, fill = factor(death_season))) +
  geom_bar(color = "black", alpha = .75) +
  scale_x_continuous(breaks = 1:6) +
  scale_fill_brewer(palette = "Set1") +
  labs(title = "Game of Thrones (show only)",
       subtitle = "Tode pro Staffel",
       x = "Staffel", y = "Anzahl der Tode",
       fill = "Staffel")


# Nach Episode pro Staffel
ggplot(data = gotdeaths_R, aes(x = death_episode, fill = factor(death_season))) +
  geom_bar(color = "black", alpha = .75) +
  scale_x_continuous(breaks = 1:10) +
  scale_fill_brewer(palette = "Set1") +
  facet_wrap(~death_season) +
  labs(title = "Game of Thrones (show only)",
       subtitle = "Tode pro Episode pro Staffel",
       x = "Episode", y = "Anzahl der Tode",
       fill = "Staffel")
