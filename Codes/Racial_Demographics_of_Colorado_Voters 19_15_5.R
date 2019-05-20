# Import Libraries
library(data.table)
library(tidyverse)
library(scales)
library(directlabels)
library(dplyr)

#Set dirrectory
setwd("/Users/ksorauf/OneDrive - Regis University/Gocode/2019")

# Set seed
set.seed(1)

# Import data files
# dt = Denver Voters Master
dt <- fread("Denver_Voters_Master_2014-2019_new.csv")
# ct = Census block data with lattitudes and longitudes for attach to Denver Voters
ct <- fread("DenverCensusBlockGroup_Geoinfo20190421-1542.csv")

# Change the name of the CensusBlockGroup to be consistant with the Denver Voters 
setnames(ct, old="Tract-CensusBlockGroup", new="Tract-CensusBlock")

# Merge the two data sets on the Tract-CencusBlock column
dt <- merge(dt, ct, by="Tract-CensusBlock", all.x=TRUE)

# Factor Gender and Party
dt$Gender <- as.factor(dt$Gender)
dt$Party <- as.factor(dt$Party)

# Set the threashold for race identification. If 90% of people with a given last name identify as a certain race we include
# them in the the analysis
thresh <- 90

# Create new data tables with voters that identify as a given race over the set threshold
avoters <- dt[dt$PercentAsianAndNativeHawaiianAndOtherPacificIslanderAlone >= thresh]
bvoters <- dt[dt$PercentBlackOrAfricanAmericanAlone >= thresh]
wvoters <- dt[dt$PercentWhiteAlone >= thresh]
hvoters <- dt[dt$PercentHispanicOrLatinoOrigin >= thresh]
nvoters <- dt[dt$PercentAmericanIndianAndAlaskaNativeAlone >= thresh]


# Create a data table of total voters by race
totvotes = NULL
totvotes <- data.table(asain = avoters[,.N,by=Year],
                       black = bvoters[,.N,by=Year],
                       white = wvoters[,.N,by=Year],
                       hispanic = hvoters[,.N,by=Year],
                       native = nvoters[,.N,by=Year],
                       total = dt[,.N,by=Year])
totvotes <- totvotes[, c("black.Year", "white.Year", "hispanic.Year", "native.Year", "total.Year") := NULL]
setnames(totvotes,c("year","asian","black","white","hispanic","native","total"))
totvotes <- totvotes[(order(year))]
totvotes.m <- melt(totvotes, "year")
subtotvotes.m <- totvotes.m[!totvotes.m$variable == 'total']
subtotvotes.m <- subtotvotes.m[!subtotvotes.m$variable == 'native']
subtotvotes.m <- subtotvotes.m[!subtotvotes.m$variable == 'black']

# Plot total voters by race
ggplot(data = totvotes.m, aes(x = year, y = value , colour = variable)) + geom_line()+ geom_point() + 
  ggtitle("Total Voters by Race") +  scale_y_continuous(name="Number of Registered Voters", labels = comma) + 
  scale_x_continuous(name="Year")

# Create a data table of percent voters by race
pervotes = NULL
pervotes = data.table(year = totvotes$year,
                      perasian = totvotes$asian/totvotes$total,
                      perblack = totvotes$black/totvotes$total,
                      perwhite = totvotes$white/totvotes$total,
                      pernhispanic = totvotes$hispanic/totvotes$total,
                      pernative = totvotes$native/totvotes$total)
pervotes.m <- melt(pervotes, "year")

# Plot percent voters by race
ggplot(data = pervotes.m, aes(x = year, y = value , colour = variable)) + geom_line()+ geom_point() + ggtitle("Percent Voters by Race") +
  scale_y_continuous(name="Percent of Total Registerd Voters") + scale_x_continuous(name="Year")

# Create a data table of party voters by race
partvotes = NULL
partvotes <- data.table(dem = dt[,.N,by=.(Party, Year)])
setnames(partvotes,c("party","year","voters"))
partvotes <- partvotes[(order(year))]

# Plot party voters by race
ggplot(data = partvotes, aes(x = year, y = voters, group = party ,colour = party)) + geom_line()+ geom_point() + ggtitle("Total Voters by Party") + 
  scale_x_continuous(name="Year") + scale_y_continuous(name="Number of Voters", labels = comma)

