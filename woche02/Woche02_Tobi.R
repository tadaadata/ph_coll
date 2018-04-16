##   Woche 2   ##


## Arithmetik / "Rechnen"

3 + 4          # Summierung
3 - 4
3^2
3 / 4
3 * 4

 2 + 2  * 3 # Punkt vor Strich...
(2 + 2) * 3 # ...also Klammern setzen!



## Boolesche Logik

2 == 2  # "ist gleich" als Abfrage immer mit zwei =
2 == 3
2 != 2
4 >= 3
4 <= 3
3 >= 3


3 <= 4 & 4 <= 3
3 <= 4 | 4 <= 3



## Vektoren / Variablen / Objekte
## -> diese Begriffe werden häufig synonym verwendet
num <- c(1, 5, 8.25, 12.13, 89)
num

num + 12        # mit Zahlen rechnen geht


text <- "Haus"

text <- c("Auto", "Haus", "Baum")
text + 12       # mit Text dagegen nicht so...

text2 <- c("5", "7")
text2 - 12      # auch mit als Zahlen verkleideter Text nicht

c(num, text)    # Text & Zahlen lassen sich zwar kombinieren,
                # das neue Objekt ist dann allerdings nur noch Text




## Funktionen / Befehle
mean(c(12, 14, 16))
mean(num)
mean(text)

# weitere:
sd(num)
median(num)

num2 <- 1:100   # ein Doppelpunkt zwischen Zahlen erzeugt eine Reihe von:bis

num3 <- c(12, 14, 17, NA, 29)   # hier fehlt ein Eintrag!
mean(x = num3, na.rm = TRUE)    # also das Argument "na.rm" auf TRUE setzen

# im Zweifelsfall hilft zuerst immer ein Blick in die Hilfe!
?mean


rep(x = 1:5, each = 12)         # "wiederhole jede Zahl zwischen 1 und 5 zwölf mal!"

rnorm(12, mean = 100, sd = 15)  # "erzeuge 12 normalverteilte Zufallszahlen
                                # mit einer SD von 15 um den MW von 100


### kleine Aufgabe
#
# Berechne den MW und die SD von normalverteilten Zufallszahlen
#   a) von 50 Zahlen mit MW 1000 und SD 200
#   b) von 20 Zahlen mit MW 500 und SD 10
#   c) führe die entsprechenden Befehle jeweils 5x aus - was fällt dir auf?

a <- rnorm(50, mean = 1000, sd = 200)
b <- rnorm(20, mean = 500, sd = 10)

mean(a)
mean(b)
sd(a)
sd(b)


### Pakete
# Pakete müssen nur ein einziges mal (!) installiert werden:
install.packages("ggplot2")

# ...aber nach jedem Neustart von RStudio (!) neu geladen werden:
library("ggplot2")

# Analog zum Werkzeugschuppen: ihr braucht die Kettensäge zwar nur ein mal kaufen,
# müsst sie aber jedes Mal, wenn ihr sie benutzen wollt, aus dem Schuppen holen.


# erzeugen wir mit dem befehl 'data.frame()' mal einen Datensatz
# dazu können wir zB Befehle/Funktionen benutzen, die wir schon kennen gelernt haben
data <- data.frame(
  Versuchsperson = rep(1:50, times = 3),
  Tag            = rep(c("Tag 1", "Tag 2", "Tag 3"),
                       each = 50),
  Geruch         = c(rnorm(50, mean = 50, sd = 10),
                     rnorm(50, mean = 75, sd = 10),
                     rnorm(50, mean = 100, sd = 10))
)

# und anschließend zeichnen wir ein paar Grafiken
# mit Hilfe der Funktionen aus dem neu installierten Paket "ggplot2"
ggplot(data = data, aes(x = Tag, y = Geruch, fill = Tag)) +
  geom_boxplot() +
  # geom_point() +
  labs(title = "Geruchsindex nach Festivalaufenthalt in Tagen",
       y     = "Geruchsindex")


ggplot(data = data, aes(x = Versuchsperson, y = Geruch, color = Tag)) +
  geom_point()
