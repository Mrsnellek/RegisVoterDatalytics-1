##
![gocode-logo](https://cloud.githubusercontent.com/assets/100216/12792545/96727a8e-ca69-11e5-9b9a-cddfa80d1c4b.png)
--
## Regis Voter Datalytics - Data Analytics Track of Go Code Colorado 2019
### Team Member: 

| Rich Paschen | Kellen Sorauf | Meng "Leo" Luo|Chad Bates|
|--|--|--|--|

### Problem:
Since Colorado does not ask for race/ethnicity when we register to vote, campaign managers/activists have no idea of the ethnicity/race of Colorado voters or they have to pay premium to access external data without a way to examine the provided predictive models directly.

### Clients: Campaigners/Activists
#### User Case 1: Colorado Democratic Party
[Check video sent from our client](https://github.com/GoCodeColorado/RegisVoterDatalytics/blob/master/ClientRequest%20from%20CoDem.mov)

#### Current problem:
1. Inability to identify voter’s race and ethnicity.
2. Unable to determine if race/ethnicity was a primary factor when voting. 
3. Do not know if targeted racial ad campaigns are effective. 

#### Our approach:
1. Create map with voter history data and geo information.
2. Assign racial possibility individually according to census data
3. Aggregate and analyze each category and compare the changes every year.
4. Visualize our results
5. Ask feedback from our clients and provide access for them to join our data with their sensitive compaign data.


#### Main questions answered:
1. Race and ethnic breakdown and % change of voters since 2014
2. Comparision between different groups and locations


#### Main finding:

1. Native voters who voted as UAF (no party affiliation) is growing significantly.
2. Voter percentage by race hasn't change much in the last 5 year although the total voter counts has increased by about 10,000 each year.
3. [Table showing voter who switched party](https://github.com/GoCodeColorado/RegisVoterDatalytics/blob/master/AnalyticsResults/Plots/Switching_Political_Parties.png)
<br>
There is a significant difference <<<0.05 in the number of voters in the Dem, Rep, and UAF political parties in almost all racial groups in our findings.

Please also check our [interactive dashboard](https://drive.google.com/open?id=1Ox-EbcLZ4bHj6ZU9tbQJjbI7Vy6ubHa6) [semi-final pitch video](https://github.com/GoCodeColorado/RegisVoterDatalytics/blob/master/AnalyticsResults/Team%20Regis%20Voter%20Datalytics%20Presentation.mp4) ([Loom link](https://www.loom.com/share/4265210e8d174e83bb203e8e539a60f3)) by Rich, and [final presentation](https://github.com/GoCodeColorado/RegisVoterDatalytics/blob/master/AnalyticsResults/Team%20Regis%20Voter%20Datalytics_GoCodeColorado_2019.pptx) by Chad.
* Dashboard is saved in Google Drive because it is too large (31MB)

#### User Case 2: Republican campaign manager

#### Current problem:
After receiving an initial survey results for the following 2 campaign strategies, these campaigners need to decide which strategy is better to win more voters. <br>
Comparing to their current baseline:
1. Strategy A: attracts more democrats to switch parties by 2%, but it loses 8% more Latino and Asian voters
2. Strategy B: more preferable by 5% of African Americans, but 1% of current republicans will not vote for it.

#### Our approach:
1. Arrange datasets with voters possibility to stick with the party or not for each combination of age, racial group, and party.(Dummy datasets were created to mimic a real survey result, which is normally provided by clients. However, we can't use any real-life data for this competitaion due to its sensitivity.)
2. For each voter, look up their possibility based on age, race, and party in the survey dataset.
3. Aggregate and compare.


#### Main questions answered:
1. Which plan is better
2. The most important groups and locations for canvassing, considering the campaign resources are always, always limited.


#### Main finding:
(Based on the dummy datasets)
1. Strategy B will encourage 0.1% more voters to switch their party affiliation to Replication than Strategy A.
2. The top 3 census blocks to focus on in Denver are 004026, 120102, and 034023
3. The top 3 racial groups are African Americans, Asians and White.


### What can we do next:
1. Make it easier for client to access our data and combine their sensitve data with ours.
2. Collect data from more cities.

# Thank you for reviewing our project! Hope you Enjoy it.

