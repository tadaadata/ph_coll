library(readxl)

nri <- read_excel("/Volumes/GROUPON/NRI_Export_2018-05-02.xlsx")

names(nri)

library(stringr)

names(nri) <- str_remove(names(nri), pattern = "DatenNRI::")

nri$q4_Gesundheitszustand <- as.numeric(str_extract(nri$q4_Gesundheitszustand, "\\d+"))

library(dplyr)


nri$q4_Gesundheitszustand <- nri$q4_Gesundheitszustand %>%
  str_extract("\\d+") %>%
  as.numeric()



nri %>%
  filter(q4_Gesundheitszustand <= 5) %>%
  summarize(mean_gesundheit = mean(q4_Gesundheitszustand),
            sd_gesundheit = sd(q4_Gesundheitszustand))

nri %>%
  summarize(median_gesundheit = median(q4_Gesundheitszustand, na.rm = TRUE),
            iqr_gesundheit = IQR(q4_Gesundheitszustand, na.rm = TRUE))


nri %>%
  group_by(q14_Familienstand) %>%
  tally()


nri %>%
  group_by(q14_Familienstand, q1_Land) %>%
  tally() %>%
  arrange(n)


nri %>%
  group_by(q14_Familienstand, q1_Land) %>%
  tally() %>%
  arrange(desc(n))

library(ggplot2)

nri %>%
  filter(q4_Gesundheitszustand <= 5) %>%
  ggplot(aes(x = q4_Gesundheitszustand)) +
  geom_bar()

##


nri$q19_Absagegrund <- nri$q19_Absagegrund %>%
  str_extract("\\d+") %>%
  as.numeric()

nri %>%
  filter(q19_Absagegrund< 1000) %>%
  ggplot(aes(x = q19_Absagegrund)) +
  geom_bar()

