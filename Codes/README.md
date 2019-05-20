## Preparation
### 1. Preparation_CensusBlockGroup 2013-2017.ipynb by Leo
Load all Census Block Group statistic data (Raw dataset #1), clean columns and drop null data.

### 2. Preparation_Surnames_2010Census_Full_CSV.ipynb by Leo
Load all surname info from National 2010 Census (Raw dataset #3), aggregate and assign racial possibility to each surname.

### 3. Preparation_DenverAddressCensusBlock.ipynb by Leo
Load all Denver addresses (Raw dataset #4) and join them to Census Block Group data by finding if the coordinates are in the the block group's polygon.

### 4. Preparation_DenverCensesBlockGroup.ipynb by Leo
Load all Census Block Group geo data (Raw dataset #1) and calcute centroids etc. to be used in our dashboard.

### 5. Preparation_DenverVoters2014-2019.ipynb by Leo
Load denver voter history (Raw dataset #2) and join with the results from code #1, #2 and #3 to create the final master dataset.

### 6. Preparation_FeatureRemoval_MasterSheet.ipynb by Leo
Remove attributes not useful from #5.

## Analysis

### 7. Analysis_RacialDemographisOfColoradoVoters.R by Kellen
It is used to combine Colorado voter data with census demographic data. Racial demographics are added to voters based on their surnames. The default threshold for assigning racial demographics to surnames is set at 90%, however, this threshold can be easily changed in the R file.  If 90% of voters with a given surname identify as one race, all voters with that surname are assumed to identify with that race. Political party affiliation is analyzed by race and year and p-values are calculated to identify which political parties have significantly different numbers of voters based on race and year. The R file also identifies which political party voters switch to and from based on their race. 

### 8. Analysis_PercentChangeStats.R by Kellen
To run after Analysis_RacialDemographisOfColoradoVoters.R and in the same folder.  At the beginning of the script, identify which race/ethnicity and census tract to select for analysis.  The code will calculate percent change in voters and total voters based on the selected racial/ethnic choice broken down by party affiliation and change in party affiliation.  There is ANOVA analysis to determine if the voter party changes between census tracts are significant compared to Denver as a whole.  

### 9. Prediction_SwitchPartyWithDummyData.ipynb by Leo
It is the script used for User Case 2 detailed in the [README.md](https://github.com/GoCodeColorado/RegisVoterDatalytics/blob/master/README.md) and [Slide 11 Results - Parallel Predictions](https://docs.google.com/presentation/d/1SN2nTwi3BMhU7PuVNJwtheuNvNFbm10u8en0IrFX_a0/edit#slide=id.p11).