# Calcualte percent change of voters by race
perchange <- partvotes %>% group_by(party) %>% arrange(year, .by_group = TRUE) %>% mutate(pct_change = (voters/lag(voters) - 1) * 100)

##############################################
# Plot party voters by race

# Asian voters by politcal party and plot
avoters1 <- avoters[avoters$Status == 'Active']
apartvotes <- avoters1[,.N,by=.(Year, Party)]
ggplot(data = apartvotes, aes(x = Year, y = N, group = Party ,colour = Party)) + geom_line()+ geom_point() + ggtitle("Asian Voters by Party") + 
  scale_x_continuous(name="Year") + scale_y_continuous(name="Number of Voters", labels = comma)

# Black voters by politcal party and plot
bvoters1 <- bvoters[bvoters$Status == 'Active']
bpartvotes <- bvoters1[,.N,by=.(Year, Party)]
ggplot(data = bpartvotes, aes(x = Year, y = N, group = Party ,colour = Party)) + geom_line()+ geom_point() + ggtitle("Black Voters by Party") + 
  scale_x_continuous(name="Year") + scale_y_continuous(name="Number of Voters", labels = comma)

# Hispanic voters by politcal party and plot
hvoters1 <- hvoters[hvoters$Status == 'Active']
hpartvotes <- hvoters1[,.N,by=.(Year, Party)]
ggplot(data = hpartvotes, aes(x = Year, y = N, group = Party ,colour = Party)) + geom_line()+ geom_point() + ggtitle("Hispanic Voters by Party") + 
  scale_x_continuous(name="Year") + scale_y_continuous(name="Number of Voters", labels = comma)

# Native voters by politcal party and plot
nvoters1 <- nvoters[nvoters$Status == 'Active']
npartvotes <- nvoters1[,.N,by=.(Year, Party)]
ggplot(data = npartvotes, aes(x = Year, y = N, group = Party ,colour = Party)) + geom_line()+ geom_point() + ggtitle("Native Voters by Party") + 
  scale_x_continuous(name="Year") + scale_y_continuous(name="Number of Voters", labels = comma)

# White voters by politcal party and plot
wvoters1 <- wvoters[wvoters$Status == 'Active']
wpartvotes <- wvoters1[,.N,by=.(Year, Party)]
ggplot(data = wpartvotes, aes(x = Year, y = N, group = Party ,colour = Party)) + geom_line()+ geom_point() + ggtitle("White Voters by Party") + 
  scale_x_continuous(name="Year") + scale_y_continuous(name="Number of Voters", labels = comma)

# Total voters by politcal party and plot
dt1 <- dt[dt$Status == 'Active']
tpartvotes <- dt1[,.N,by=.(Year, Party)]
ggplot(data = tpartvotes, aes(x = Year, y = N, group = Party ,colour = Party)) + geom_line()+ geom_point() + ggtitle("Total Voters by Party") + 
  scale_x_continuous(name="Year") + scale_y_continuous(name="Number of Voters", labels = comma)


##########################################
# Find voters that changed party based on race

# Number of Asian voters that changed party
achange = NULL
au <- unique(avoters$VoterID)
for (i in au){
  if(length(unique(avoters$Party[avoters$VoterID == i])) > 1) achange <- rbind(avoters[avoters$VoterID == i], achange)
}
achange <- achange[with(achange, order(VoterID,Year)), ]
length(unique(achange$VoterID))

# Number of Black voters that changed party
bchange = NULL
bu <- unique(bvoters$VoterID)
for (i in bu){
  if(length(unique(bvoters$Party[bvoters$VoterID == i])) > 1) bchange <- rbind(bvoters[bvoters$VoterID == i], bchange)
}
bchange <- bchange[with(bchange, order(VoterID,Year)), ]
length(unique(bchange$VoterID))

# Number of White voters that changed party
wchange = NULL
wu <- unique(wvoters$VoterID)
for (i in wu){
  if(length(unique(wvoters$Party[wvoters$VoterID == i])) > 1) wchange <- rbind(wvoters[wvoters$VoterID == i], wchange)
}
wchange <- wchange[with(wchange, order(VoterID,Year)), ]
length(unique(wchange$VoterID))

