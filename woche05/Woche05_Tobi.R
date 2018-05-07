  ## Woche 05 ##

### !!! WICHTIG !!!
#
# Dieses Skript arbeitet z.T. mit dem unaufgeräumten GoT-Datensatz,
# Ihr müsst also u.U. entweder den Datensatz neu (und unbearbeitet) neu laden
# oder die Syntax entsprechend anpassen


#############################################
# wie immer zuerst die nötigen Pakete laden:
library("readr")
library("dplyr")
# install.packages("stringr")
library("stringr")
library("ggplot2")

# remember:
# install.packages("Paketname") MUSS bei jedem neuen Paket ein mal gemacht werden
# DANACH kann man erst per library("Paketname") die 'Geräte aus dem Schuppen holen',
# sprich, das Paket benutzen.
# die library("Paketname") Befehle MÜSSEN dann nach jedem Neustart von Rstudio
# neu ausgeführt werden


## Daten einlesen
got <- read_csv("daten/gotdeaths_books.csv")


## Funktionen angucken
?rnorm()
?seq()

# Jede Funktion hat verschieden viele Argumente (siehe jeweils in der Hilfe mit '?')
# Diese KANN man explizit angeben:
rnorm(n = 10, mean = 100, sd = 15)
seq(from = 0, to = 10, by = 2)

# ...man kann sie aber auch einfach so angeben, wobei allerdings die Reihenfolge
# (siehe Hilfe) wichtig ist
seq(0, 10, 2)

# Vergleiche:
rnorm(10, 100, 15)
rnorm(15, 10, 100)
rnorm(mean = 100, sd = 15, n = 10)

# Besonderheit: Befehle au dem dplyr-Paket haben als erstes IMMER ein .data-Argument,
# vgl. (im Hilfe-Fenster jeweils den dplyr-Eintrag klicken):
?filter
?summarise
?group_by

# In 'dplyr' enthalten ist außerdem der 'pipe-Operator':
# %>%
# Damit lässt sich ein Objekt oder der Output einer Funktion in eine weitere Funktion weiterleiten

# ohne pipe:
filter(got, Allegiances == "Lannister")

# mit pipe:
got %>%
  filter(Allegiances == "Lannister")

# und zwar beliebig oft:
got %>%
  filter(Allegiances == "Lannister") %>%
  count(Nobility)   # Was passiert hier?
                    # -> "nimm den got-Datensatz" %>%
                    #       "behalte nur die Lannisters" %>%
                    #       "und zähle in der Spalte 'Nobility' die Nullen und Einsen"

# im Augenblick noch nicht soo mächtig/wichtig,
# aber ab jetzt werden wir mehr und mehr damit anstellen
#
# Pro-Tip:
# um nicht immer Prozent-größer-Prozent tippen zu müssen,
# reicht die Tastenkombination strg+shift+m (cmd+shift+m für Mac-User)

#################
## Aufräumaktion

# Übersicht über die Spaltennamen:
names(got)

# Übersicht über die Einträge von 'Allegiances':
unique(got$Allegiances)

# vgl.:
got$Allegiances
unique(got$Allegiances)


# wir wollen also die Leerzeichen aus den Spaltennamen und "doppelten" Einträge
# in 'Allegiances' los werden.
# dazu haben wir anfangs das Paket 'stringr' installiert und geladen
names(got) <- str_replace_all(names(got), pattern = " ", replacement = "_")

# str_replace_all() sucht (hier) im output von names(got) (s.o.) nach dem Muster " ",
# also einem Leerzeichen, und ersetzt alle Leerzeichen mit einem Unterstrich

# ähnlich für Allegiances:
# wir wollen hier quasi das Muster "House " mit "" erstzen, effektiv also entfernen
# dafür gibt es str_remove():
got_neu <- got %>%
  mutate(
    Allegiances = str_remove(Allegiances, "House ")
  )

# mit mutate() lassen sich Daten manipulieren und "mutieren";
# hier wollen wir die Spalte 'Allegiances' manipulieren -
# darin enthalten sein soll der Output des Befehls str_remove(Allegiances, "House ")
#
# da es die Spalte 'Allegiances' vorher bereits gab, wird diese hierbei verändert
# stattdessen hätte man auch eine neue Spalte erstellen können, vgl.:
test <- got %>%
  mutate(
    Auto = str_remove(Allegiances, "House ")
  )

unique(test$Auto)

## Überprüfen wir nochmal die Ergebnisse
#
# vorher:
names(got)
unique(got$Allegiances)

# nachher:
names(got_neu)
unique(got_neu$Allegiances)


############
# mit dem jetzt etwas aufgeräumteren Datensatz können wir direkt eine
# bessere Grafik erstellen als beim letzten mal:
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
