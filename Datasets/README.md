## [Raw dataset](https://drive.google.com/drive/folders/1-YH2q9zUzGlb3osYTGMf4n9hRPZo4OUE)

### 1. [Census Block Group in Colorado_2013-2017](https://data.colorado.gov/browse?q=census%20block%20groups&sortBy=relevance) - *CIM*

#### Dataset:
[2013](https://data.colorado.gov/Demographics/Census-Block-Groups-in-Colorado-2013/9gri-r239),
[2014](https://data.colorado.gov/Demographics/Census-Block-Groups-in-Colorado-2014/cmkv-zd4f), 
[2015](https://data.colorado.gov/Demographics/Census-Block-Groups-in-Colorado-2015/6hee-tnp6), 
[2016](https://data.colorado.gov/Demographics/Census-Block-Groups-in-Colorado-2016/iku4-4bpx), 
[2017](https://data.colorado.gov/Demographics/Census-Block-Groups-in-Colorado-2017/ty5m-9xub), 
[Geojson](https://data.colorado.gov/Demographics/Census-Block-Groups-in-Colorado-2010/kfm9-mvzv) <br>

#### Reference: 
[Census Data explanation](https://github.com/GoCodeColorado/GoCodeColorado-kbase-public/blob/187410313442847c357e04fb553a121941b297bf/Resources_for_Participants/Data/DOLA_Census_Data_GoCodeColorado.pdf) by Go Code Colorado & Department of Local Affair<br>
[Census Field Description](https://data.colorado.gov/Demographics/Census-Field-Descriptions/qten-sdpn/data) by OIT & DOLA<br>
[Data cleansing process](https://github.com/GoCodeColorado/RegisVoterDatalytics/blob/master/Codes/Preparation_CensusBlockGroup%202013-2017.ipynb) by Leo<br>
[Geo data extracting and calculating process](https://github.com/GoCodeColorado/RegisVoterDatalytics/blob/master/Codes/Preparation_DenverGeoCensesBlockGroup.ipynb) by Leo

#### Note:
1. No data about individuals.
2. To merge with other source, the main key is 'geonum'. It is similar to FIPS and looks like '1080310004003', which means 1-US, 08-Colorado, 031-Denver, 000400-tractID, 3-census block group ID.
3. Columns missing more than 25% of the value are dropped.


### 2. [Colorado Registered Voters_2014-2019](http://coloradovoters.info)

#### Dataset: 
[2014](http://coloradovoters.info/downloads/20140902/), 
[2015](http://coloradovoters.info/downloads/20151001/), 
[2016](http://coloradovoters.info/downloads/20160601/), 
[2017](http://coloradovoters.info/downloads/20170801/), 
[2018](http://coloradovoters.info/downloads/20181101/),
[2019](http://coloradovoters.info/downloads/20190101/) <br>

#### Reference: 
[Readme on data format](http://coloradovoters.info/downloads/readme.doc) by http://coloradovoters.info<br>
[Data cleansing process](https://github.com/GoCodeColorado/RegisVoterDatalytics/blob/master/Codes/Preparation_DenverVoters2014_2019.ipynb) by Leo

#### Note:
1. Data was collected all during the 2nd half of each year except 2019. They are stamped in Sep 2014, Oct 2015, Aug 2016, Aug 2017, Nov 2018 and Jan 2019;
2. During the final merge, the original voter list has 2720134 rows with 325350 (12%)  records not matching on each “Last Name” or address matching. We will address this in the next round of submission.

### 3. [National 2010 Census: Frequently Occurring Surnames](https://www.census.gov/topics/population/genealogy/data/2010_surnames.html)

#### Dataset:
[Surnames Occuring 100 or more times](https://www2.census.gov/topics/genealogy/2010surnames/names.zip)

#### Reference:
[Technical Documentation: Demographic Aspects of Surnames](https://www2.census.gov/topics/genealogy/2010surnames/surnames.pdf) by US Census Bureau<br>
[Data cleansing process](https://github.com/GoCodeColorado/RegisVoterDatalytics/blob/master/Codes/Preparation_Surnames_2010Census_Full_CSV.ipynb) by Leo

#### Note:
1. Black is used interchangeably with Non-Hispanic Black or African American Alone; Hispanic is used interchangeably with Hispanic or Latino origin; Asian and Native Hawaiian and Other Pacific Islander is used interchangeably with Non-Hispanic Asian and Native Hawaiian and Other Pacific Islander Alone.
2. "(S)" appears where the percentages were suppressed for confidentiality.

### 4. [Address List and Geo info](http://results.openaddresses.io/)

#### Dataset:
[Counties in Colorado](https://data.colorado.gov/Transportation/Counties-in-Colorado/67vn-ijga) - *CIM*, [Denver Open Address](https://s3.amazonaws.com/data.openaddresses.io/runs/608381/us/co/denver.zip),
[Colorado Open Address](https://s3.amazonaws.com/data.openaddresses.io/runs/608168/us/co/statewide.zip)

#### Reference:
[Data cleansing process](https://github.com/GoCodeColorado/RegisVoterDatalytics/blob/master/Codes/Preparation_DenverAddressCensusBlock.ipynb) by Leo <br>
[Final Data merging process](https://github.com/GoCodeColorado/RegisVoterDatalytics/blob/master/Codes/Preparation_DenverVoters2014_2019.ipynb) by Leo

## Clean Dataset

Our clean and final master datasets can be found in the team's [Google Drive](https://drive.google.com/drive/folders/1VQgAPKMzG7VStU8c5u1aivYBI6EGBREG) 

### 1. CensusBlockGroup_2013-2017.csv
Clean data with census block group statics and geo info, compiled from the 5-year raw data.

### 2. SurnameToRaces_Census2010.csv
Clean data with racial possibility assigned to surnames, compiled from 2010 National Census data.

### 3. DenverCensusBlockGroup_Geoinfo.csv
Filter census block group geo data with centriods and polygons for mapping, extracted and calculated from the geojson file of Census Block Group in Colorado.

### 4. DenverAddress_CensusBlockGroup.csv
Merged results of Denver Address and Census Block Group Datasets.

### 5. Denver_Voters_Master_2014-2019.csv
Final master dataset to run analysis code against, results from merging SurnameToRaces_Census2010.csv, DenverAddress_CensusBlockGroup.csv and cleaned denver voter history data 2014-2019.

### Dummy A.csv and Dummy B.csv
Dummy datasets created to reflect survey results for Strategy A and B for User Case 2.

## Data Architect Diagram
[PDF](https://github.com/GoCodeColorado/RegisVoterDatalytics/blob/master/Datasets/Diagram.pdf)
