# Der Game of Thrones (Books only) Datensatz
# https://data.tadaa-data.de/gotdeaths_books.rds
library(readr)

gotbooks <- read_rds("daten/gotdeaths_books.rds")

# Erste paar Zeilen angucken
head(gotbooks)

# Allegiances
unique(gotbooks$Allegiances)

# Wir stellen fest: Duplikate ("House Stark" + "Stark") :(

library(dplyr)

gotbooks %>%
  group_by(Allegiances) %>%
  tally()


# Saubermachen: Allegiances ----
library(stringr)

# Ohne speichern, nur gucken (Zuweisung in gotbooks)
gotbooks %>%
  mutate(Allegiances = str_remove(Allegiances, "House\\ "))

# Mit speichern
gotbooks <- gotbooks %>%
  mutate(Allegiances = str_remove(Allegiances, "House\\ "))

# Nochmal angucken
gotbooks %>%
  group_by(Allegiances) %>%
  tally()

# Rekodieren ----
unique(gotbooks$Gender) # 0 = Weiblich; 1 = Männlich
unique(gotbooks$Nobility)


gotbooks <- gotbooks %>%
  mutate(Gender = recode_factor(Gender, `0` = "Female", `1` = "Male"))

# Gender ist jetzt ein factor
gotbooks$Gender


# Dasselbe für Nobility
gotbooks <- gotbooks %>%
  mutate(Nobility = recode_factor(Nobility, `0` = "Non-Noble", `1` = "Nobility"))

# Nobility ist jetzt auch ein factor
gotbooks$Nobility


# Für Spaß: Kontingenztabelle
# In simpel
table(gotbooks$Nobility, gotbooks$Gender)

# In schick
library(sjPlot)
sjt.xtab(gotbooks$Nobility, gotbooks$Gender)

# Spaltennamen ----
names(gotbooks)

# Zum ausprobieren
names(gotbooks) %>%
  str_replace_all(pattern = " ", replacement = "_") %>%
  str_to_lower()

# Zum Zuweisen/speichern
names(gotbooks) <- names(gotbooks) %>%
  str_replace_all(pattern = " ", replacement = "_") %>%
  str_to_lower()

names(gotbooks)

# Wide und Long format
library(tidyr)

head(gotbooks)

# Wir haben 5 Spalten, je eine pro Buch, die anzeigen ob eine Person im Buch vorkommt
# Ziel: Zwei Spalten. Eine "Buchtitel", eine "Person taucht auf ja/nein"

gotbooks %>%
  gather(key = "book", value = "appearance", got, cok, sos, ffc, dwd)

# gather = "fasse zusammen"
# Variable "book" (key) entählt die alten Variablennamen (got, cok, sos, ffc, dwd)
# Variable appearance (value) enthält die alten Werte (0 oder 1)
# Der resultierence Datenstaz ist deutlich länger! 5 Zeilen pro Person, eine Zeile pro Buch

# Speichern
gotbooks_long <- gotbooks %>%
  gather(key = "book", value = "appearance", got, cok, sos, ffc, dwd)

# Jetzt sind wir flexibler
gotbooks_long %>%
  group_by(book) %>%
  summarize(appearances_sum = sum(appearance))

# Plots? ----
library(ggplot2)

ggplot(data = gotbooks_long, aes(x = book, y = appearance)) +
  geom_col()

# Sortiert nach Häufigkeit
# Gruppieren nach "book", "appearance" zählen
gotbooks_long %>%
  group_by(book) %>%
  tally(appearance)

# Piping von dplyr direkt in ggplot stuff
gotbooks_long %>%
  group_by(book) %>%
  tally(appearance) %>%
  ggplot(aes(x = reorder(book, n), y = n)) +
  geom_col() +
  labs(title = "A Song of Ice and Fire",
       subtitle = "Characters per Book",
       x = "Book", y = "Character Appearances")