# Number of Hispanic voters that changed party
hchange = NULL
hu <- unique(hvoters$VoterID)
for (i in hu){
  if(length(unique(hvoters$Party[hvoters$VoterID == i])) > 1) hchange <- rbind(hvoters[hvoters$VoterID == i], hchange)
}
hchange <- hchange[with(hchange, order(VoterID,Year)), ]
length(unique(hchange$VoterID))

# Number of Native voters that changed party
nchange = NULL
nu <- unique(nvoters$VoterID)
for (i in nu){
  if(length(unique(nvoters$Party[nvoters$VoterID == i])) > 1) nchange <- rbind(nvoters[nvoters$VoterID == i], nchange)
}
nchange <- nchange[with(nchange, order(VoterID,Year)), ]
length(unique(nchange$VoterID))


#############################################################
# Find which party voters changed to.  Only considered switches to and from DEM, REP, UAF.

# Find which party Asain voters switched
asmall = droplevels(achange, exclude = c('ACN', 'APV', 'GRN', 'LBR', 'UNI'))
asmall <- asmall[ !is.na(asmall$Party) ]

asmallchange = NULL
asu <- unique(asmall$VoterID)
for (i in asu){
  if(length(unique(asmall$Party[asmall$VoterID == i])) > 1) asmallchange <- rbind(asmall[asmall$VoterID == i], asmallchange)
}
asmallchange <- asmallchange[with(asmallchange, order(VoterID,Year)), ]
asmallchange <- asmallchange[!duplicated(asmallchange[,c('VoterID', 'Party')]),]
ascu <- unique(asmallchange$VoterID)
for (i in ascu){
  
  asmallchange$`REP-UAF`[asmallchange$VoterID == i & asmallchange$Party == "UAF"] = sum(diff(match(c("REP", "UAF") , as.character(asmallchange$Party[asmallchange$VoterID == i]))) == 1)
  asmallchange$`REP-DEM`[asmallchange$VoterID == i & asmallchange$Party == "DEM"] = sum(diff(match(c("REP", "DEM") , as.character(asmallchange$Party[asmallchange$VoterID == i]))) == 1)
  #  
  asmallchange$`UAF-REP`[asmallchange$VoterID == i & asmallchange$Party == "REP"] = sum(diff(match(c("UAF", "REP") , as.character(asmallchange$Party[asmallchange$VoterID == i]))) == 1)
  asmallchange$`UAF-DEM`[asmallchange$VoterID == i & asmallchange$Party == "DEM"] = sum(diff(match(c("UAF", "DEM") , as.character(asmallchange$Party[asmallchange$VoterID == i]))) == 1)
  #  
  asmallchange$`DEM-REP`[asmallchange$VoterID == i & asmallchange$Party == "REP"] = sum(diff(match(c("DEM", "REP") , as.character(asmallchange$Party[asmallchange$VoterID == i]))) == 1)
  asmallchange$`DEM-UAF`[asmallchange$VoterID == i & asmallchange$Party == "UAF"] = sum(diff(match(c("DEM", "UAF") , as.character(asmallchange$Party[asmallchange$VoterID == i]))) == 1)
}

asmallchange$Race <- 'Asian'


asmallchange1 <- setDT(asmallchange)[, .SD[-1], by = VoterID]


write.csv(asmallchange1, "Asian_Party_Switch_14_19.csv")


# Find which party White voters switched

wsmall = droplevels(wchange, exclude = c('ACN', 'APV', 'GRN', 'LBR', 'UNI'))
wsmall <- wsmall[ !is.na(wsmall$Party) ]

wsmallchange = NULL
wsu <- unique(wsmall$VoterID)
for (i in wsu){
  if(length(unique(wsmall$Party[wsmall$VoterID == i])) > 1) wsmallchange <- rbind(wsmall[wsmall$VoterID == i], wsmallchange)
}
wsmallchange <- wsmallchange[with(wsmallchange, order(VoterID,Year)), ]

wsmallchange <- wsmallchange[!duplicated(wsmallchange[,c('VoterID', 'Party')]),]

wscu <- unique(wsmallchange$VoterID)

