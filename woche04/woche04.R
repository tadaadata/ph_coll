# Der Game of Thrones (Books only) Datensatz
# https://data.tadaa-data.de/gotdeaths_books.rds
library("readr")

# von lokal
gotbooks <- read_rds("daten/gotdeaths_books.rds")

# von internet
gotbooks <- read_rds(url("https://data.tadaa-data.de/gotdeaths_books.rds"))

# Erste paar Zeilen angucken
head(gotbooks)

# Allegiances
unique(gotbooks$Allegiances)

# Wir stellen fest: Duplikate ("House Stark" + "Stark") :(

library("dplyr")

gotbooks %>%
  group_by(Allegiances) %>%
  tally()


# Saubermachen: Allegiances ----
library("stringr")

# Ohne speichern, nur gucken (Zuweisung in gotbooks)
gotbooks %>%
  mutate(Allegiances = str_remove(Allegiances, "House\\ "))

# Mit speichern
gotbooks <- gotbooks %>%
  mutate(Allegiances = str_remove(Allegiances, pattern = "House\\ ")) # regex

# Nochmal angucken
gotbooks %>%
  group_by(Allegiances) %>%
  tally() %>%
  arrange(desc(n)) # arrange DESCending (absteigend sortieren)

# identisch aber kürzer
gotbooks %>%
  count(Allegiances) %>%
  arrange(desc(n))


library("ggplot2")

gotbooks %>%
  count(Allegiances) %>%
  ggplot(aes(x = reorder(Allegiances, n), y = n)) +
  geom_col() +
  coord_flip()


# Rekodieren ----
unique(gotbooks$Gender) # 0 = Weiblich; 1 = Männlich
unique(gotbooks$Nobility)


gotbooks <- gotbooks %>%
  mutate(Gender = recode_factor(Gender, `0` = "Female", `1` = "Male"))

# dasselbe wie:
gotbooks$Gender <- recode_factor(gotbooks$Gender, `0` = "Female", `1` = "Male")

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

library("stringr")

# Zum ausprobieren
names(gotbooks) %>%
  str_replace_all(pattern = " ", replacement = "_") %>%
  str_to_lower()

# Zum Zuweisen/speichern
names(gotbooks) <- names(gotbooks) %>%
  str_replace_all(pattern = " ", replacement = "_") %>%
  str_to_lower()

names(gotbooks)
