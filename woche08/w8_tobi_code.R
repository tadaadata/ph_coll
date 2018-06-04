# "Lösung" zu Tobis Aufgaben aus Woche 8

# Datensatz bauen aus Einzelteilen: ----
personen_tobi <- data.frame(
  id = 1:200,
  geschlecht = sample(c(0, 1), size = 200, replace = TRUE),
  farbe = c(rep("rot", 100), rep("grün", 100)),
  gruppe = sample(c("A", "B", "C"), size = 200, replace = TRUE),
  iq = round(c(rnorm(n = 100, mean = 115, sd = 15), rnorm(n = 100, mean = 90, sd = 15))),
  kekskrümel = rep(c("keks", "krümel"), 100)
)
# Anstatt data.frame() ginge auch tibble() aus dplyr


# Geschlecht rekodieren ----
personen_tobi$geschlecht <- ifelse(personen_tobi$geschlecht == 0, "männlich", "weiblich")
# Alternativ:
personen_tobi$geschlecht <- recode(personen_tobi$geschlecht, `0` = "männlich", `1` = "weiblich")
# recode() kommt aus dplyr!

# Plots ----
library(ggplot2)

# a) zeichne ein Histogramm der Variable `iq` und färbe es blau ein
ggplot(data = personen_tobi, aes(x = iq)) +
  geom_histogram(fill = "blue")

# b) zeichne ein Balkendiagramm der Variable `Gruppe`, aufgeteilt nach Geschlecht
ggplot(data = personen_tobi, aes(x = gruppe, fill = geschlecht)) +
  geom_bar(position = "dodge")

# c) vergleiche die Verteilung der Variable `iq` zwischen Keksen und Krümeln
ggplot(data = personen_tobi, aes(x = iq, fill = kekskrümel)) +
  geom_histogram(position = "dodge")

# Alternativ, fancy:
ggplot(data = personen_tobi, aes(x = iq, fill = kekskrümel)) +
  geom_histogram() +
  facet_wrap(~kekskrümel, ncol = 1)
