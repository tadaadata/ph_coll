# es ist gute Praxis, die für das Script benötigten Pakete am Anfang
# aufzulisten und ggf. zu ergänzen, damit man sie gleich auf einen Haufen laden kann
library(readr)        # readr für das (einfache) Einlesen von csv-Dateien
library(dplyr)        # für das filtern unserer Daten
library(ggplot2)      # zur Erstellung von Grafiken



# der _eigentliche_ Befehl, der ausgeführt wird, wenn wir
# oben rechts unter "import Dataset -> From Text (readr)..." etwas laden
got <- read_csv("daten/gotdeaths_books.csv")  # diese Zeile funktioniert NUR BEI MIR
                                              # ihr müsst die Datei selber auswählen
                                              # und anschließend den Code kopieren!



# in dem nun geladenen Datensatz 'got' können die einzelnen Spalten so abgerufen werden,
# wie wir es letzte Woche mit selbst erstellen Variablen gemacht haben
# wir müssen jetzt nur mit dem Namen des Datensatzes, gefolgt vom $-Zeichen und dann
# dem Namen der Spalte/der Variable, die wir abrufen möchten
got$Name

# man kann sich auch zunächst alle Spalten-/Variablennamen ausgeben lassen:
names(got)

# dabei stellen wir fest: es gibt einige Spalten, deren Namen Leerzeichen enthalten,
# womit R zunächst nicht umgehen kann:
got$Death Year      # das "unerwartete Symbol" ist dabei das Leerzeichen;
                    # wir werden auch mehr oder weniger freundlich durch ein weiß-rotes X
                    # am linken Bildschirmrand darauf hingewiesen, dass da etwas nicht stimmt

# um dennoch auf die Variable zuzugreifen, müssen wir Namen mit Leerzeichen in Backticks packen:
got$`Death Year`    # Achtung: NICHT '' oder ´´ !

# so wie letzte Woche mit einzelnen Objekten, können wir auch Spalten einfach
# in Funktionen stecken
mean(got$`Death Year`, na.rm = TRUE)  # reminder: das Argument 'na.rm = TRUE'
                                      # entfernt alle NAs aus der Berechnung



###############################################################################
## Kommen wir zu den eigentlich spannenden Fragen, z.B.
## Welches Haus hat die größten Verluste

# zunächst mal die einfachst-mögliche Übersicht ALLER
# Haus-Zugehörigkeiten (also auch der (noch) Lebenden)
table(got$Allegiances)

# wie praktisch alles in R, kann man auch Tabellen als Objekt speichern...
tbl <- table(got$Allegiances)

# ... und in anderen Befehlen weiterverwenden:
prop.table(tbl)     # z.B. für eine Tabelle mit relativen Werten


# um ausschließlichen die bereits toten Personen zu untersuchen,
# bietet sich an, das Paket 'dplyr' zu installieren und zu nutzen
# reminder: Pakete müssen nur EIN mal installiert ('install.packages()'),
#           aber nach JEDEM Neustart auch neu geladen ('library()') werden!
#           -> siehe Beginn des Scripts
# install.packages("dplyr")

# dplyr enthält den Befehl filter(), mit dem sich Zeilen eines Datensatzes
# anhand bestimmter Merkmale oder Eigenschaften auswählen lassen
# dafür braucht es die logischen Vergleiche (siehe Woche 2)
#
# Wir können zB unsere Auswahl nur auf die Nachtwache beschränken:
wache <- filter(got, Allegiances == "Night's Watch")
wache$Allegiances

  # Was ist passiert?
  # der Befehl filter() schaut in diesem Beispiel, ob im Datensatz 'got'
  # in jeder Zeile der Spalte 'Allegiances' der Text "Night's Watch" steht
  # wenn nicht, wird die Zeile einfach rausgeschmissen

# das Prinzip lässt sich auf viele Arten erweitern:
# die Spalte `Death Year` enthält logischerweise NAs, wenn die Person noch lebt
got$`Death Year`

# und der Befehl is.na() schaut, oder eine Zeile ein NA-Wert ist, oder nicht:
is.na(got$`Death Year`)
  # reminder: NAs sind nur "nicht sinnvoll anwendbare Werte"
  # TRUE: es liegt ein NA vor (hier: die Person lebt noch)
  # FALSE: es liegt ein sinnvoller Wert vor (hier: eine Jahreszahl, die Person ist also tot)

# da wir aber wissen wollen, wer denn nun alles bereits tot ist, müssen wir den
# Befehl anders formulieren: statt "liegt ein NA vor?" also "liegt KEIN NA vor?"
# das machen wir mit einem ! vor dem Befehl -- hier der Vergleich:
is.na(got$`Death Year`)       # "liegt ein NA vor?"
!is.na(got$`Death Year`)      # "liegt KEIN NA vor?"


# und weil dadurch eine einfache ja/nein Unterscheidung gemacht wird,
# lässt sich das wiederum im filter()-Befehl anwenden:
tote <- filter(got, !is.na(`Death Year`))

# vergleich:
tbl
table(tote$Allegiances)


# jetzt ist eine Tabelle mit so vielen Kategorien
# allerdings nicht besonders übersichtlich, deswegen:
# to the plotting! /o/
ggplot(data = tote, aes(x = Allegiances)) +   # das Grundgerüst der Darstellung
  geom_bar() +      # ...als Balkendiagramm
  coord_flip()      # ...wegen der Lesbarkeit um 90° gedreht
