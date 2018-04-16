# Daten aus Aufgabenzettel 1

# Tayfun Korkut (517 Tage)
# Hannes Wolf (494),
# Olaf Janßen (5),
# Jos Luhukay (76),
# Jürgen Kramny (76),
# Alexander Zorniger (145),
# Huub Stevens (217), Armin Veh (145), Huub Stevens (113) 2 ,
# Thomas Schneider (195), Bruno Labbadia (987),
# Jens Keller (58), Christian Groß (310), Markus Babbel (380)

###

tage <- c(987, 517, 494, 5, 76, 76, 145, 217, 145, 113, 195, 58, 310, 380)

# Kennwerte
mean(tage)
median(tage)

var(tage)
sd(tage)
IQR(tage)

# Indexing ----

# Nur der erste Wert
tage[1]

# Statistiken von tage *ohne* den ersten Wert
mean(tage[-1])
median(tage[-1])

var(tage[-1])
sd(tage[-1])
IQR(tage[-1])

# data.frame ----
menschen <- data.frame(namen = c("lukas", "tobias", "christoph"),
                       alter = c(26, 31, 32))

# Spalte alter von data.frame menschen
menschen$alter

# Statistiken der Variable
mean(menschen$alter)
sd(menschen$alter)

# Sleep: Übungsdatensatz ----
sleep

# Dokumentation zum Datensatz
?sleep

# Logik
sleep$group
sleep$group == 1

# Alle aus Gruppe 1
sleep[sleep$group == 1, ]

#### Packages: dplyr

# Nur einmal. Antivirus deaktivieren unter Windows!
# install.packages("dplyr")

# Package laden (verfügbar machen)
library("dplyr")


# Zeilen filtern mit dplyr und filter()
filter(sleep, group == 1)

# Alle Zeilen aus sleep wo extra größer 1, und group 1
filter(sleep, extra > 1, group == 1)

# Variablen filtern
select(sleep, extra, ID)

# Nächste Woche
# Gruppenspezifische Mittelwerte für group in sleep
sleep %>%
  group_by(group) %>%
  summarize(mw_extra = mean(extra))

# Motivierendes Beispiel für demnächst ¯\_(ツ)_/¯
install.packages("ggplot2")
library("ggplot2")

# Histogramm und Boxplot
ggplot(sleep, aes(x = extra, fill = group)) +
  geom_histogram(binwidth = 1, position = "dodge")

ggplot(sleep, aes(x = group, y = extra)) +
  geom_boxplot()
