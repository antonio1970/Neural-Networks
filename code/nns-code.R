library(tidyverse)
# Lectura de datos con variables imputadas, mediante el método del k vecinos más cercanos
# Usar fichero de datos del indice total de economía del conocimiento, KEI del Banco Mundial (Ese índice varía de 0 a 10)

# Lectura de datos del tipo csv, juntando datos imputados y el KEI (afdata_imputed, and kei)

# Read the KE Index and create a dataframe

kei <- read.csv("../Neural-Networks/data/keindex.csv")
kei$X= NULL
colnames(kei) <- c("Country", "Year", "KEI_Index")
kei<-kei[order(kei$Year),]


# Merge two files with another column with the KEI index. Initial check
afdata_imputed = read.csv("../Neural-Networks/data/afdata_imputed.csv", header = TRUE, dec = ".", sep = ",")

class(afdata_imputed$Country)
levels(afdata_imputed$Country)

class(kei$Country)
levels(kei$Country)

# Both factors have different levels


combined <- sort(union(levels(afdata_imputed$Country), levels(kei$Country)))
nns_data <- left_join(mutate(afdata_imputed, Country=factor(Country, levels=combined)),
                         mutate(kei, Country=factor(Country, levels=combined)))
nns_data$X <-NULL
write.csv(nns_data, "nns_data.csv")

# We need to scale our dataset before running NNs and load the library neuralnet, and caret package

scaledata <-as.data.frame(scale(nns_data[, c(3:14)]))

# Load libraries
library(neuralnet)
library(caret)