for (i in wscu){
  
  wsmallchange$`REP-UAF`[wsmallchange$VoterID == i & wsmallchange$Party == "UAF"] = sum(diff(match(c("REP", "UAF") , as.character(wsmallchange$Party[wsmallchange$VoterID == i]))) == 1)
  wsmallchange$`REP-DEM`[wsmallchange$VoterID == i & wsmallchange$Party == "DEM"] = sum(diff(match(c("REP", "DEM") , as.character(wsmallchange$Party[wsmallchange$VoterID == i]))) == 1)
  #  
  wsmallchange$`UAF-REP`[wsmallchange$VoterID == i & wsmallchange$Party == "REP"] = sum(diff(match(c("UAF", "REP") , as.character(wsmallchange$Party[wsmallchange$VoterID == i]))) == 1)
  wsmallchange$`UAF-DEM`[wsmallchange$VoterID == i & wsmallchange$Party == "DEM"] = sum(diff(match(c("UAF", "DEM") , as.character(wsmallchange$Party[wsmallchange$VoterID == i]))) == 1)
  #  
  wsmallchange$`DEM-REP`[wsmallchange$VoterID == i & wsmallchange$Party == "REP"] = sum(diff(match(c("DEM", "REP") , as.character(wsmallchange$Party[wsmallchange$VoterID == i]))) == 1)
  wsmallchange$`DEM-UAF`[wsmallchange$VoterID == i & wsmallchange$Party == "UAF"] = sum(diff(match(c("DEM", "UAF") , as.character(wsmallchange$Party[wsmallchange$VoterID == i]))) == 1)
}

wsmallchange$Race <- 'White'


wsmallchange1 <- setDT(wsmallchange)[, .SD[-1], by = VoterID]
write.csv(wsmallchange1, "White_Party_Switch_14_19.csv")


# Find which party Hispanic voters switched

hsmall = droplevels(hchange, exclude = c('ACN', 'APV', 'GRN', 'LBR', 'UNI'))
hsmall <- hsmall[ !is.na(hsmall$Party) ]

hsmallchange = NULL
hsu <- unique(hsmall$VoterID)
for (i in hsu){
  if(length(unique(hsmall$Party[hsmall$VoterID == i])) > 1) hsmallchange <- rbind(hsmall[hsmall$VoterID == i], hsmallchange)
}
hsmallchange <- hsmallchange[with(hsmallchange, order(VoterID,Year)), ]

hsmallchange <- hsmallchange[!duplicated(hsmallchange[,c('VoterID', 'Party')]),]

hscu <- unique(hsmallchange$VoterID)

for (i in hscu){
  
  hsmallchange$`REP-UAF`[hsmallchange$VoterID == i & hsmallchange$Party == "UAF"] = sum(diff(match(c("REP", "UAF") , as.character(hsmallchange$Party[hsmallchange$VoterID == i]))) == 1)
  hsmallchange$`REP-DEM`[hsmallchange$VoterID == i & hsmallchange$Party == "DEM"] = sum(diff(match(c("REP", "DEM") , as.character(hsmallchange$Party[hsmallchange$VoterID == i]))) == 1)
  #  
  hsmallchange$`UAF-REP`[hsmallchange$VoterID == i & hsmallchange$Party == "REP"] = sum(diff(match(c("UAF", "REP") , as.character(hsmallchange$Party[hsmallchange$VoterID == i]))) == 1)
  hsmallchange$`UAF-DEM`[hsmallchange$VoterID == i & hsmallchange$Party == "DEM"] = sum(diff(match(c("UAF", "DEM") , as.character(hsmallchange$Party[hsmallchange$VoterID == i]))) == 1)
  #  
  hsmallchange$`DEM-REP`[hsmallchange$VoterID == i & hsmallchange$Party == "REP"] = sum(diff(match(c("DEM", "REP") , as.character(hsmallchange$Party[hsmallchange$VoterID == i]))) == 1)
  hsmallchange$`DEM-UAF`[hsmallchange$VoterID == i & hsmallchange$Party == "UAF"] = sum(diff(match(c("DEM", "UAF") , as.character(hsmallchange$Party[hsmallchange$VoterID == i]))) == 1)
}

