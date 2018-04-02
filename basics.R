##### R- Basics ####
# --> partial credit to Mark Heckmann & Kilian Gloy

#### Arithmetik / Grundrechenarten ####

3 + 4           ## Addition
3 - 4           ## Substraktion
3 * 4           ## Multiplikation
3 / 4           ## Division
3 ^ 4           ## Potenzierung

2 + 2 * 3       ## Punkt vor Strich
(2 + 2) * 3     ## ...ergo: Klammern setzen, wo nötig




#### (Boolesche) Logik ####
# --> ist sehr nützlich, um bestimmte Beobachtungen in Datensätzen auszuwählen

2 == 2             ## ist gleich
2 != 2             ## ist NICHT gleich
3 < 4              ## kleiner / größer als
4 <= 3             ## kleiner / größer _gleich_ als
!4 <= 3           ## Negation dessen (NICHT größer / kleiner)


TRUE               ## feste logische Werte; quasi 1/0 oder ja/nein
FALSE
T                  ## können abgekürzt...
F

TRUE & TRUE        ## ...und kombiniert werden (logisches UND)
TRUE & FALSE       ## heißt: ist nur TRUE, wenn beide Konditionen zutreffen
FALSE & TRUE
FALSE & FALSE

3<5 & 3==9         ## Beispiele
3<5 & 3!=9

TRUE | TRUE        ## logisches ODER
TRUE | FALSE       ## heißt: ist TRUE, wenn EINE der beiden Konditionen zutrifft;
FALSE | TRUE       ## Bsp.: Ist das Stop-Schild rot ODER weiß? -> Ja (TRUE)
FALSE | FALSE

3<5 | 3==9         ## die gleichen Beispiele wie beim UND, aber andere Ergebnisse
3<5 | 3!=9




#### Objekte / Vektoren ####

num <- 25                   ## "Speichere" die Nummer 25 in das Objekt 'num'
num                         ## danach lässt sich das Objekt 'num' aufrufen und enthält die Nummer 25
num - 12                    ## und mit dem Objekt lässt sich wieder rechnen
Num                         ## Bedenke: R unterscheidet Groß- und Kleinschreibung
## -> klassische Fehlerquelle bei Anfänger*innen!

vec1 <- c(25, 6, 98, -12)   ## Ein Objekt kann auch aus mehreren Nummern bestehen (nennt sich Vektor)
vec1


vec2 <- c(25, 6, 98, -12)
vec2
vec2[3] <- 66               ## Mit eckigen Klammern lassen sich bestimmte Elemente eines Vektors auswählen
vec2

vec1 - vec2                 ## mit mehreren Vektoren lässt sich auch wiederum rechnen
vec1 * vec2


text1 <- "Let's talk about text, baby"          ## Objekte können auch aus Text bestehen...
text2 <- "5"                                    ## ...und Nummern können wie Text behandelt werden
text2 + 10                                      ## was ebenfalls eine übliche Fehlerquelle ist




#### Funktionen / Deskriptive Statistiken ####
mean(vec1)                ## Wenn auf ein Wort (o.ä.) direkt runde Klammern folgen, ist das eine "Funktion";
## innerhalb der Klammern stehen "Argumente"
sd(vec1)                  ## bisher haben wir hier nur ein Argument: das Objekt 'vec1'


?mean                     ## mit einem ? vor dem Funktionsnamen ruft man eine Hilfe-Seite zur Funktion auf
?sd                       ## wenn z.B. unklar ist, welche Argumente eine Funktion "hören will" -> Hilfe aufrufen!


vec3 <- c(2, 3, 4, 2, 3, 3, 2, 4, 2, 4, 5, 6)

vec3[1] <- NA             ## setzen wir mal einen Wert in 'vec3' auf NA; das steht für "Not Available"
vec3
is.na(vec3)               ## prüft jeden Wert einzeln darauf, ob er NICHT vorhanden ist
## quasi: "Ist der Wert NA?" -> TRUE, FALSE, FALSE...
anyNA(vec3)               ## prüft __für das ganze Objekt__, ob NAs vorhanden sind

mean(vec3)                ## sind NAs vorhanden, funktioniert mean() aufmal nicht mehr...
mean(vec3, na.rm = T)     ## also brauchen wir ein zweites Argument, das der Funktion sagt,
## dass NAs ignoriert und der MW anhand der restlichen Werte berechnet werden soll

mean(vec3, 0, T)          ## Funktionen kommen auch klar, ohne die Argumente zu benennen, wenn man sich an
## die Reihenfolge aus der Hilfe (?mean) hält

vec3[1] <- 2

median(vec3)                                 ## grundlegende Funktionen haben intuitive Namen;
## mean, sd, var, median...
quantile(vec3, probs=c(0.25, 0.5, 0.75))     ## es gibt eine Funktion für Quantile;
## durch Argumente werden Qua-R-tile draus

modus(vec3)                                  ## aber nicht ALLES ist automatisch oder einfach vorhanden
??modus                                      ## mit zwei ?? lassen sich ALLE pakete durchsuchen
library(tadaatoolbox)                        ## und um die Funktion modus() zu benutzen,
modus(vec3)                                  ## müssen wir ein installiertes Paket laden



#### Ein paar nützliche Tips ####
# 1. Kommentiert IMMER was ihr tut! (Jeder vernachlässigt das, nur um sich später drüber zu ärgern)
# 2. Schaut euch die Hilfe-Seiten an, um ein wenig über die benutzen Funktionen zu lernen
# 3. Wenn ihr ein komplexes Problem habt, durchsucht das Internet; es ist SEHR wahrscheinlich, dass vor euch
#    schon mal jemand das gleiche Problem hatte (und es gelöst wurde)
# 4. Wenn ihr nach R-Dingen sucht, schaut am besten gleich auf stackoverflow.com nach
# 5. Gebt euren Objekten Namen, mit denen ihr was anfangen könnt (mehr als ein Buchstabe zB!);
#    wenn ihr später die Objekte 'bla', 'fu', 'dings', 'meh' und 'lol' habt, wird's schnell verwirrend
# 6. Wenn ihr Fehlermeldungen erhaltet, prüft zuerst, ob ihr alles richtig und an die richtige Stelle geschrieben habt!
#    Oft verursachen sehr einfache Dinge Probleme; Kommata/Punkte, Groß/Klein, nicht geschlossene Klammern...
