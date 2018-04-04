## Das tidyverse:
## eine Sammlung vieler Pakete aus der gleichen Schmiede, die einem das Leben vereinfachen:
## unter und vor allem: ggplot2, dplyr, readr & haven


##### Installation ####
# kann, auf alten oder sehr leistungsschwachen Rechnern eine Weile dauern

install.packages("ggplot2")         # Pakete müssen nur ein mal INSTALLIERT...
install.packages("dplyr")           # das macht der Befehl/die Funktion install.packages()
install.packages("readr")

library(ggplot2)                    # ...aber nach jedem Start von RStudio neu GELADEN werden
library(dplyr)                      # durch die Funktion library()
library(readr)


#### Datensätze laden (per Code) ####

# RDS Datensätze müssen immer mehr oder weniger direkt angesteuert werden
qm  <- file.choose() %>% readRDS()

# Oder "manuell"
# "data/qm-survey-2017-R.rds" ist der Pfad zur Datei, der sieht bei euch anders aus!
qm  <- readRDS("data/qm-survey-2017-R.rds")



# csv Daten (o.ä.) können bequem das erste mal durch klicken ('Import Dataset', rechts) geladen werden,
# der Code wird dabei angegeben: copy&paste und beim zweiten mal ist es nur ein Tastendruck
got <- read_csv("data/gotdeaths_books.csv")



#### Ein paar hübsche Plots bauen ####

# Tode in den ASOIAF-Büchern nach Häusern (u.a.)
got %>%                               # nimm das Objekt: got
  filter(!is.na('Death Year')) %>%    # entferne alle Zeilen, die in der Spalte "Death Year"
  # nicht NA sind (siehe Boolesche Logik)
  count(Allegiances) %>%              # erstelle eine Häufigkeitsübersicht ("zähle") der Einträge
  # der Variable "Allegiances"
  ggplot(aes(x = reorder(Allegiances, n), y = n)) + # Erstelle eine Grafik mit der nach Häufigkeit
  # sortierten Variable "Allegiances" auf der x-Achse
  # und der Häufigkeit auf der y-Achse
  geom_col() +                      # die Grafik soll ein Balkendiagramm sein
  labs(y = "Tode", x = "Loyalität", title = "Tode in Game of Thrones",
       subtitle = "basierend auf den Büchern") +  # beschrifte die Achsen
  coord_flip()                      # und drehe die Grafik (sodass die Beschriftung lesbar ist)


# Anzahl Sexualpartnerschaften nach Parteipräferenz
qm %>%                                                        # nimm den Datensatz qm
  filter(partnerinnen <= 15, !is.na(partei)) %>%              # behalte alle Werte, auf die Filter zutreffen
  ggplot(aes(x = partei, y = partnerinnen, fill = partei)) +  # erstelle eine Grafik; 'fill' färbt Daten ein
  geom_boxplot() +                                          # die Grafik soll ein Boxplot sein
  labs(x = "Partei", y = "Anzahl Sexualpartnerschaften") +  # beschrifte die Achsen
  coord_flip() +                                            # drehe die Grafik
  theme(legend.position = "none")                           # und blende die Legende aus


### Hinweise:
# bei den Grafiken könnt ihr gerne jede Zeile nacheinander ausführen und schauen, was raus kommt, zB:
qm %>%
  filter(partnerinnen <= 15, !is.na(partei))  # es bleiben dann nur noch 91 Beobachtungen übrig

# oder
qm %>%
  filter(partnerinnen <= 15, !is.na(partei)) %>%
  ggplot(aes(x = partei, y = partnerinnen, fill = partei)) +
  geom_boxplot() # gibt auch eine Grafik aus, aber es fehlen Details