hsmallchange$Race <- 'Hispanic'


hsmallchange1 <- setDT(hsmallchange)[, .SD[-1], by = VoterID]

write.csv(hsmallchange1, "Hispanic_Party_Switch_14_19.csv")


# Find which party Black voters switched

bsmall = droplevels(bchange, exclude = c('ACN', 'APV', 'GRN', 'LBR', 'UNI'))
bsmall <- bsmall[ !is.na(bsmall$Party) ]

bsmallchange = NULL
bsu <- unique(bsmall$VoterID)
for (i in bsu){
  if(length(unique(bsmall$Party[bsmall$VoterID == i])) > 1) bsmallchange <- rbind(bsmall[bsmall$VoterID == i], bsmallchange)
}
bsmallchange <- bsmallchange[with(bsmallchange, order(VoterID,Year)), ]
length(unique(bsmallchange$VoterID))

bsmallchange <- bsmallchange[!duplicated(bsmallchange[,c('VoterID', 'Party')]),]

bscu <- unique(bsmallchange$VoterID)

for (i in bscu){
  
  bsmallchange$`REP-UAF`[bsmallchange$VoterID == i & bsmallchange$Party == "UAF"] = sum(diff(match(c("REP", "UAF") , as.character(bsmallchange$Party[bsmallchange$VoterID == i]))) == 1)
  bsmallchange$`REP-DEM`[bsmallchange$VoterID == i & bsmallchange$Party == "DEM"] = sum(diff(match(c("REP", "DEM") , as.character(bsmallchange$Party[bsmallchange$VoterID == i]))) == 1)
  #  
  bsmallchange$`UAF-REP`[bsmallchange$VoterID == i & bsmallchange$Party == "REP"] = sum(diff(match(c("UAF", "REP") , as.character(bsmallchange$Party[bsmallchange$VoterID == i]))) == 1)
  bsmallchange$`UAF-DEM`[bsmallchange$VoterID == i & bsmallchange$Party == "DEM"] = sum(diff(match(c("UAF", "DEM") , as.character(bsmallchange$Party[bsmallchange$VoterID == i]))) == 1)
  #  
  bsmallchange$`DEM-REP`[bsmallchange$VoterID == i & bsmallchange$Party == "REP"] = sum(diff(match(c("DEM", "REP") , as.character(bsmallchange$Party[bsmallchange$VoterID == i]))) == 1)
  bsmallchange$`DEM-UAF`[bsmallchange$VoterID == i & bsmallchange$Party == "UAF"] = sum(diff(match(c("DEM", "UAF") , as.character(bsmallchange$Party[bsmallchange$VoterID == i]))) == 1)
}

bsmallchange$Race <- 'Black'


bsmallchange1 <- setDT(bsmallchange)[, .SD[-1], by = VoterID]

write.csv(bsmallchange1, "Black_Party_Switch_14_19.csv")

# Find which party Native voters switched

nsmall = droplevels(nchange, exclude = c('ACN', 'APV', 'GRN', 'LBR', 'UNI'))
nsmall <- nsmall[ !is.na(nsmall$Party) ]

nsmallchange = NULL
nsu <- unique(nsmall$VoterID)
for (i in nsu){
  if(length(unique(nsmall$Party[nsmall$VoterID == i])) > 1) nsmallchange <- rbind(nsmall[nsmall$VoterID == i], nsmallchange)
}
nsmallchange <- nsmallchange[with(nsmallchange, order(VoterID,Year)), ]
length(unique(nsmallchange$VoterID))


nsmallchange <- nsmallchange[!duplicated(nsmallchange[,c('VoterID', 'Party')]),]

nscu <- unique(nsmallchange$VoterID)

