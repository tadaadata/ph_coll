##### R-Basics ####
# Das hier ist ein R-Script. Jede Zeile sollte funktionierender R-Code sein.
# Alles was rechts von # steht wird ignoriert und dient der Dokumentation
# Wir nennen das auch "auskommentieren", weil wir so auch Befehle weglassen können
# Zeilen können via "Run"-Button oder Strg bzw cmd + Enter ausgeführt werden

# Arithmetik / Grundrechenarten ----

3 + 4           ## Addition
3 - 4           ## Subtraktion
3 * 4           ## Multiplikation
3 / 4           ## Division
3 ^ 4           ## Potenzierung... Potentiation? Potenzkram halt

2 + 2 * 3       ## Punkt vor Strich
(2 + 2) * 3     ## ...ergo: Klammern setzen, wo nötig

# Variablen ----

# Eine Liste (bzw. Vektor) von Zahlen
c(26, 34, 23, 67, 32, 12)

# Zahlen in Objekt "alter" abspeichern (Groß- und Kleinschreibung!)
alter <- c(26, 34, 23, 67, 32, 12)

# Wir können jetzt mit "alter" Dinge tun
mean(alter) # Mittelwert (mean)
sd(alter)   # Standardabweichung (standard deviation)

# alter2 erstellen als das 5-fache von alter
alter2 <- alter * 5

# Mit zwei Variablen rechnen
alter2 + alter

# Vektor von Namen speichern
namen <- c("lukas", "tobi", "kunigunde", "nadine", "wurstwasser", "peter")
