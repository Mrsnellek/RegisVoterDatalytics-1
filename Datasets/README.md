## [Raw datasets](https://drive.google.com/drive/folders/1-YH2q9zUzGlb3osYTGMf4n9hRPZo4OUE):

### 1. [CensusBlockGroup_2013-17](https://data.colorado.gov/browse?q=census%20block%20groups&sortBy=relevance)
Last update: Apr 19th, 2019 by Leo

#### Datasets:
[2013](https://data.colorado.gov/Demographics/Census-Block-Groups-in-Colorado-2013/9gri-r239) 
[2014](https://data.colorado.gov/Demographics/Census-Block-Groups-in-Colorado-2014/cmkv-zd4f) 
[2015](https://data.colorado.gov/Demographics/Census-Block-Groups-in-Colorado-2015/6hee-tnp6) 
[2016](https://data.colorado.gov/Demographics/Census-Block-Groups-in-Colorado-2016/iku4-4bpx) 
[2017](https://data.colorado.gov/Demographics/Census-Block-Groups-in-Colorado-2017/ty5m-9xub) <br>

#### Reference: 
[Census Data PDF](https://github.com/GoCodeColorado/GoCodeColorado-kbase-public/blob/187410313442847c357e04fb553a121941b297bf/Resources_for_Participants/Data/DOLA_Census_Data_GoCodeColorado.pdf) by Go Code Colorado & Department of Local Affair
[Census Field Description](https://data.colorado.gov/Demographics/Census-Field-Descriptions/qten-sdpn/data) by OIT & DOLA

#### Data cleansing file:
???
#### Note:
No individual data.
To join with other data sets, the main key here 'geonum', it is similar to FIPS and looks like '1080310004003', which means 1- US, 08-Colorado, 031-Denver, 000400-tractID, 3-census block group
Columns missing more than 25% of the value are completely dropped.


### 2. DenverVoters_Master_2014-2019
Last update: Apr 21st, 2019 by Meng "Leo" Luo
#### Datasource: http://coloradovoters.info/download.html
#### Data cleansing .ipynb file

#### Note:
1. The 6 sets are stamped in Sep 2014, Oct 2015, Aug 2016, Aug 2017, Nov 2018 and Jan 2019;
2. During the final merge, the original voter list has 2720134 rows with 325350 (12%)  records have no match on merging with “Last Name” 3. and then 606628 (22.3%) without coordinate/address matching. We should address this in the next round of submission.


## Clean datasets 
can be download from our team [Google Drive](https://drive.google.com/open?id=1VQgAPKMzG7VStU8c5u1aivYBI6EGBREG])
