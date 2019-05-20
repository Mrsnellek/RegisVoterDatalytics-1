library(plyr)
library(car)
# Identify race/ethnicity for plots
r = 'Hispanic'
# Pick the race/ethnicity data set
rv = hvoters1
# Select census tract number
t = 1080310035002


####################
# This section is for the specific census tract that is selected from above.
changestat <- voterchange1[, c("REP-UAF", "REP-DEM", "UAF-REP", "UAF-DEM", "DEM-REP", "DEM-UAF", "Race", "Year", "Tract-CensusBlock")]

changestat1 <- changestat[,.N,by=.(`REP-UAF`, `REP-DEM`, `UAF-REP`, `UAF-DEM`, `DEM-REP`, `DEM-UAF`, Year, Race, `Tract-CensusBlock`)]

change <- changestat1$N * changestat1[,c("REP-UAF", "REP-DEM", "UAF-REP", "UAF-DEM", "DEM-REP", "DEM-UAF")]
change$Race <- changestat1$Race
change$year <- changestat1$Year
change$tract <- changestat1$`Tract-CensusBlock`

a <- rv[,.N,by=.(Year, Party, `Tract-CensusBlock`)]
a <- a[(a$Party == "REP" | a$Party == "UAF" | a$Party == "DEM")]
a <- a[a$`Tract-CensusBlock` == t]
z <- change[change$Race == r & change$tract == t]
z$Race <- NULL
z$tract <- NULL

pc <- z
pc$`REP-UAF` <- pc$`REP-UAF`/sum(a$N[a$Party == 'REP'])
pc$`REP-DEM` <- pc$`REP-DEM`/sum(a$N[a$Party == 'REP'])
pc$`UAF-REP` <- pc$`UAF-REP`/sum(a$N[a$Party == 'UAF'])
pc$`UAF-DEM` <- pc$`UAF-DEM`/sum(a$N[a$Party == 'UAF'])
pc$`DEM-REP` <- pc$`DEM-REP`/sum(a$N[a$Party == 'DEM'])
pc$`DEM-UAF` <- pc$`DEM-UAF`/sum(a$N[a$Party == 'DEM'])

pcs <- aggregate(. ~ year, pc, sum)
pcs.m <- melt(pcs ,  id.vars = 'year', variable.name = 'Party')
pcs.m <- pcs.m[pcs.m$year != '2019' ,]
ggplot(data = pcs.m, aes(x = year, y = value, group = Party ,colour = Party)) + geom_line()+ geom_point() + ggtitle(paste(r, "Voters by Party \nin Census Block Tract", t)) + 
  scale_x_continuous(name="Year") + scale_y_continuous(name="Percent Change of Voters", labels = percent)

#Racial Voters by Party
rv1 <- rv[rv$Status == 'Active'  & rv$`Tract-CensusBlock` == t]
rv1 <- rv1[,.N,by=.(Year, Party)]
ggplot(data = a, aes(x = Year, y = N, group = Party ,colour = Party)) + geom_line()+ geom_point() + ggtitle(paste(r, "Voters by Party \nin Census Block Tract", t)) + 
  scale_x_continuous(name="Year") + scale_y_continuous(name="Number of Voters", labels = comma)


#Statistic Party vs Voters
fit <- aov(pcs.m$value ~ pcs.m$Party)
summary(fit)
TukeyHSD(fit)
boxplot(pcs.m$value ~ pcs.m$Party)


#Statistic Party vs Year
pcs.m$year  <- as.factor(pcs.m$year)
fit <- aov(pcs.m$value ~ pcs.m$year)
summary(fit)
TukeyHSD(fit)
boxplot(pcs.m$value ~ pcs.m$year)

####################
# No Census Block anlaysis
nchangestat <- voterchange1[, c("REP-UAF", "REP-DEM", "UAF-REP", "UAF-DEM", "DEM-REP", "DEM-UAF", "Race", "Year")]

nchangestat1 <- nchangestat[,.N,by=.(`REP-UAF`, `REP-DEM`, `UAF-REP`, `UAF-DEM`, `DEM-REP`, `DEM-UAF`, Year, Race)]

nchange <- nchangestat1$N * nchangestat1[,c("REP-UAF", "REP-DEM", "UAF-REP", "UAF-DEM", "DEM-REP", "DEM-UAF")]
nchange$Race <- nchangestat1$Race
nchange$year <- nchangestat1$Year

na <- rv[,.N,by=.(Year, Party)]
na <- na[(na$Party == "REP" | na$Party == "UAF" | na$Party == "DEM")]
nz <- nchange[nchange$Race == r]
nz$Race <- NULL
npc <- nz
npc$`REP-UAF` <- npc$`REP-UAF`/sum(na$N[na$Party == 'REP'])
npc$`REP-DEM` <- npc$`REP-DEM`/sum(na$N[na$Party == 'REP'])
npc$`UAF-REP` <- npc$`UAF-REP`/sum(na$N[na$Party == 'UAF'])
npc$`UAF-DEM` <- npc$`UAF-DEM`/sum(na$N[na$Party == 'UAF'])
npc$`DEM-REP` <- npc$`DEM-REP`/sum(na$N[na$Party == 'DEM'])
npc$`DEM-UAF` <- npc$`DEM-UAF`/sum(na$N[na$Party == 'DEM'])

npcs <- aggregate(. ~ year, npc, sum)
npcs.m <- melt(npcs ,  id.vars = 'year', variable.name = 'Party')
npcs.m <- npcs.m[npcs.m$year != '2019' ,]
ggplot(data = npcs.m, aes(x = year, y = value, group = Party ,colour = Party)) + geom_line()+ geom_point() + ggtitle(paste(r, "Voters by Year")) + 
  scale_x_continuous(name="Year") + scale_y_continuous(name="Percent Change of Voters", labels = percent)


#Racial Voters by Party
nrv1 <- rv[,.N,by=.(Year, Party)]
ggplot(data = nrv1, aes(x = Year, y = N, group = Party ,colour = Party)) + geom_line()+ geom_point() + ggtitle(paste(r, "Voters by Party")) + 
  scale_x_continuous(name="Year") + scale_y_continuous(name="Number of Voters", labels = comma)


#Statistic Party vs Voters
fit <- aov(npcs.m$value ~ npcs.m$Party)
summary(fit)
TukeyHSD(fit)
boxplot(npcs.m$value ~ npcs.m$Party)


#Statistic Party vs Year
npcs.m$year  <- as.factor(npcs.m$year)
fit <- aov(npcs.m$value ~ npcs.m$year)
summary(fit)
TukeyHSD(fit)
boxplot(npcs.m$value ~ npcs.m$year)

##################################
# Statisical difference of switching parties of a racial group in a specific neighborhood and Denver as a whole.
fit <- aov(npcs.m$value ~ pcs.m$value)
summary(fit)

