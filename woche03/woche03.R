# Daten einlesen ----

# Packages installieren!
# install.packages("readr")
# install.packages("readxl")
library("readr")
library("readxl")

# Daten runterladen: Liegen in stud.ip – die R-Version findet ihr auch auf
# https://data.tadaa-data.de/#game-of-thrones-deaths-show-only

# R ----
gotdeaths_R <- read_rds("daten/gotdeaths_R.rds")

# Excel ----
gotdeaths_excel <- read_excel("daten/gotdeaths_excel.xls")

# CSV ----
# delim = delimiter = Trennwert zwischen Werten, in diesem Fall ";" (besser für Excel)
# Gängige delimiter sind comma, tab, etc.
gotdeaths_csv <- read_delim("daten/gotdeaths_csv.csv",
                            ";", escape_double = FALSE, trim_ws = TRUE)

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
       x = "Staffel", y = "Anzahl der Tode (absolut)")

# Gefärbt nach Staffel
ggplot(data = gotdeaths_R, aes(x = death_season, fill = factor(death_season))) +
  geom_bar(color = "black") +
  scale_x_continuous(breaks = 1:6) +
  scale_fill_brewer(palette = "Pastel1") +
  labs(title = "Game of Thrones (show only)",
       subtitle = "Tode pro Staffel",
       x = "Staffel", y = "Anzahl der Tode",
       fill = "Staffel")

# Gefärbt nach Staffel und ohne Legende
ggplot(data = gotdeaths_R, aes(x = death_season, fill = factor(death_season))) +
  geom_bar(color = "black") +
  scale_x_continuous(breaks = 1:6) +
  scale_fill_brewer(palette = "Pastel1") +
  labs(title = "Game of Thrones (show only)",
       subtitle = "Tode pro Staffel",
       x = "Staffel", y = "Anzahl der Tode",
       fill = "Staffel") +
  theme(legend.position = "none")

# Gefärbt nach Staffel und ohne Legende (Nummer 2)
ggplot(data = gotdeaths_R, aes(x = death_season, fill = factor(death_season))) +
  geom_bar(color = "black") +
  scale_x_continuous(breaks = 1:6) +
  scale_fill_brewer(palette = "Pastel1", guide = FALSE) +
  labs(title = "Game of Thrones (show only)",
       subtitle = "Tode pro Staffel",
       x = "Staffel", y = "Anzahl der Tode",
       fill = "Staffel")

# Nach Episode pro Staffel
ggplot(data = gotdeaths_R, aes(x = death_episode, fill = factor(death_season))) +
  geom_bar(color = "black", alpha = .75) +
  scale_x_continuous(breaks = 1:10) +
  scale_fill_brewer(palette = "Set1") +
  facet_wrap(~ death_season) +
  labs(title = "Game of Thrones (show only)",
       subtitle = "Tode pro Episode pro Staffel",
       x = "Episode", y = "Anzahl der Tode",
       fill = "Staffel")

# Häufigkreitstabellen ----
table(gotdeaths_R$death_season)

# Summe der absoluten Häufigkeiten (N) speichern
n_deaths <- sum(table(gotdeaths_R$death_season))

# (Absolute) Häufigkeiten speichern
freqs <- table(gotdeaths_R$death_season)

# Relative Häufigkeit = Absolute Häufigkeiten durch N
freqs / n_deaths