for (i in nscu){

  nsmallchange$`REP-UAF`[nsmallchange$VoterID == i & nsmallchange$Party == "UAF"] = sum(diff(match(c("REP", "UAF") , as.character(nsmallchange$Party[nsmallchange$VoterID == i]))) == 1)
  nsmallchange$`REP-DEM`[nsmallchange$VoterID == i & nsmallchange$Party == "DEM"] = sum(diff(match(c("REP", "DEM") , as.character(nsmallchange$Party[nsmallchange$VoterID == i]))) == 1)
  #  
  nsmallchange$`UAF-REP`[nsmallchange$VoterID == i & nsmallchange$Party == "REP"] = sum(diff(match(c("UAF", "REP") , as.character(nsmallchange$Party[nsmallchange$VoterID == i]))) == 1)
  nsmallchange$`UAF-DEM`[nsmallchange$VoterID == i & nsmallchange$Party == "DEM"] = sum(diff(match(c("UAF", "DEM") , as.character(nsmallchange$Party[nsmallchange$VoterID == i]))) == 1)
  #  
  nsmallchange$`DEM-REP`[nsmallchange$VoterID == i & nsmallchange$Party == "REP"] = sum(diff(match(c("DEM", "REP") , as.character(nsmallchange$Party[nsmallchange$VoterID == i]))) == 1)
  nsmallchange$`DEM-UAF`[nsmallchange$VoterID == i & nsmallchange$Party == "UAF"] = sum(diff(match(c("DEM", "UAF") , as.character(nsmallchange$Party[nsmallchange$VoterID == i]))) == 1)
}

nsmallchange$Race <- 'Native'


nsmallchange1 <- setDT(nsmallchange)[, .SD[-1], by = VoterID]

write.csv(nsmallchange1, "Native_Party_Switch_14_19.csv")

# Stich all the data together
voterchange <- rbind(asmallchange, wsmallchange, hsmallchange, bsmallchange, nsmallchange)
voterchange1 <- rbind(asmallchange1, wsmallchange1, hsmallchange1, bsmallchange1, nsmallchange1)

voterchange1[is.na(voterchange1)] <- 0

write.csv(voterchange1, "Voter Party Switch.csv")

################################################################################
# Find voters that are over voting age

# Import data files
# dt = Denver Voters Master
cd <- fread("CensusBlockGroup_2013-17.csv")

# Sum the total number of people over 18
cd$Total_Voters_Over18 <- data.table(rowSums(cd[,c("age18_24", "age25_29","age30_34","age35_39","age40_44","age45_49","age50_54","age55_59",
                                                   "age60_64", "age65_69", "age70_74", "age75_79", "age80_84", "age85pl")]))

# Select relevant columns
cdsmall <- cd[,c("Year", "geonum", "hispanic", "asian_nh","white_nh", "black_nh", "ntvam_nh", "Total_Voters_Over18")]                                

write.csv(cdsmall, 'total_voters_over18.csv')

##################################################################
# Statistical Analysis

# Calculate if there is a significant difference between the number of voters in each Party
fit <- aov(tpartvotes$N ~ tpartvotes$Party)
summary(fit)
TukeyHSD(fit)
boxplot(tpartvotes$N ~ tpartvotes$Party)

# Calculate if there is a significant difference between the number of voters in each race in each Party
fit2 <- aov(pervotes.m$value ~ pervotes.m$variable)
summary(fit2)
TukeyHSD(fit2)


# Calculate if there is a significant difference between the number of Asian voters in each Party
fita <- aov(apartvotes$N ~ apartvotes$Party)
summary(fita)
TukeyHSD(fita)
boxplot(apartvotes$N ~ apartvotes$Party)

# Calculate if there is a significant difference between the number of Black voters in each Party
fitb <- aov(bpartvotes$N ~ bpartvotes$Party)
summary(fitb)
TukeyHSD(fitb)
boxplot(bpartvotes$N ~ bpartvotes$Party)

# Calculate if there is a significant difference between the number of Hispanic voters in each Party
fith <- aov(hpartvotes$N ~ hpartvotes$Party)
summary(fith)
TukeyHSD(fith)
boxplot(hpartvotes$N ~ hpartvotes$Party)

# Calculate if there is a significant difference between the number of Native voters in each Party
fitn <- aov(npartvotes$N ~ npartvotes$Party)
summary(fitn)
TukeyHSD(fitn)
plot(npartvotes$N ~ npartvotes$Party)

# Calculate if there is a significant difference between the number of White voters in each Party
fitw <- aov(wpartvotes$N ~ wpartvotes$Party)
summary(fitw)
TukeyHSD(fitw)
boxplot(wpartvotes$N ~ wpartvotes$Party)
