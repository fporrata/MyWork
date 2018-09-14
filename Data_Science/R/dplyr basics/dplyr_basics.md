

```R
options(warn=-1)

```


```R
#The dplyr package contains five key data manipulation functions, also called verbs:

#select(), which returns a subset of the columns,
#filter(), that is able to return a subset of the rows,
#arrange(), that reorders the rows according to single or multiple variables,
#mutate(), used to add columns from existing data,
#summarise(), which reduces each group to a single row by calculating aggregate measures.


# Load the dplyr package
library(dplyr)

# Load the hflights package
library(hflights)

# Call head() 
head(hflights)
```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
	<tr><td>2011    </td><td>1       </td><td>1       </td><td>6       </td><td>1400    </td><td>1500    </td><td>AA      </td><td>428     </td><td>N576AA  </td><td>60      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>7       </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>2       </td><td>7       </td><td>1401    </td><td>1501    </td><td>AA      </td><td>428     </td><td>N557AA  </td><td>60      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>6       </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>3       </td><td>1       </td><td>1352    </td><td>1502    </td><td>AA      </td><td>428     </td><td>N541AA  </td><td>70      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>5       </td><td>17      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>4       </td><td>2       </td><td>1403    </td><td>1513    </td><td>AA      </td><td>428     </td><td>N403AA  </td><td>70      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>9       </td><td>22      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>5       </td><td>3       </td><td>1405    </td><td>1507    </td><td>AA      </td><td>428     </td><td>N492AA  </td><td>62      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>9       </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>6       </td><td>4       </td><td>1359    </td><td>1503    </td><td>AA      </td><td>428     </td><td>N262AA  </td><td>64      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>6       </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
</tbody>
</table>




```R
# Call summary() on hflights
summary(hflights)


```


          Year          Month          DayofMonth      DayOfWeek        DepTime    
     Min.   :2011   Min.   : 1.000   Min.   : 1.00   Min.   :1.000   Min.   :   1  
     1st Qu.:2011   1st Qu.: 4.000   1st Qu.: 8.00   1st Qu.:2.000   1st Qu.:1021  
     Median :2011   Median : 7.000   Median :16.00   Median :4.000   Median :1416  
     Mean   :2011   Mean   : 6.514   Mean   :15.74   Mean   :3.948   Mean   :1396  
     3rd Qu.:2011   3rd Qu.: 9.000   3rd Qu.:23.00   3rd Qu.:6.000   3rd Qu.:1801  
     Max.   :2011   Max.   :12.000   Max.   :31.00   Max.   :7.000   Max.   :2400  
                                                                     NA's   :2905  
        ArrTime     UniqueCarrier        FlightNum      TailNum         
     Min.   :   1   Length:227496      Min.   :   1   Length:227496     
     1st Qu.:1215   Class :character   1st Qu.: 855   Class :character  
     Median :1617   Mode  :character   Median :1696   Mode  :character  
     Mean   :1578                      Mean   :1962                     
     3rd Qu.:1953                      3rd Qu.:2755                     
     Max.   :2400                      Max.   :7290                     
     NA's   :3066                                                       
     ActualElapsedTime    AirTime         ArrDelay          DepDelay      
     Min.   : 34.0     Min.   : 11.0   Min.   :-70.000   Min.   :-33.000  
     1st Qu.: 77.0     1st Qu.: 58.0   1st Qu.: -8.000   1st Qu.: -3.000  
     Median :128.0     Median :107.0   Median :  0.000   Median :  0.000  
     Mean   :129.3     Mean   :108.1   Mean   :  7.094   Mean   :  9.445  
     3rd Qu.:165.0     3rd Qu.:141.0   3rd Qu.: 11.000   3rd Qu.:  9.000  
     Max.   :575.0     Max.   :549.0   Max.   :978.000   Max.   :981.000  
     NA's   :3622      NA's   :3622    NA's   :3622      NA's   :2905     
        Origin              Dest              Distance          TaxiIn       
     Length:227496      Length:227496      Min.   :  79.0   Min.   :  1.000  
     Class :character   Class :character   1st Qu.: 376.0   1st Qu.:  4.000  
     Mode  :character   Mode  :character   Median : 809.0   Median :  5.000  
                                           Mean   : 787.8   Mean   :  6.099  
                                           3rd Qu.:1042.0   3rd Qu.:  7.000  
                                           Max.   :3904.0   Max.   :165.000  
                                                            NA's   :3066     
        TaxiOut         Cancelled       CancellationCode      Diverted       
     Min.   :  1.00   Min.   :0.00000   Length:227496      Min.   :0.000000  
     1st Qu.: 10.00   1st Qu.:0.00000   Class :character   1st Qu.:0.000000  
     Median : 14.00   Median :0.00000   Mode  :character   Median :0.000000  
     Mean   : 15.09   Mean   :0.01307                      Mean   :0.002853  
     3rd Qu.: 18.00   3rd Qu.:0.00000                      3rd Qu.:0.000000  
     Max.   :163.00   Max.   :1.00000                      Max.   :1.000000  
     NA's   :2947                                                            
       Carrier              Code          
     Length:227496      Length:227496     
     Class :character   Class :character  
     Mode  :character   Mode  :character  
                                          
                                          
                                          
                                          



```R
# Convert the hflights data.frame into a hflights tbl
hflights <- tbl_df(hflights)

# Display the hflights tbl
hflights
```


<table>
<thead><tr><th></th><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
	<tr><th scope=row>5424</th><td>2011    </td><td>1       </td><td> 1      </td><td>6       </td><td>1400    </td><td>1500    </td><td>AA      </td><td>428     </td><td>N576AA  </td><td>60      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 7      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5425</th><td>2011    </td><td>1       </td><td> 2      </td><td>7       </td><td>1401    </td><td>1501    </td><td>AA      </td><td>428     </td><td>N557AA  </td><td>60      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 6      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5426</th><td>2011    </td><td>1       </td><td> 3      </td><td>1       </td><td>1352    </td><td>1502    </td><td>AA      </td><td>428     </td><td>N541AA  </td><td>70      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 5      </td><td>17      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5427</th><td>2011    </td><td>1       </td><td> 4      </td><td>2       </td><td>1403    </td><td>1513    </td><td>AA      </td><td>428     </td><td>N403AA  </td><td>70      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 9      </td><td>22      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5428</th><td>2011    </td><td>1       </td><td> 5      </td><td>3       </td><td>1405    </td><td>1507    </td><td>AA      </td><td>428     </td><td>N492AA  </td><td>62      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 9      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5429</th><td>2011    </td><td>1       </td><td> 6      </td><td>4       </td><td>1359    </td><td>1503    </td><td>AA      </td><td>428     </td><td>N262AA  </td><td>64      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 6      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5430</th><td>2011    </td><td>1       </td><td> 7      </td><td>5       </td><td>1359    </td><td>1509    </td><td>AA      </td><td>428     </td><td>N493AA  </td><td>70      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>12      </td><td>15      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5431</th><td>2011    </td><td>1       </td><td> 8      </td><td>6       </td><td>1355    </td><td>1454    </td><td>AA      </td><td>428     </td><td>N477AA  </td><td>59      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 7      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5432</th><td>2011    </td><td>1       </td><td> 9      </td><td>7       </td><td>1443    </td><td>1554    </td><td>AA      </td><td>428     </td><td>N476AA  </td><td>71      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 8      </td><td>22      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5433</th><td>2011    </td><td>1       </td><td>10      </td><td>1       </td><td>1443    </td><td>1553    </td><td>AA      </td><td>428     </td><td>N504AA  </td><td>70      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 6      </td><td>19      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5434</th><td>2011    </td><td>1       </td><td>11      </td><td>2       </td><td>1429    </td><td>1539    </td><td>AA      </td><td>428     </td><td>N565AA  </td><td>70      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 8      </td><td>20      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5435</th><td>2011    </td><td>1       </td><td>12      </td><td>3       </td><td>1419    </td><td>1515    </td><td>AA      </td><td>428     </td><td>N577AA  </td><td>56      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 4      </td><td>11      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5436</th><td>2011    </td><td>1       </td><td>13      </td><td>4       </td><td>1358    </td><td>1501    </td><td>AA      </td><td>428     </td><td>N476AA  </td><td>63      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 6      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5437</th><td>2011    </td><td>1       </td><td>14      </td><td>5       </td><td>1357    </td><td>1504    </td><td>AA      </td><td>428     </td><td>N552AA  </td><td>67      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 5      </td><td>15      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5438</th><td>2011    </td><td>1       </td><td>15      </td><td>6       </td><td>1359    </td><td>1459    </td><td>AA      </td><td>428     </td><td>N462AA  </td><td>60      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 6      </td><td>10      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5439</th><td>2011    </td><td>1       </td><td>16      </td><td>7       </td><td>1359    </td><td>1509    </td><td>AA      </td><td>428     </td><td>N555AA  </td><td>70      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>12      </td><td>17      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5440</th><td>2011    </td><td>1       </td><td>17      </td><td>1       </td><td>1530    </td><td>1634    </td><td>AA      </td><td>428     </td><td>N518AA  </td><td>64      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 8      </td><td> 8      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5441</th><td>2011    </td><td>1       </td><td>18      </td><td>2       </td><td>1408    </td><td>1508    </td><td>AA      </td><td>428     </td><td>N507AA  </td><td>60      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 7      </td><td>11      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5442</th><td>2011    </td><td>1       </td><td>19      </td><td>3       </td><td>1356    </td><td>1503    </td><td>AA      </td><td>428     </td><td>N523AA  </td><td>67      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>10      </td><td>11      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5443</th><td>2011    </td><td>1       </td><td>20      </td><td>4       </td><td>1507    </td><td>1622    </td><td>AA      </td><td>428     </td><td>N425AA  </td><td>75      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 9      </td><td>24      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5444</th><td>2011    </td><td>1       </td><td>21      </td><td>5       </td><td>1357    </td><td>1459    </td><td>AA      </td><td>428     </td><td>N251AA  </td><td>62      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 6      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5445</th><td>2011    </td><td>1       </td><td>22      </td><td>6       </td><td>1355    </td><td>1456    </td><td>AA      </td><td>428     </td><td>N551AA  </td><td>61      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 9      </td><td> 8      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5446</th><td>2011    </td><td>1       </td><td>23      </td><td>7       </td><td>1356    </td><td>1501    </td><td>AA      </td><td>428     </td><td>N479AA  </td><td>65      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 7      </td><td>18      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5447</th><td>2011    </td><td>1       </td><td>24      </td><td>1       </td><td>1356    </td><td>1513    </td><td>AA      </td><td>428     </td><td>N531AA  </td><td>77      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 6      </td><td>28      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5448</th><td>2011    </td><td>1       </td><td>25      </td><td>2       </td><td>1352    </td><td>1452    </td><td>AA      </td><td>428     </td><td>N561AA  </td><td>60      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 7      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5449</th><td>2011    </td><td>1       </td><td>26      </td><td>3       </td><td>1353    </td><td>1455    </td><td>AA      </td><td>428     </td><td>N541AA  </td><td>62      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 8      </td><td>14      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5450</th><td>2011    </td><td>1       </td><td>27      </td><td>4       </td><td>1356    </td><td>1458    </td><td>AA      </td><td>428     </td><td>N512AA  </td><td>62      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>12      </td><td>10      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5451</th><td>2011    </td><td>1       </td><td>28      </td><td>5       </td><td>1359    </td><td>1505    </td><td>AA      </td><td>428     </td><td>N4UBAA  </td><td>66      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 8      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5452</th><td>2011    </td><td>1       </td><td>29      </td><td>6       </td><td>1355    </td><td>1455    </td><td>AA      </td><td>428     </td><td>N491AA  </td><td>60      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 7      </td><td> 7      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>5453</th><td>2011    </td><td>1       </td><td>30      </td><td>7       </td><td>1359    </td><td>1456    </td><td>AA      </td><td>428     </td><td>N561AA  </td><td>57      </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 7      </td><td>11      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><th scope=row>...</th><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>   </td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><th scope=row>6083230</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 752     </td><td> 857     </td><td>WN       </td><td>1628     </td><td>N435WN   </td><td> 65      </td><td>...      </td><td>HOU      </td><td>MSY      </td><td> 302     </td><td> 4       </td><td>11       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083231</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 651     </td><td> 746     </td><td>WN       </td><td>2534     </td><td>N232WN   </td><td> 55      </td><td>...      </td><td>HOU      </td><td>MSY      </td><td> 302     </td><td> 5       </td><td> 7       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083232</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1728     </td><td>1932     </td><td>WN       </td><td> 902     </td><td>N724SW   </td><td>244      </td><td>...      </td><td>HOU      </td><td>OAK      </td><td>1642     </td><td> 5       </td><td> 8       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083233</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1115     </td><td>1315     </td><td>WN       </td><td>1167     </td><td>N455WN   </td><td>240      </td><td>...      </td><td>HOU      </td><td>OAK      </td><td>1642     </td><td> 6       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083234</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1753     </td><td>1911     </td><td>WN       </td><td> 513     </td><td>N362SW   </td><td> 78      </td><td>...      </td><td>HOU      </td><td>OKC      </td><td> 419     </td><td> 4       </td><td>15       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083235</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1222     </td><td>1335     </td><td>WN       </td><td> 581     </td><td>N646SW   </td><td> 73      </td><td>...      </td><td>HOU      </td><td>OKC      </td><td> 419     </td><td> 3       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083236</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 836     </td><td> 946     </td><td>WN       </td><td>1223     </td><td>N394SW   </td><td> 70      </td><td>...      </td><td>HOU      </td><td>OKC      </td><td> 419     </td><td> 4       </td><td> 8       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083237</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1352     </td><td>1749     </td><td>WN       </td><td>3085     </td><td>N510SW   </td><td>177      </td><td>...      </td><td>HOU      </td><td>PHL      </td><td>1336     </td><td> 5       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083238</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1850     </td><td>2046     </td><td>WN       </td><td>  39     </td><td>N754SW   </td><td>176      </td><td>...      </td><td>HOU      </td><td>PHX      </td><td>1020     </td><td> 4       </td><td>15       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083239</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 707     </td><td> 903     </td><td>WN       </td><td> 424     </td><td>N769SW   </td><td>176      </td><td>...      </td><td>HOU      </td><td>PHX      </td><td>1020     </td><td> 4       </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083240</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1335     </td><td>1528     </td><td>WN       </td><td>1098     </td><td>N448WN   </td><td>173      </td><td>...      </td><td>HOU      </td><td>PHX      </td><td>1020     </td><td> 4       </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083241</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1005     </td><td>1158     </td><td>WN       </td><td>1403     </td><td>N430WN   </td><td>173      </td><td>...      </td><td>HOU      </td><td>PHX      </td><td>1020     </td><td> 3       </td><td> 7       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083242</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1723     </td><td>1845     </td><td>WN       </td><td>  33     </td><td>N698SW   </td><td>202      </td><td>...      </td><td>HOU      </td><td>SAN      </td><td>1313     </td><td> 3       </td><td> 7       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083243</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1139     </td><td>1304     </td><td>WN       </td><td>1212     </td><td>N226WN   </td><td>205      </td><td>...      </td><td>HOU      </td><td>SAN      </td><td>1313     </td><td> 2       </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083244</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>2023     </td><td>2109     </td><td>WN       </td><td> 207     </td><td>N354SW   </td><td> 46      </td><td>...      </td><td>HOU      </td><td>SAT      </td><td> 192     </td><td> 4       </td><td> 4       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083245</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1542     </td><td>1637     </td><td>WN       </td><td> 405     </td><td>N617SW   </td><td> 55      </td><td>...      </td><td>HOU      </td><td>SAT      </td><td> 192     </td><td> 4       </td><td> 8       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083246</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1728     </td><td>1825     </td><td>WN       </td><td> 628     </td><td>N389SW   </td><td> 57      </td><td>...      </td><td>HOU      </td><td>SAT      </td><td> 192     </td><td> 4       </td><td>14       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083247</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1252     </td><td>1349     </td><td>WN       </td><td> 994     </td><td>N713SW   </td><td> 57      </td><td>...      </td><td>HOU      </td><td>SAT      </td><td> 192     </td><td> 5       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083248</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 857     </td><td> 955     </td><td>WN       </td><td>1231     </td><td>N284WN   </td><td> 58      </td><td>...      </td><td>HOU      </td><td>SAT      </td><td> 192     </td><td> 5       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083249</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1939     </td><td>2119     </td><td>WN       </td><td> 124     </td><td>N522SW   </td><td>100      </td><td>...      </td><td>HOU      </td><td>STL      </td><td> 687     </td><td> 4       </td><td>15       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083250</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 556     </td><td> 745     </td><td>WN       </td><td> 280     </td><td>N728SW   </td><td>109      </td><td>...      </td><td>HOU      </td><td>STL      </td><td> 687     </td><td>13       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083251</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1026     </td><td>1208     </td><td>WN       </td><td> 782     </td><td>N476WN   </td><td>102      </td><td>...      </td><td>HOU      </td><td>STL      </td><td> 687     </td><td> 4       </td><td>12       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083252</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1611     </td><td>1746     </td><td>WN       </td><td>1050     </td><td>N655WN   </td><td> 95      </td><td>...      </td><td>HOU      </td><td>STL      </td><td> 687     </td><td> 3       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083253</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 758     </td><td>1051     </td><td>WN       </td><td> 201     </td><td>N903WN   </td><td>113      </td><td>...      </td><td>HOU      </td><td>TPA      </td><td> 781     </td><td> 3       </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083254</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1307     </td><td>1600     </td><td>WN       </td><td> 471     </td><td>N632SW   </td><td>113      </td><td>...      </td><td>HOU      </td><td>TPA      </td><td> 781     </td><td> 5       </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083255</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1818     </td><td>2111     </td><td>WN       </td><td>1191     </td><td>N284WN   </td><td>113      </td><td>...      </td><td>HOU      </td><td>TPA      </td><td> 781     </td><td> 5       </td><td>11       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083256</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>2047     </td><td>2334     </td><td>WN       </td><td>1674     </td><td>N366SW   </td><td>107      </td><td>...      </td><td>HOU      </td><td>TPA      </td><td> 781     </td><td> 4       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083257</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 912     </td><td>1031     </td><td>WN       </td><td> 127     </td><td>N777QC   </td><td> 79      </td><td>...      </td><td>HOU      </td><td>TUL      </td><td> 453     </td><td> 4       </td><td>14       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083258</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 656     </td><td> 812     </td><td>WN       </td><td> 621     </td><td>N727SW   </td><td> 76      </td><td>...      </td><td>HOU      </td><td>TUL      </td><td> 453     </td><td> 3       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><th scope=row>6083259</th><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1600     </td><td>1713     </td><td>WN       </td><td>1597     </td><td>N745SW   </td><td> 73      </td><td>...      </td><td>HOU      </td><td>TUL      </td><td> 453     </td><td> 3       </td><td>11       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
</tbody>
</table>




```R
# Create the object carriers
carriers <- hflights$UniqueCarrier

# Both the dplyr and hflights packages are loaded into workspace
lut <- c("AA" = "American", "AS" = "Alaska", "B6" = "JetBlue", "CO" = "Continental", 
         "DL" = "Delta", "OO" = "SkyWest", "UA" = "United", "US" = "US_Airways", 
         "WN" = "Southwest", "EV" = "Atlantic_Southeast", "F9" = "Frontier", 
         "FL" = "AirTran", "MQ" = "American_Eagle", "XE" = "ExpressJet", "YV" = "Mesa")

# Add the Carrier column to hflights
hflights$Carrier <- lut[hflights$UniqueCarrier]

# Glimpse at hflights
glimpse(hflights)

```

    Observations: 227,496
    Variables: 23
    $ Year              <int> 2011, 2011, 2011, 2011, 2011, 2011, 2011, 2011, 2...
    $ Month             <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
    $ DayofMonth        <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15...
    $ DayOfWeek         <int> 6, 7, 1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5, 6, 7, 1...
    $ DepTime           <int> 1400, 1401, 1352, 1403, 1405, 1359, 1359, 1355, 1...
    $ ArrTime           <int> 1500, 1501, 1502, 1513, 1507, 1503, 1509, 1454, 1...
    $ UniqueCarrier     <chr> "AA", "AA", "AA", "AA", "AA", "AA", "AA", "AA", "...
    $ FlightNum         <int> 428, 428, 428, 428, 428, 428, 428, 428, 428, 428,...
    $ TailNum           <chr> "N576AA", "N557AA", "N541AA", "N403AA", "N492AA",...
    $ ActualElapsedTime <int> 60, 60, 70, 70, 62, 64, 70, 59, 71, 70, 70, 56, 6...
    $ AirTime           <int> 40, 45, 48, 39, 44, 45, 43, 40, 41, 45, 42, 41, 4...
    $ ArrDelay          <int> -10, -9, -8, 3, -3, -7, -1, -16, 44, 43, 29, 5, -...
    $ DepDelay          <int> 0, 1, -8, 3, 5, -1, -1, -5, 43, 43, 29, 19, -2, -...
    $ Origin            <chr> "IAH", "IAH", "IAH", "IAH", "IAH", "IAH", "IAH", ...
    $ Dest              <chr> "DFW", "DFW", "DFW", "DFW", "DFW", "DFW", "DFW", ...
    $ Distance          <int> 224, 224, 224, 224, 224, 224, 224, 224, 224, 224,...
    $ TaxiIn            <int> 7, 6, 5, 9, 9, 6, 12, 7, 8, 6, 8, 4, 6, 5, 6, 12,...
    $ TaxiOut           <int> 13, 9, 17, 22, 9, 13, 15, 12, 22, 19, 20, 11, 13,...
    $ Cancelled         <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
    $ CancellationCode  <chr> "", "", "", "", "", "", "", "", "", "", "", "", "...
    $ Diverted          <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
    $ Carrier           <chr> "American", "American", "American", "American", "...
    $ Code              <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
    


```R
# The lookup table
lut <- c("A" = "carrier", "B" = "weather", "C" = "FFA", "D" = "security", "E" = "not cancelled")

# Add the Code column
hflights$Code <- lut[hflights$CancellationCode]

# Glimpse at hflights
glimpse(hflights)
```

    Observations: 227,496
    Variables: 23
    $ Year              <int> 2011, 2011, 2011, 2011, 2011, 2011, 2011, 2011, 2...
    $ Month             <int> 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1...
    $ DayofMonth        <int> 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15...
    $ DayOfWeek         <int> 6, 7, 1, 2, 3, 4, 5, 6, 7, 1, 2, 3, 4, 5, 6, 7, 1...
    $ DepTime           <int> 1400, 1401, 1352, 1403, 1405, 1359, 1359, 1355, 1...
    $ ArrTime           <int> 1500, 1501, 1502, 1513, 1507, 1503, 1509, 1454, 1...
    $ UniqueCarrier     <chr> "AA", "AA", "AA", "AA", "AA", "AA", "AA", "AA", "...
    $ FlightNum         <int> 428, 428, 428, 428, 428, 428, 428, 428, 428, 428,...
    $ TailNum           <chr> "N576AA", "N557AA", "N541AA", "N403AA", "N492AA",...
    $ ActualElapsedTime <int> 60, 60, 70, 70, 62, 64, 70, 59, 71, 70, 70, 56, 6...
    $ AirTime           <int> 40, 45, 48, 39, 44, 45, 43, 40, 41, 45, 42, 41, 4...
    $ ArrDelay          <int> -10, -9, -8, 3, -3, -7, -1, -16, 44, 43, 29, 5, -...
    $ DepDelay          <int> 0, 1, -8, 3, 5, -1, -1, -5, 43, 43, 29, 19, -2, -...
    $ Origin            <chr> "IAH", "IAH", "IAH", "IAH", "IAH", "IAH", "IAH", ...
    $ Dest              <chr> "DFW", "DFW", "DFW", "DFW", "DFW", "DFW", "DFW", ...
    $ Distance          <int> 224, 224, 224, 224, 224, 224, 224, 224, 224, 224,...
    $ TaxiIn            <int> 7, 6, 5, 9, 9, 6, 12, 7, 8, 6, 8, 4, 6, 5, 6, 12,...
    $ TaxiOut           <int> 13, 9, 17, 22, 9, 13, 15, 12, 22, 19, 20, 11, 13,...
    $ Cancelled         <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
    $ CancellationCode  <chr> "", "", "", "", "", "", "", "", "", "", "", "", "...
    $ Diverted          <int> 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0...
    $ Carrier           <chr> "American", "American", "American", "American", "...
    $ Code              <chr> NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, NA, N...
    


```R
# Print out a tbl with the four columns of hflights related to delay
select(hflights, ActualElapsedTime, AirTime, ArrDelay, DepDelay)
```


<table>
<thead><tr><th></th><th scope=col>ActualElapsedTime</th><th scope=col>AirTime</th><th scope=col>ArrDelay</th><th scope=col>DepDelay</th></tr></thead>
<tbody>
	<tr><th scope=row>5424</th><td>60 </td><td>40 </td><td>-10</td><td> 0 </td></tr>
	<tr><th scope=row>5425</th><td>60 </td><td>45 </td><td> -9</td><td> 1 </td></tr>
	<tr><th scope=row>5426</th><td>70 </td><td>48 </td><td> -8</td><td>-8 </td></tr>
	<tr><th scope=row>5427</th><td>70 </td><td>39 </td><td>  3</td><td> 3 </td></tr>
	<tr><th scope=row>5428</th><td>62 </td><td>44 </td><td> -3</td><td> 5 </td></tr>
	<tr><th scope=row>5429</th><td>64 </td><td>45 </td><td> -7</td><td>-1 </td></tr>
	<tr><th scope=row>5430</th><td>70 </td><td>43 </td><td> -1</td><td>-1 </td></tr>
	<tr><th scope=row>5431</th><td>59 </td><td>40 </td><td>-16</td><td>-5 </td></tr>
	<tr><th scope=row>5432</th><td>71 </td><td>41 </td><td> 44</td><td>43 </td></tr>
	<tr><th scope=row>5433</th><td>70 </td><td>45 </td><td> 43</td><td>43 </td></tr>
	<tr><th scope=row>5434</th><td>70 </td><td>42 </td><td> 29</td><td>29 </td></tr>
	<tr><th scope=row>5435</th><td>56 </td><td>41 </td><td>  5</td><td>19 </td></tr>
	<tr><th scope=row>5436</th><td>63 </td><td>44 </td><td> -9</td><td>-2 </td></tr>
	<tr><th scope=row>5437</th><td>67 </td><td>47 </td><td> -6</td><td>-3 </td></tr>
	<tr><th scope=row>5438</th><td>60 </td><td>44 </td><td>-11</td><td>-1 </td></tr>
	<tr><th scope=row>5439</th><td>70 </td><td>41 </td><td> -1</td><td>-1 </td></tr>
	<tr><th scope=row>5440</th><td>64 </td><td>48 </td><td> 84</td><td>90 </td></tr>
	<tr><th scope=row>5441</th><td>60 </td><td>42 </td><td> -2</td><td> 8 </td></tr>
	<tr><th scope=row>5442</th><td>67 </td><td>46 </td><td> -7</td><td>-4 </td></tr>
	<tr><th scope=row>5443</th><td>75 </td><td>42 </td><td> 72</td><td>67 </td></tr>
	<tr><th scope=row>5444</th><td>62 </td><td>47 </td><td>-11</td><td>-3 </td></tr>
	<tr><th scope=row>5445</th><td>61 </td><td>44 </td><td>-14</td><td>-5 </td></tr>
	<tr><th scope=row>5446</th><td>65 </td><td>40 </td><td> -9</td><td>-4 </td></tr>
	<tr><th scope=row>5447</th><td>77 </td><td>43 </td><td>  3</td><td>-4 </td></tr>
	<tr><th scope=row>5448</th><td>60 </td><td>40 </td><td>-18</td><td>-8 </td></tr>
	<tr><th scope=row>5449</th><td>62 </td><td>40 </td><td>-15</td><td>-7 </td></tr>
	<tr><th scope=row>5450</th><td>62 </td><td>40 </td><td>-12</td><td>-4 </td></tr>
	<tr><th scope=row>5451</th><td>66 </td><td>46 </td><td> -5</td><td>-1 </td></tr>
	<tr><th scope=row>5452</th><td>60 </td><td>46 </td><td>-15</td><td>-5 </td></tr>
	<tr><th scope=row>5453</th><td>57 </td><td>39 </td><td>-14</td><td>-1 </td></tr>
	<tr><th scope=row>...</th><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><th scope=row>6083230</th><td> 65</td><td> 50</td><td>  2</td><td>-3 </td></tr>
	<tr><th scope=row>6083231</th><td> 55</td><td> 43</td><td> -9</td><td>-4 </td></tr>
	<tr><th scope=row>6083232</th><td>244</td><td>231</td><td>  7</td><td>23 </td></tr>
	<tr><th scope=row>6083233</th><td>240</td><td>225</td><td>-15</td><td> 5 </td></tr>
	<tr><th scope=row>6083234</th><td> 78</td><td> 59</td><td> 31</td><td>33 </td></tr>
	<tr><th scope=row>6083235</th><td> 73</td><td> 61</td><td>-10</td><td>-3 </td></tr>
	<tr><th scope=row>6083236</th><td> 70</td><td> 58</td><td> -9</td><td> 1 </td></tr>
	<tr><th scope=row>6083237</th><td>177</td><td>163</td><td> 59</td><td>72 </td></tr>
	<tr><th scope=row>6083238</th><td>176</td><td>157</td><td> 71</td><td>70 </td></tr>
	<tr><th scope=row>6083239</th><td>176</td><td>162</td><td> -2</td><td>-3 </td></tr>
	<tr><th scope=row>6083240</th><td>173</td><td>159</td><td> 18</td><td>20 </td></tr>
	<tr><th scope=row>6083241</th><td>173</td><td>163</td><td> 13</td><td>15 </td></tr>
	<tr><th scope=row>6083242</th><td>202</td><td>192</td><td> 70</td><td>78 </td></tr>
	<tr><th scope=row>6083243</th><td>205</td><td>193</td><td> -6</td><td>-1 </td></tr>
	<tr><th scope=row>6083244</th><td> 46</td><td> 38</td><td> 29</td><td>43 </td></tr>
	<tr><th scope=row>6083245</th><td> 55</td><td> 43</td><td> 12</td><td>12 </td></tr>
	<tr><th scope=row>6083246</th><td> 57</td><td> 39</td><td>  5</td><td> 3 </td></tr>
	<tr><th scope=row>6083247</th><td> 57</td><td> 43</td><td>  9</td><td> 7 </td></tr>
	<tr><th scope=row>6083248</th><td> 58</td><td> 44</td><td>  0</td><td>-3 </td></tr>
	<tr><th scope=row>6083249</th><td>100</td><td> 81</td><td> 14</td><td>39 </td></tr>
	<tr><th scope=row>6083250</th><td>109</td><td> 87</td><td>-10</td><td>-4 </td></tr>
	<tr><th scope=row>6083251</th><td>102</td><td> 86</td><td>-12</td><td> 1 </td></tr>
	<tr><th scope=row>6083252</th><td> 95</td><td> 83</td><td> -9</td><td>16 </td></tr>
	<tr><th scope=row>6083253</th><td>113</td><td>100</td><td> -4</td><td>-2 </td></tr>
	<tr><th scope=row>6083254</th><td>113</td><td> 98</td><td>  0</td><td> 7 </td></tr>
	<tr><th scope=row>6083255</th><td>113</td><td> 97</td><td> -9</td><td> 8 </td></tr>
	<tr><th scope=row>6083256</th><td>107</td><td> 94</td><td>  4</td><td> 7 </td></tr>
	<tr><th scope=row>6083257</th><td> 79</td><td> 61</td><td> -4</td><td>-3 </td></tr>
	<tr><th scope=row>6083258</th><td> 76</td><td> 64</td><td>-13</td><td>-4 </td></tr>
	<tr><th scope=row>6083259</th><td> 73</td><td> 59</td><td>-12</td><td> 0 </td></tr>
</tbody>
</table>




```R
# Print out the columns Origin up to Cancelled of hflights
select(hflights,14:19)
```


<table>
<thead><tr><th></th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th></tr></thead>
<tbody>
	<tr><th scope=row>5424</th><td>IAH</td><td>DFW</td><td>224</td><td> 7 </td><td>13 </td><td>0  </td></tr>
	<tr><th scope=row>5425</th><td>IAH</td><td>DFW</td><td>224</td><td> 6 </td><td> 9 </td><td>0  </td></tr>
	<tr><th scope=row>5426</th><td>IAH</td><td>DFW</td><td>224</td><td> 5 </td><td>17 </td><td>0  </td></tr>
	<tr><th scope=row>5427</th><td>IAH</td><td>DFW</td><td>224</td><td> 9 </td><td>22 </td><td>0  </td></tr>
	<tr><th scope=row>5428</th><td>IAH</td><td>DFW</td><td>224</td><td> 9 </td><td> 9 </td><td>0  </td></tr>
	<tr><th scope=row>5429</th><td>IAH</td><td>DFW</td><td>224</td><td> 6 </td><td>13 </td><td>0  </td></tr>
	<tr><th scope=row>5430</th><td>IAH</td><td>DFW</td><td>224</td><td>12 </td><td>15 </td><td>0  </td></tr>
	<tr><th scope=row>5431</th><td>IAH</td><td>DFW</td><td>224</td><td> 7 </td><td>12 </td><td>0  </td></tr>
	<tr><th scope=row>5432</th><td>IAH</td><td>DFW</td><td>224</td><td> 8 </td><td>22 </td><td>0  </td></tr>
	<tr><th scope=row>5433</th><td>IAH</td><td>DFW</td><td>224</td><td> 6 </td><td>19 </td><td>0  </td></tr>
	<tr><th scope=row>5434</th><td>IAH</td><td>DFW</td><td>224</td><td> 8 </td><td>20 </td><td>0  </td></tr>
	<tr><th scope=row>5435</th><td>IAH</td><td>DFW</td><td>224</td><td> 4 </td><td>11 </td><td>0  </td></tr>
	<tr><th scope=row>5436</th><td>IAH</td><td>DFW</td><td>224</td><td> 6 </td><td>13 </td><td>0  </td></tr>
	<tr><th scope=row>5437</th><td>IAH</td><td>DFW</td><td>224</td><td> 5 </td><td>15 </td><td>0  </td></tr>
	<tr><th scope=row>5438</th><td>IAH</td><td>DFW</td><td>224</td><td> 6 </td><td>10 </td><td>0  </td></tr>
	<tr><th scope=row>5439</th><td>IAH</td><td>DFW</td><td>224</td><td>12 </td><td>17 </td><td>0  </td></tr>
	<tr><th scope=row>5440</th><td>IAH</td><td>DFW</td><td>224</td><td> 8 </td><td> 8 </td><td>0  </td></tr>
	<tr><th scope=row>5441</th><td>IAH</td><td>DFW</td><td>224</td><td> 7 </td><td>11 </td><td>0  </td></tr>
	<tr><th scope=row>5442</th><td>IAH</td><td>DFW</td><td>224</td><td>10 </td><td>11 </td><td>0  </td></tr>
	<tr><th scope=row>5443</th><td>IAH</td><td>DFW</td><td>224</td><td> 9 </td><td>24 </td><td>0  </td></tr>
	<tr><th scope=row>5444</th><td>IAH</td><td>DFW</td><td>224</td><td> 6 </td><td> 9 </td><td>0  </td></tr>
	<tr><th scope=row>5445</th><td>IAH</td><td>DFW</td><td>224</td><td> 9 </td><td> 8 </td><td>0  </td></tr>
	<tr><th scope=row>5446</th><td>IAH</td><td>DFW</td><td>224</td><td> 7 </td><td>18 </td><td>0  </td></tr>
	<tr><th scope=row>5447</th><td>IAH</td><td>DFW</td><td>224</td><td> 6 </td><td>28 </td><td>0  </td></tr>
	<tr><th scope=row>5448</th><td>IAH</td><td>DFW</td><td>224</td><td> 7 </td><td>13 </td><td>0  </td></tr>
	<tr><th scope=row>5449</th><td>IAH</td><td>DFW</td><td>224</td><td> 8 </td><td>14 </td><td>0  </td></tr>
	<tr><th scope=row>5450</th><td>IAH</td><td>DFW</td><td>224</td><td>12 </td><td>10 </td><td>0  </td></tr>
	<tr><th scope=row>5451</th><td>IAH</td><td>DFW</td><td>224</td><td> 8 </td><td>12 </td><td>0  </td></tr>
	<tr><th scope=row>5452</th><td>IAH</td><td>DFW</td><td>224</td><td> 7 </td><td> 7 </td><td>0  </td></tr>
	<tr><th scope=row>5453</th><td>IAH</td><td>DFW</td><td>224</td><td> 7 </td><td>11 </td><td>0  </td></tr>
	<tr><th scope=row>...</th><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><th scope=row>6083230</th><td>HOU </td><td>MSY </td><td> 302</td><td> 4  </td><td>11  </td><td>0   </td></tr>
	<tr><th scope=row>6083231</th><td>HOU </td><td>MSY </td><td> 302</td><td> 5  </td><td> 7  </td><td>0   </td></tr>
	<tr><th scope=row>6083232</th><td>HOU </td><td>OAK </td><td>1642</td><td> 5  </td><td> 8  </td><td>0   </td></tr>
	<tr><th scope=row>6083233</th><td>HOU </td><td>OAK </td><td>1642</td><td> 6  </td><td> 9  </td><td>0   </td></tr>
	<tr><th scope=row>6083234</th><td>HOU </td><td>OKC </td><td> 419</td><td> 4  </td><td>15  </td><td>0   </td></tr>
	<tr><th scope=row>6083235</th><td>HOU </td><td>OKC </td><td> 419</td><td> 3  </td><td> 9  </td><td>0   </td></tr>
	<tr><th scope=row>6083236</th><td>HOU </td><td>OKC </td><td> 419</td><td> 4  </td><td> 8  </td><td>0   </td></tr>
	<tr><th scope=row>6083237</th><td>HOU </td><td>PHL </td><td>1336</td><td> 5  </td><td> 9  </td><td>0   </td></tr>
	<tr><th scope=row>6083238</th><td>HOU </td><td>PHX </td><td>1020</td><td> 4  </td><td>15  </td><td>0   </td></tr>
	<tr><th scope=row>6083239</th><td>HOU </td><td>PHX </td><td>1020</td><td> 4  </td><td>10  </td><td>0   </td></tr>
	<tr><th scope=row>6083240</th><td>HOU </td><td>PHX </td><td>1020</td><td> 4  </td><td>10  </td><td>0   </td></tr>
	<tr><th scope=row>6083241</th><td>HOU </td><td>PHX </td><td>1020</td><td> 3  </td><td> 7  </td><td>0   </td></tr>
	<tr><th scope=row>6083242</th><td>HOU </td><td>SAN </td><td>1313</td><td> 3  </td><td> 7  </td><td>0   </td></tr>
	<tr><th scope=row>6083243</th><td>HOU </td><td>SAN </td><td>1313</td><td> 2  </td><td>10  </td><td>0   </td></tr>
	<tr><th scope=row>6083244</th><td>HOU </td><td>SAT </td><td> 192</td><td> 4  </td><td> 4  </td><td>0   </td></tr>
	<tr><th scope=row>6083245</th><td>HOU </td><td>SAT </td><td> 192</td><td> 4  </td><td> 8  </td><td>0   </td></tr>
	<tr><th scope=row>6083246</th><td>HOU </td><td>SAT </td><td> 192</td><td> 4  </td><td>14  </td><td>0   </td></tr>
	<tr><th scope=row>6083247</th><td>HOU </td><td>SAT </td><td> 192</td><td> 5  </td><td> 9  </td><td>0   </td></tr>
	<tr><th scope=row>6083248</th><td>HOU </td><td>SAT </td><td> 192</td><td> 5  </td><td> 9  </td><td>0   </td></tr>
	<tr><th scope=row>6083249</th><td>HOU </td><td>STL </td><td> 687</td><td> 4  </td><td>15  </td><td>0   </td></tr>
	<tr><th scope=row>6083250</th><td>HOU </td><td>STL </td><td> 687</td><td>13  </td><td> 9  </td><td>0   </td></tr>
	<tr><th scope=row>6083251</th><td>HOU </td><td>STL </td><td> 687</td><td> 4  </td><td>12  </td><td>0   </td></tr>
	<tr><th scope=row>6083252</th><td>HOU </td><td>STL </td><td> 687</td><td> 3  </td><td> 9  </td><td>0   </td></tr>
	<tr><th scope=row>6083253</th><td>HOU </td><td>TPA </td><td> 781</td><td> 3  </td><td>10  </td><td>0   </td></tr>
	<tr><th scope=row>6083254</th><td>HOU </td><td>TPA </td><td> 781</td><td> 5  </td><td>10  </td><td>0   </td></tr>
	<tr><th scope=row>6083255</th><td>HOU </td><td>TPA </td><td> 781</td><td> 5  </td><td>11  </td><td>0   </td></tr>
	<tr><th scope=row>6083256</th><td>HOU </td><td>TPA </td><td> 781</td><td> 4  </td><td> 9  </td><td>0   </td></tr>
	<tr><th scope=row>6083257</th><td>HOU </td><td>TUL </td><td> 453</td><td> 4  </td><td>14  </td><td>0   </td></tr>
	<tr><th scope=row>6083258</th><td>HOU </td><td>TUL </td><td> 453</td><td> 3  </td><td> 9  </td><td>0   </td></tr>
	<tr><th scope=row>6083259</th><td>HOU </td><td>TUL </td><td> 453</td><td> 3  </td><td>11  </td><td>0   </td></tr>
</tbody>
</table>




```R
# Find the most concise way to select: columns Year up to and including DayOfWeek, columns ArrDelay up to and including Diverted. You can examine the order of the variables in hflights with names(hflights) in the console.
select(hflights, c(1:4, 12:21))
```


<table>
<thead><tr><th></th><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>ArrDelay</th><th scope=col>DepDelay</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th></tr></thead>
<tbody>
	<tr><th scope=row>5424</th><td>2011</td><td>1   </td><td> 1  </td><td>6   </td><td>-10 </td><td> 0  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 7  </td><td>13  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5425</th><td>2011</td><td>1   </td><td> 2  </td><td>7   </td><td> -9 </td><td> 1  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 6  </td><td> 9  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5426</th><td>2011</td><td>1   </td><td> 3  </td><td>1   </td><td> -8 </td><td>-8  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 5  </td><td>17  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5427</th><td>2011</td><td>1   </td><td> 4  </td><td>2   </td><td>  3 </td><td> 3  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 9  </td><td>22  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5428</th><td>2011</td><td>1   </td><td> 5  </td><td>3   </td><td> -3 </td><td> 5  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 9  </td><td> 9  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5429</th><td>2011</td><td>1   </td><td> 6  </td><td>4   </td><td> -7 </td><td>-1  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 6  </td><td>13  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5430</th><td>2011</td><td>1   </td><td> 7  </td><td>5   </td><td> -1 </td><td>-1  </td><td>IAH </td><td>DFW </td><td>224 </td><td>12  </td><td>15  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5431</th><td>2011</td><td>1   </td><td> 8  </td><td>6   </td><td>-16 </td><td>-5  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 7  </td><td>12  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5432</th><td>2011</td><td>1   </td><td> 9  </td><td>7   </td><td> 44 </td><td>43  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 8  </td><td>22  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5433</th><td>2011</td><td>1   </td><td>10  </td><td>1   </td><td> 43 </td><td>43  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 6  </td><td>19  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5434</th><td>2011</td><td>1   </td><td>11  </td><td>2   </td><td> 29 </td><td>29  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 8  </td><td>20  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5435</th><td>2011</td><td>1   </td><td>12  </td><td>3   </td><td>  5 </td><td>19  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 4  </td><td>11  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5436</th><td>2011</td><td>1   </td><td>13  </td><td>4   </td><td> -9 </td><td>-2  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 6  </td><td>13  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5437</th><td>2011</td><td>1   </td><td>14  </td><td>5   </td><td> -6 </td><td>-3  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 5  </td><td>15  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5438</th><td>2011</td><td>1   </td><td>15  </td><td>6   </td><td>-11 </td><td>-1  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 6  </td><td>10  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5439</th><td>2011</td><td>1   </td><td>16  </td><td>7   </td><td> -1 </td><td>-1  </td><td>IAH </td><td>DFW </td><td>224 </td><td>12  </td><td>17  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5440</th><td>2011</td><td>1   </td><td>17  </td><td>1   </td><td> 84 </td><td>90  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 8  </td><td> 8  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5441</th><td>2011</td><td>1   </td><td>18  </td><td>2   </td><td> -2 </td><td> 8  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 7  </td><td>11  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5442</th><td>2011</td><td>1   </td><td>19  </td><td>3   </td><td> -7 </td><td>-4  </td><td>IAH </td><td>DFW </td><td>224 </td><td>10  </td><td>11  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5443</th><td>2011</td><td>1   </td><td>20  </td><td>4   </td><td> 72 </td><td>67  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 9  </td><td>24  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5444</th><td>2011</td><td>1   </td><td>21  </td><td>5   </td><td>-11 </td><td>-3  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 6  </td><td> 9  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5445</th><td>2011</td><td>1   </td><td>22  </td><td>6   </td><td>-14 </td><td>-5  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 9  </td><td> 8  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5446</th><td>2011</td><td>1   </td><td>23  </td><td>7   </td><td> -9 </td><td>-4  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 7  </td><td>18  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5447</th><td>2011</td><td>1   </td><td>24  </td><td>1   </td><td>  3 </td><td>-4  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 6  </td><td>28  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5448</th><td>2011</td><td>1   </td><td>25  </td><td>2   </td><td>-18 </td><td>-8  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 7  </td><td>13  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5449</th><td>2011</td><td>1   </td><td>26  </td><td>3   </td><td>-15 </td><td>-7  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 8  </td><td>14  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5450</th><td>2011</td><td>1   </td><td>27  </td><td>4   </td><td>-12 </td><td>-4  </td><td>IAH </td><td>DFW </td><td>224 </td><td>12  </td><td>10  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5451</th><td>2011</td><td>1   </td><td>28  </td><td>5   </td><td> -5 </td><td>-1  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 8  </td><td>12  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5452</th><td>2011</td><td>1   </td><td>29  </td><td>6   </td><td>-15 </td><td>-5  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 7  </td><td> 7  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>5453</th><td>2011</td><td>1   </td><td>30  </td><td>7   </td><td>-14 </td><td>-1  </td><td>IAH </td><td>DFW </td><td>224 </td><td> 7  </td><td>11  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>...</th><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><th scope=row>6083230</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td>  2 </td><td>-3  </td><td>HOU </td><td>MSY </td><td> 302</td><td> 4  </td><td>11  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083231</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> -9 </td><td>-4  </td><td>HOU </td><td>MSY </td><td> 302</td><td> 5  </td><td> 7  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083232</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td>  7 </td><td>23  </td><td>HOU </td><td>OAK </td><td>1642</td><td> 5  </td><td> 8  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083233</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td>-15 </td><td> 5  </td><td>HOU </td><td>OAK </td><td>1642</td><td> 6  </td><td> 9  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083234</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> 31 </td><td>33  </td><td>HOU </td><td>OKC </td><td> 419</td><td> 4  </td><td>15  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083235</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td>-10 </td><td>-3  </td><td>HOU </td><td>OKC </td><td> 419</td><td> 3  </td><td> 9  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083236</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> -9 </td><td> 1  </td><td>HOU </td><td>OKC </td><td> 419</td><td> 4  </td><td> 8  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083237</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> 59 </td><td>72  </td><td>HOU </td><td>PHL </td><td>1336</td><td> 5  </td><td> 9  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083238</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> 71 </td><td>70  </td><td>HOU </td><td>PHX </td><td>1020</td><td> 4  </td><td>15  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083239</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> -2 </td><td>-3  </td><td>HOU </td><td>PHX </td><td>1020</td><td> 4  </td><td>10  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083240</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> 18 </td><td>20  </td><td>HOU </td><td>PHX </td><td>1020</td><td> 4  </td><td>10  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083241</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> 13 </td><td>15  </td><td>HOU </td><td>PHX </td><td>1020</td><td> 3  </td><td> 7  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083242</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> 70 </td><td>78  </td><td>HOU </td><td>SAN </td><td>1313</td><td> 3  </td><td> 7  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083243</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> -6 </td><td>-1  </td><td>HOU </td><td>SAN </td><td>1313</td><td> 2  </td><td>10  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083244</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> 29 </td><td>43  </td><td>HOU </td><td>SAT </td><td> 192</td><td> 4  </td><td> 4  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083245</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> 12 </td><td>12  </td><td>HOU </td><td>SAT </td><td> 192</td><td> 4  </td><td> 8  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083246</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td>  5 </td><td> 3  </td><td>HOU </td><td>SAT </td><td> 192</td><td> 4  </td><td>14  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083247</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td>  9 </td><td> 7  </td><td>HOU </td><td>SAT </td><td> 192</td><td> 5  </td><td> 9  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083248</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td>  0 </td><td>-3  </td><td>HOU </td><td>SAT </td><td> 192</td><td> 5  </td><td> 9  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083249</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> 14 </td><td>39  </td><td>HOU </td><td>STL </td><td> 687</td><td> 4  </td><td>15  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083250</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td>-10 </td><td>-4  </td><td>HOU </td><td>STL </td><td> 687</td><td>13  </td><td> 9  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083251</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td>-12 </td><td> 1  </td><td>HOU </td><td>STL </td><td> 687</td><td> 4  </td><td>12  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083252</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> -9 </td><td>16  </td><td>HOU </td><td>STL </td><td> 687</td><td> 3  </td><td> 9  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083253</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> -4 </td><td>-2  </td><td>HOU </td><td>TPA </td><td> 781</td><td> 3  </td><td>10  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083254</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td>  0 </td><td> 7  </td><td>HOU </td><td>TPA </td><td> 781</td><td> 5  </td><td>10  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083255</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> -9 </td><td> 8  </td><td>HOU </td><td>TPA </td><td> 781</td><td> 5  </td><td>11  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083256</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td>  4 </td><td> 7  </td><td>HOU </td><td>TPA </td><td> 781</td><td> 4  </td><td> 9  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083257</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td> -4 </td><td>-3  </td><td>HOU </td><td>TUL </td><td> 453</td><td> 4  </td><td>14  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083258</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td>-13 </td><td>-4  </td><td>HOU </td><td>TUL </td><td> 453</td><td> 3  </td><td> 9  </td><td>0   </td><td>    </td><td>0   </td></tr>
	<tr><th scope=row>6083259</th><td>2011</td><td>12  </td><td>6   </td><td>2   </td><td>-12 </td><td> 0  </td><td>HOU </td><td>TUL </td><td> 453</td><td> 3  </td><td>11  </td><td>0   </td><td>    </td><td>0   </td></tr>
</tbody>
</table>




```R
#dplyr comes with a set of helper functions that can help you select groups of variables inside a select() call:

#starts_with("X"): every name that starts with "X",
#ends_with("X"): every name that ends with "X",
#contains("X"): every name that contains "X",
#matches("X"): every name that matches "X", where "X" can be a regular expression,
#num_range("x", 1:5): the variables named x01, x02, x03, x04 and x05,
#one_of(x): every name that appears in x, which should be a character vector.

# Print out a tbl containing just ArrDelay and DepDelay
select(hflights, ends_with("Delay"))
```


<table>
<thead><tr><th></th><th scope=col>ArrDelay</th><th scope=col>DepDelay</th></tr></thead>
<tbody>
	<tr><th scope=row>5424</th><td>-10</td><td> 0 </td></tr>
	<tr><th scope=row>5425</th><td> -9</td><td> 1 </td></tr>
	<tr><th scope=row>5426</th><td> -8</td><td>-8 </td></tr>
	<tr><th scope=row>5427</th><td>  3</td><td> 3 </td></tr>
	<tr><th scope=row>5428</th><td> -3</td><td> 5 </td></tr>
	<tr><th scope=row>5429</th><td> -7</td><td>-1 </td></tr>
	<tr><th scope=row>5430</th><td> -1</td><td>-1 </td></tr>
	<tr><th scope=row>5431</th><td>-16</td><td>-5 </td></tr>
	<tr><th scope=row>5432</th><td> 44</td><td>43 </td></tr>
	<tr><th scope=row>5433</th><td> 43</td><td>43 </td></tr>
	<tr><th scope=row>5434</th><td> 29</td><td>29 </td></tr>
	<tr><th scope=row>5435</th><td>  5</td><td>19 </td></tr>
	<tr><th scope=row>5436</th><td> -9</td><td>-2 </td></tr>
	<tr><th scope=row>5437</th><td> -6</td><td>-3 </td></tr>
	<tr><th scope=row>5438</th><td>-11</td><td>-1 </td></tr>
	<tr><th scope=row>5439</th><td> -1</td><td>-1 </td></tr>
	<tr><th scope=row>5440</th><td> 84</td><td>90 </td></tr>
	<tr><th scope=row>5441</th><td> -2</td><td> 8 </td></tr>
	<tr><th scope=row>5442</th><td> -7</td><td>-4 </td></tr>
	<tr><th scope=row>5443</th><td> 72</td><td>67 </td></tr>
	<tr><th scope=row>5444</th><td>-11</td><td>-3 </td></tr>
	<tr><th scope=row>5445</th><td>-14</td><td>-5 </td></tr>
	<tr><th scope=row>5446</th><td> -9</td><td>-4 </td></tr>
	<tr><th scope=row>5447</th><td>  3</td><td>-4 </td></tr>
	<tr><th scope=row>5448</th><td>-18</td><td>-8 </td></tr>
	<tr><th scope=row>5449</th><td>-15</td><td>-7 </td></tr>
	<tr><th scope=row>5450</th><td>-12</td><td>-4 </td></tr>
	<tr><th scope=row>5451</th><td> -5</td><td>-1 </td></tr>
	<tr><th scope=row>5452</th><td>-15</td><td>-5 </td></tr>
	<tr><th scope=row>5453</th><td>-14</td><td>-1 </td></tr>
	<tr><th scope=row>...</th><td>...</td><td>...</td></tr>
	<tr><th scope=row>6083230</th><td>  2</td><td>-3 </td></tr>
	<tr><th scope=row>6083231</th><td> -9</td><td>-4 </td></tr>
	<tr><th scope=row>6083232</th><td>  7</td><td>23 </td></tr>
	<tr><th scope=row>6083233</th><td>-15</td><td> 5 </td></tr>
	<tr><th scope=row>6083234</th><td> 31</td><td>33 </td></tr>
	<tr><th scope=row>6083235</th><td>-10</td><td>-3 </td></tr>
	<tr><th scope=row>6083236</th><td> -9</td><td> 1 </td></tr>
	<tr><th scope=row>6083237</th><td> 59</td><td>72 </td></tr>
	<tr><th scope=row>6083238</th><td> 71</td><td>70 </td></tr>
	<tr><th scope=row>6083239</th><td> -2</td><td>-3 </td></tr>
	<tr><th scope=row>6083240</th><td> 18</td><td>20 </td></tr>
	<tr><th scope=row>6083241</th><td> 13</td><td>15 </td></tr>
	<tr><th scope=row>6083242</th><td> 70</td><td>78 </td></tr>
	<tr><th scope=row>6083243</th><td> -6</td><td>-1 </td></tr>
	<tr><th scope=row>6083244</th><td> 29</td><td>43 </td></tr>
	<tr><th scope=row>6083245</th><td> 12</td><td>12 </td></tr>
	<tr><th scope=row>6083246</th><td>  5</td><td> 3 </td></tr>
	<tr><th scope=row>6083247</th><td>  9</td><td> 7 </td></tr>
	<tr><th scope=row>6083248</th><td>  0</td><td>-3 </td></tr>
	<tr><th scope=row>6083249</th><td> 14</td><td>39 </td></tr>
	<tr><th scope=row>6083250</th><td>-10</td><td>-4 </td></tr>
	<tr><th scope=row>6083251</th><td>-12</td><td> 1 </td></tr>
	<tr><th scope=row>6083252</th><td> -9</td><td>16 </td></tr>
	<tr><th scope=row>6083253</th><td> -4</td><td>-2 </td></tr>
	<tr><th scope=row>6083254</th><td>  0</td><td> 7 </td></tr>
	<tr><th scope=row>6083255</th><td> -9</td><td> 8 </td></tr>
	<tr><th scope=row>6083256</th><td>  4</td><td> 7 </td></tr>
	<tr><th scope=row>6083257</th><td> -4</td><td>-3 </td></tr>
	<tr><th scope=row>6083258</th><td>-13</td><td>-4 </td></tr>
	<tr><th scope=row>6083259</th><td>-12</td><td> 0 </td></tr>
</tbody>
</table>




```R
# Print out a tbl as described in the second instruction, using both helper functions and variable names
select(hflights, c(UniqueCarrier, ends_with("Num") , starts_with("Cancel") ) )
```


<table>
<thead><tr><th></th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th></tr></thead>
<tbody>
	<tr><th scope=row>5424</th><td>AA    </td><td>428   </td><td>N576AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5425</th><td>AA    </td><td>428   </td><td>N557AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5426</th><td>AA    </td><td>428   </td><td>N541AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5427</th><td>AA    </td><td>428   </td><td>N403AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5428</th><td>AA    </td><td>428   </td><td>N492AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5429</th><td>AA    </td><td>428   </td><td>N262AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5430</th><td>AA    </td><td>428   </td><td>N493AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5431</th><td>AA    </td><td>428   </td><td>N477AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5432</th><td>AA    </td><td>428   </td><td>N476AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5433</th><td>AA    </td><td>428   </td><td>N504AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5434</th><td>AA    </td><td>428   </td><td>N565AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5435</th><td>AA    </td><td>428   </td><td>N577AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5436</th><td>AA    </td><td>428   </td><td>N476AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5437</th><td>AA    </td><td>428   </td><td>N552AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5438</th><td>AA    </td><td>428   </td><td>N462AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5439</th><td>AA    </td><td>428   </td><td>N555AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5440</th><td>AA    </td><td>428   </td><td>N518AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5441</th><td>AA    </td><td>428   </td><td>N507AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5442</th><td>AA    </td><td>428   </td><td>N523AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5443</th><td>AA    </td><td>428   </td><td>N425AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5444</th><td>AA    </td><td>428   </td><td>N251AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5445</th><td>AA    </td><td>428   </td><td>N551AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5446</th><td>AA    </td><td>428   </td><td>N479AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5447</th><td>AA    </td><td>428   </td><td>N531AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5448</th><td>AA    </td><td>428   </td><td>N561AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5449</th><td>AA    </td><td>428   </td><td>N541AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5450</th><td>AA    </td><td>428   </td><td>N512AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5451</th><td>AA    </td><td>428   </td><td>N4UBAA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5452</th><td>AA    </td><td>428   </td><td>N491AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>5453</th><td>AA    </td><td>428   </td><td>N561AA</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>...</th><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><th scope=row>6083230</th><td>WN    </td><td>1628  </td><td>N435WN</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083231</th><td>WN    </td><td>2534  </td><td>N232WN</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083232</th><td>WN    </td><td> 902  </td><td>N724SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083233</th><td>WN    </td><td>1167  </td><td>N455WN</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083234</th><td>WN    </td><td> 513  </td><td>N362SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083235</th><td>WN    </td><td> 581  </td><td>N646SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083236</th><td>WN    </td><td>1223  </td><td>N394SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083237</th><td>WN    </td><td>3085  </td><td>N510SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083238</th><td>WN    </td><td>  39  </td><td>N754SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083239</th><td>WN    </td><td> 424  </td><td>N769SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083240</th><td>WN    </td><td>1098  </td><td>N448WN</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083241</th><td>WN    </td><td>1403  </td><td>N430WN</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083242</th><td>WN    </td><td>  33  </td><td>N698SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083243</th><td>WN    </td><td>1212  </td><td>N226WN</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083244</th><td>WN    </td><td> 207  </td><td>N354SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083245</th><td>WN    </td><td> 405  </td><td>N617SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083246</th><td>WN    </td><td> 628  </td><td>N389SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083247</th><td>WN    </td><td> 994  </td><td>N713SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083248</th><td>WN    </td><td>1231  </td><td>N284WN</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083249</th><td>WN    </td><td> 124  </td><td>N522SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083250</th><td>WN    </td><td> 280  </td><td>N728SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083251</th><td>WN    </td><td> 782  </td><td>N476WN</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083252</th><td>WN    </td><td>1050  </td><td>N655WN</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083253</th><td>WN    </td><td> 201  </td><td>N903WN</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083254</th><td>WN    </td><td> 471  </td><td>N632SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083255</th><td>WN    </td><td>1191  </td><td>N284WN</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083256</th><td>WN    </td><td>1674  </td><td>N366SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083257</th><td>WN    </td><td> 127  </td><td>N777QC</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083258</th><td>WN    </td><td> 621  </td><td>N727SW</td><td>0     </td><td>      </td></tr>
	<tr><th scope=row>6083259</th><td>WN    </td><td>1597  </td><td>N745SW</td><td>0     </td><td>      </td></tr>
</tbody>
</table>




```R
# Print out a tbl as described in the third instruction, using only helper functions.
select(hflights, c(ends_with("Time"), ends_with("Delay")) )

```


<table>
<thead><tr><th></th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>ActualElapsedTime</th><th scope=col>AirTime</th><th scope=col>ArrDelay</th><th scope=col>DepDelay</th></tr></thead>
<tbody>
	<tr><th scope=row>5424</th><td>1400</td><td>1500</td><td>60  </td><td>40  </td><td>-10 </td><td> 0  </td></tr>
	<tr><th scope=row>5425</th><td>1401</td><td>1501</td><td>60  </td><td>45  </td><td> -9 </td><td> 1  </td></tr>
	<tr><th scope=row>5426</th><td>1352</td><td>1502</td><td>70  </td><td>48  </td><td> -8 </td><td>-8  </td></tr>
	<tr><th scope=row>5427</th><td>1403</td><td>1513</td><td>70  </td><td>39  </td><td>  3 </td><td> 3  </td></tr>
	<tr><th scope=row>5428</th><td>1405</td><td>1507</td><td>62  </td><td>44  </td><td> -3 </td><td> 5  </td></tr>
	<tr><th scope=row>5429</th><td>1359</td><td>1503</td><td>64  </td><td>45  </td><td> -7 </td><td>-1  </td></tr>
	<tr><th scope=row>5430</th><td>1359</td><td>1509</td><td>70  </td><td>43  </td><td> -1 </td><td>-1  </td></tr>
	<tr><th scope=row>5431</th><td>1355</td><td>1454</td><td>59  </td><td>40  </td><td>-16 </td><td>-5  </td></tr>
	<tr><th scope=row>5432</th><td>1443</td><td>1554</td><td>71  </td><td>41  </td><td> 44 </td><td>43  </td></tr>
	<tr><th scope=row>5433</th><td>1443</td><td>1553</td><td>70  </td><td>45  </td><td> 43 </td><td>43  </td></tr>
	<tr><th scope=row>5434</th><td>1429</td><td>1539</td><td>70  </td><td>42  </td><td> 29 </td><td>29  </td></tr>
	<tr><th scope=row>5435</th><td>1419</td><td>1515</td><td>56  </td><td>41  </td><td>  5 </td><td>19  </td></tr>
	<tr><th scope=row>5436</th><td>1358</td><td>1501</td><td>63  </td><td>44  </td><td> -9 </td><td>-2  </td></tr>
	<tr><th scope=row>5437</th><td>1357</td><td>1504</td><td>67  </td><td>47  </td><td> -6 </td><td>-3  </td></tr>
	<tr><th scope=row>5438</th><td>1359</td><td>1459</td><td>60  </td><td>44  </td><td>-11 </td><td>-1  </td></tr>
	<tr><th scope=row>5439</th><td>1359</td><td>1509</td><td>70  </td><td>41  </td><td> -1 </td><td>-1  </td></tr>
	<tr><th scope=row>5440</th><td>1530</td><td>1634</td><td>64  </td><td>48  </td><td> 84 </td><td>90  </td></tr>
	<tr><th scope=row>5441</th><td>1408</td><td>1508</td><td>60  </td><td>42  </td><td> -2 </td><td> 8  </td></tr>
	<tr><th scope=row>5442</th><td>1356</td><td>1503</td><td>67  </td><td>46  </td><td> -7 </td><td>-4  </td></tr>
	<tr><th scope=row>5443</th><td>1507</td><td>1622</td><td>75  </td><td>42  </td><td> 72 </td><td>67  </td></tr>
	<tr><th scope=row>5444</th><td>1357</td><td>1459</td><td>62  </td><td>47  </td><td>-11 </td><td>-3  </td></tr>
	<tr><th scope=row>5445</th><td>1355</td><td>1456</td><td>61  </td><td>44  </td><td>-14 </td><td>-5  </td></tr>
	<tr><th scope=row>5446</th><td>1356</td><td>1501</td><td>65  </td><td>40  </td><td> -9 </td><td>-4  </td></tr>
	<tr><th scope=row>5447</th><td>1356</td><td>1513</td><td>77  </td><td>43  </td><td>  3 </td><td>-4  </td></tr>
	<tr><th scope=row>5448</th><td>1352</td><td>1452</td><td>60  </td><td>40  </td><td>-18 </td><td>-8  </td></tr>
	<tr><th scope=row>5449</th><td>1353</td><td>1455</td><td>62  </td><td>40  </td><td>-15 </td><td>-7  </td></tr>
	<tr><th scope=row>5450</th><td>1356</td><td>1458</td><td>62  </td><td>40  </td><td>-12 </td><td>-4  </td></tr>
	<tr><th scope=row>5451</th><td>1359</td><td>1505</td><td>66  </td><td>46  </td><td> -5 </td><td>-1  </td></tr>
	<tr><th scope=row>5452</th><td>1355</td><td>1455</td><td>60  </td><td>46  </td><td>-15 </td><td>-5  </td></tr>
	<tr><th scope=row>5453</th><td>1359</td><td>1456</td><td>57  </td><td>39  </td><td>-14 </td><td>-1  </td></tr>
	<tr><th scope=row>...</th><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><th scope=row>6083230</th><td> 752</td><td> 857</td><td> 65 </td><td> 50 </td><td>  2 </td><td>-3  </td></tr>
	<tr><th scope=row>6083231</th><td> 651</td><td> 746</td><td> 55 </td><td> 43 </td><td> -9 </td><td>-4  </td></tr>
	<tr><th scope=row>6083232</th><td>1728</td><td>1932</td><td>244 </td><td>231 </td><td>  7 </td><td>23  </td></tr>
	<tr><th scope=row>6083233</th><td>1115</td><td>1315</td><td>240 </td><td>225 </td><td>-15 </td><td> 5  </td></tr>
	<tr><th scope=row>6083234</th><td>1753</td><td>1911</td><td> 78 </td><td> 59 </td><td> 31 </td><td>33  </td></tr>
	<tr><th scope=row>6083235</th><td>1222</td><td>1335</td><td> 73 </td><td> 61 </td><td>-10 </td><td>-3  </td></tr>
	<tr><th scope=row>6083236</th><td> 836</td><td> 946</td><td> 70 </td><td> 58 </td><td> -9 </td><td> 1  </td></tr>
	<tr><th scope=row>6083237</th><td>1352</td><td>1749</td><td>177 </td><td>163 </td><td> 59 </td><td>72  </td></tr>
	<tr><th scope=row>6083238</th><td>1850</td><td>2046</td><td>176 </td><td>157 </td><td> 71 </td><td>70  </td></tr>
	<tr><th scope=row>6083239</th><td> 707</td><td> 903</td><td>176 </td><td>162 </td><td> -2 </td><td>-3  </td></tr>
	<tr><th scope=row>6083240</th><td>1335</td><td>1528</td><td>173 </td><td>159 </td><td> 18 </td><td>20  </td></tr>
	<tr><th scope=row>6083241</th><td>1005</td><td>1158</td><td>173 </td><td>163 </td><td> 13 </td><td>15  </td></tr>
	<tr><th scope=row>6083242</th><td>1723</td><td>1845</td><td>202 </td><td>192 </td><td> 70 </td><td>78  </td></tr>
	<tr><th scope=row>6083243</th><td>1139</td><td>1304</td><td>205 </td><td>193 </td><td> -6 </td><td>-1  </td></tr>
	<tr><th scope=row>6083244</th><td>2023</td><td>2109</td><td> 46 </td><td> 38 </td><td> 29 </td><td>43  </td></tr>
	<tr><th scope=row>6083245</th><td>1542</td><td>1637</td><td> 55 </td><td> 43 </td><td> 12 </td><td>12  </td></tr>
	<tr><th scope=row>6083246</th><td>1728</td><td>1825</td><td> 57 </td><td> 39 </td><td>  5 </td><td> 3  </td></tr>
	<tr><th scope=row>6083247</th><td>1252</td><td>1349</td><td> 57 </td><td> 43 </td><td>  9 </td><td> 7  </td></tr>
	<tr><th scope=row>6083248</th><td> 857</td><td> 955</td><td> 58 </td><td> 44 </td><td>  0 </td><td>-3  </td></tr>
	<tr><th scope=row>6083249</th><td>1939</td><td>2119</td><td>100 </td><td> 81 </td><td> 14 </td><td>39  </td></tr>
	<tr><th scope=row>6083250</th><td> 556</td><td> 745</td><td>109 </td><td> 87 </td><td>-10 </td><td>-4  </td></tr>
	<tr><th scope=row>6083251</th><td>1026</td><td>1208</td><td>102 </td><td> 86 </td><td>-12 </td><td> 1  </td></tr>
	<tr><th scope=row>6083252</th><td>1611</td><td>1746</td><td> 95 </td><td> 83 </td><td> -9 </td><td>16  </td></tr>
	<tr><th scope=row>6083253</th><td> 758</td><td>1051</td><td>113 </td><td>100 </td><td> -4 </td><td>-2  </td></tr>
	<tr><th scope=row>6083254</th><td>1307</td><td>1600</td><td>113 </td><td> 98 </td><td>  0 </td><td> 7  </td></tr>
	<tr><th scope=row>6083255</th><td>1818</td><td>2111</td><td>113 </td><td> 97 </td><td> -9 </td><td> 8  </td></tr>
	<tr><th scope=row>6083256</th><td>2047</td><td>2334</td><td>107 </td><td> 94 </td><td>  4 </td><td> 7  </td></tr>
	<tr><th scope=row>6083257</th><td> 912</td><td>1031</td><td> 79 </td><td> 61 </td><td> -4 </td><td>-3  </td></tr>
	<tr><th scope=row>6083258</th><td> 656</td><td> 812</td><td> 76 </td><td> 64 </td><td>-13 </td><td>-4  </td></tr>
	<tr><th scope=row>6083259</th><td>1600</td><td>1713</td><td> 73 </td><td> 59 </td><td>-12 </td><td> 0  </td></tr>
</tbody>
</table>




```R
# Finish select call so that ex1d matches ex1r
ex1r <- hflights[c("TaxiIn", "TaxiOut", "Distance")]
ex1d <- select(hflights, c(starts_with("Taxi"), Distance) )
identical(ex1r,ex1d)
```


FALSE



```R
# Finish select call so that ex2d matches ex2r
ex2r <- hflights[c("Year", "Month", "DayOfWeek", "DepTime", "ArrTime")]
ex2d <- select(hflights, 1:6, -3)
identical(ex2r,ex2d)
```


FALSE



```R
# Finish select call so that ex3d matches ex3r
ex3r <- hflights[c("TailNum", "TaxiIn", "TaxiOut")]
ex3d <- select(hflights, c(TailNum, starts_with("Taxi")))
identical(ex3r,ex3d)
```


FALSE



```R
# Add the new variable ActualGroundTime to a copy of hflights and save the result as g1.
g1 <- mutate(hflights, ActualGroundTime = ActualElapsedTime - AirTime)

# Add the new variable GroundTime to g1. Save the result as g2.
g2 <- mutate(g1, GroundTime = TaxiIn + TaxiOut)

# Add the new variable AverageSpeed to g2. Save the result as g3.
g3 <- mutate(g2, AverageSpeed = Distance / AirTime * 60)

# Print out g3
g3
```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th><th scope=col>ActualGroundTime</th><th scope=col>GroundTime</th><th scope=col>AverageSpeed</th></tr></thead>
<tbody>
	<tr><td>2011    </td><td>1       </td><td> 1      </td><td>6       </td><td>1400    </td><td>1500    </td><td>AA      </td><td>428     </td><td>N576AA  </td><td>60      </td><td>...     </td><td> 7      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>20      </td><td>20      </td><td>336.0000</td></tr>
	<tr><td>2011    </td><td>1       </td><td> 2      </td><td>7       </td><td>1401    </td><td>1501    </td><td>AA      </td><td>428     </td><td>N557AA  </td><td>60      </td><td>...     </td><td> 6      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>15      </td><td>15      </td><td>298.6667</td></tr>
	<tr><td>2011    </td><td>1       </td><td> 3      </td><td>1       </td><td>1352    </td><td>1502    </td><td>AA      </td><td>428     </td><td>N541AA  </td><td>70      </td><td>...     </td><td> 5      </td><td>17      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>22      </td><td>22      </td><td>280.0000</td></tr>
	<tr><td>2011    </td><td>1       </td><td> 4      </td><td>2       </td><td>1403    </td><td>1513    </td><td>AA      </td><td>428     </td><td>N403AA  </td><td>70      </td><td>...     </td><td> 9      </td><td>22      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>31      </td><td>31      </td><td>344.6154</td></tr>
	<tr><td>2011    </td><td>1       </td><td> 5      </td><td>3       </td><td>1405    </td><td>1507    </td><td>AA      </td><td>428     </td><td>N492AA  </td><td>62      </td><td>...     </td><td> 9      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>18      </td><td>18      </td><td>305.4545</td></tr>
	<tr><td>2011    </td><td>1       </td><td> 6      </td><td>4       </td><td>1359    </td><td>1503    </td><td>AA      </td><td>428     </td><td>N262AA  </td><td>64      </td><td>...     </td><td> 6      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>19      </td><td>19      </td><td>298.6667</td></tr>
	<tr><td>2011    </td><td>1       </td><td> 7      </td><td>5       </td><td>1359    </td><td>1509    </td><td>AA      </td><td>428     </td><td>N493AA  </td><td>70      </td><td>...     </td><td>12      </td><td>15      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>27      </td><td>27      </td><td>312.5581</td></tr>
	<tr><td>2011    </td><td>1       </td><td> 8      </td><td>6       </td><td>1355    </td><td>1454    </td><td>AA      </td><td>428     </td><td>N477AA  </td><td>59      </td><td>...     </td><td> 7      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>19      </td><td>19      </td><td>336.0000</td></tr>
	<tr><td>2011    </td><td>1       </td><td> 9      </td><td>7       </td><td>1443    </td><td>1554    </td><td>AA      </td><td>428     </td><td>N476AA  </td><td>71      </td><td>...     </td><td> 8      </td><td>22      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>30      </td><td>30      </td><td>327.8049</td></tr>
	<tr><td>2011    </td><td>1       </td><td>10      </td><td>1       </td><td>1443    </td><td>1553    </td><td>AA      </td><td>428     </td><td>N504AA  </td><td>70      </td><td>...     </td><td> 6      </td><td>19      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>25      </td><td>25      </td><td>298.6667</td></tr>
	<tr><td>2011    </td><td>1       </td><td>11      </td><td>2       </td><td>1429    </td><td>1539    </td><td>AA      </td><td>428     </td><td>N565AA  </td><td>70      </td><td>...     </td><td> 8      </td><td>20      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>28      </td><td>28      </td><td>320.0000</td></tr>
	<tr><td>2011    </td><td>1       </td><td>12      </td><td>3       </td><td>1419    </td><td>1515    </td><td>AA      </td><td>428     </td><td>N577AA  </td><td>56      </td><td>...     </td><td> 4      </td><td>11      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>15      </td><td>15      </td><td>327.8049</td></tr>
	<tr><td>2011    </td><td>1       </td><td>13      </td><td>4       </td><td>1358    </td><td>1501    </td><td>AA      </td><td>428     </td><td>N476AA  </td><td>63      </td><td>...     </td><td> 6      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>19      </td><td>19      </td><td>305.4545</td></tr>
	<tr><td>2011    </td><td>1       </td><td>14      </td><td>5       </td><td>1357    </td><td>1504    </td><td>AA      </td><td>428     </td><td>N552AA  </td><td>67      </td><td>...     </td><td> 5      </td><td>15      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>20      </td><td>20      </td><td>285.9574</td></tr>
	<tr><td>2011    </td><td>1       </td><td>15      </td><td>6       </td><td>1359    </td><td>1459    </td><td>AA      </td><td>428     </td><td>N462AA  </td><td>60      </td><td>...     </td><td> 6      </td><td>10      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>16      </td><td>16      </td><td>305.4545</td></tr>
	<tr><td>2011    </td><td>1       </td><td>16      </td><td>7       </td><td>1359    </td><td>1509    </td><td>AA      </td><td>428     </td><td>N555AA  </td><td>70      </td><td>...     </td><td>12      </td><td>17      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>29      </td><td>29      </td><td>327.8049</td></tr>
	<tr><td>2011    </td><td>1       </td><td>17      </td><td>1       </td><td>1530    </td><td>1634    </td><td>AA      </td><td>428     </td><td>N518AA  </td><td>64      </td><td>...     </td><td> 8      </td><td> 8      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>16      </td><td>16      </td><td>280.0000</td></tr>
	<tr><td>2011    </td><td>1       </td><td>18      </td><td>2       </td><td>1408    </td><td>1508    </td><td>AA      </td><td>428     </td><td>N507AA  </td><td>60      </td><td>...     </td><td> 7      </td><td>11      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>18      </td><td>18      </td><td>320.0000</td></tr>
	<tr><td>2011    </td><td>1       </td><td>19      </td><td>3       </td><td>1356    </td><td>1503    </td><td>AA      </td><td>428     </td><td>N523AA  </td><td>67      </td><td>...     </td><td>10      </td><td>11      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>21      </td><td>21      </td><td>292.1739</td></tr>
	<tr><td>2011    </td><td>1       </td><td>20      </td><td>4       </td><td>1507    </td><td>1622    </td><td>AA      </td><td>428     </td><td>N425AA  </td><td>75      </td><td>...     </td><td> 9      </td><td>24      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>33      </td><td>33      </td><td>320.0000</td></tr>
	<tr><td>2011    </td><td>1       </td><td>21      </td><td>5       </td><td>1357    </td><td>1459    </td><td>AA      </td><td>428     </td><td>N251AA  </td><td>62      </td><td>...     </td><td> 6      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>15      </td><td>15      </td><td>285.9574</td></tr>
	<tr><td>2011    </td><td>1       </td><td>22      </td><td>6       </td><td>1355    </td><td>1456    </td><td>AA      </td><td>428     </td><td>N551AA  </td><td>61      </td><td>...     </td><td> 9      </td><td> 8      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>17      </td><td>17      </td><td>305.4545</td></tr>
	<tr><td>2011    </td><td>1       </td><td>23      </td><td>7       </td><td>1356    </td><td>1501    </td><td>AA      </td><td>428     </td><td>N479AA  </td><td>65      </td><td>...     </td><td> 7      </td><td>18      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>25      </td><td>25      </td><td>336.0000</td></tr>
	<tr><td>2011    </td><td>1       </td><td>24      </td><td>1       </td><td>1356    </td><td>1513    </td><td>AA      </td><td>428     </td><td>N531AA  </td><td>77      </td><td>...     </td><td> 6      </td><td>28      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>34      </td><td>34      </td><td>312.5581</td></tr>
	<tr><td>2011    </td><td>1       </td><td>25      </td><td>2       </td><td>1352    </td><td>1452    </td><td>AA      </td><td>428     </td><td>N561AA  </td><td>60      </td><td>...     </td><td> 7      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>20      </td><td>20      </td><td>336.0000</td></tr>
	<tr><td>2011    </td><td>1       </td><td>26      </td><td>3       </td><td>1353    </td><td>1455    </td><td>AA      </td><td>428     </td><td>N541AA  </td><td>62      </td><td>...     </td><td> 8      </td><td>14      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>22      </td><td>22      </td><td>336.0000</td></tr>
	<tr><td>2011    </td><td>1       </td><td>27      </td><td>4       </td><td>1356    </td><td>1458    </td><td>AA      </td><td>428     </td><td>N512AA  </td><td>62      </td><td>...     </td><td>12      </td><td>10      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>22      </td><td>22      </td><td>336.0000</td></tr>
	<tr><td>2011    </td><td>1       </td><td>28      </td><td>5       </td><td>1359    </td><td>1505    </td><td>AA      </td><td>428     </td><td>N4UBAA  </td><td>66      </td><td>...     </td><td> 8      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>20      </td><td>20      </td><td>292.1739</td></tr>
	<tr><td>2011    </td><td>1       </td><td>29      </td><td>6       </td><td>1355    </td><td>1455    </td><td>AA      </td><td>428     </td><td>N491AA  </td><td>60      </td><td>...     </td><td> 7      </td><td> 7      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>14      </td><td>14      </td><td>292.1739</td></tr>
	<tr><td>2011    </td><td>1       </td><td>30      </td><td>7       </td><td>1359    </td><td>1456    </td><td>AA      </td><td>428     </td><td>N561AA  </td><td>57      </td><td>...     </td><td> 7      </td><td>11      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>18      </td><td>18      </td><td>344.6154</td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>   </td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 752     </td><td> 857     </td><td>WN       </td><td>1628     </td><td>N435WN   </td><td> 65      </td><td>...      </td><td> 4       </td><td>11       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>15       </td><td>15       </td><td>362.4000 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 651     </td><td> 746     </td><td>WN       </td><td>2534     </td><td>N232WN   </td><td> 55      </td><td>...      </td><td> 5       </td><td> 7       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>12       </td><td>12       </td><td>421.3953 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1728     </td><td>1932     </td><td>WN       </td><td> 902     </td><td>N724SW   </td><td>244      </td><td>...      </td><td> 5       </td><td> 8       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>13       </td><td>13       </td><td>426.4935 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1115     </td><td>1315     </td><td>WN       </td><td>1167     </td><td>N455WN   </td><td>240      </td><td>...      </td><td> 6       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>15       </td><td>15       </td><td>437.8667 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1753     </td><td>1911     </td><td>WN       </td><td> 513     </td><td>N362SW   </td><td> 78      </td><td>...      </td><td> 4       </td><td>15       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>19       </td><td>19       </td><td>426.1017 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1222     </td><td>1335     </td><td>WN       </td><td> 581     </td><td>N646SW   </td><td> 73      </td><td>...      </td><td> 3       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>12       </td><td>12       </td><td>412.1311 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 836     </td><td> 946     </td><td>WN       </td><td>1223     </td><td>N394SW   </td><td> 70      </td><td>...      </td><td> 4       </td><td> 8       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>12       </td><td>12       </td><td>433.4483 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1352     </td><td>1749     </td><td>WN       </td><td>3085     </td><td>N510SW   </td><td>177      </td><td>...      </td><td> 5       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>14       </td><td>14       </td><td>491.7791 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1850     </td><td>2046     </td><td>WN       </td><td>  39     </td><td>N754SW   </td><td>176      </td><td>...      </td><td> 4       </td><td>15       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>19       </td><td>19       </td><td>389.8089 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 707     </td><td> 903     </td><td>WN       </td><td> 424     </td><td>N769SW   </td><td>176      </td><td>...      </td><td> 4       </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>14       </td><td>14       </td><td>377.7778 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1335     </td><td>1528     </td><td>WN       </td><td>1098     </td><td>N448WN   </td><td>173      </td><td>...      </td><td> 4       </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>14       </td><td>14       </td><td>384.9057 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1005     </td><td>1158     </td><td>WN       </td><td>1403     </td><td>N430WN   </td><td>173      </td><td>...      </td><td> 3       </td><td> 7       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>10       </td><td>10       </td><td>375.4601 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1723     </td><td>1845     </td><td>WN       </td><td>  33     </td><td>N698SW   </td><td>202      </td><td>...      </td><td> 3       </td><td> 7       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>10       </td><td>10       </td><td>410.3125 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1139     </td><td>1304     </td><td>WN       </td><td>1212     </td><td>N226WN   </td><td>205      </td><td>...      </td><td> 2       </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>12       </td><td>12       </td><td>408.1865 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>2023     </td><td>2109     </td><td>WN       </td><td> 207     </td><td>N354SW   </td><td> 46      </td><td>...      </td><td> 4       </td><td> 4       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td> 8       </td><td> 8       </td><td>303.1579 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1542     </td><td>1637     </td><td>WN       </td><td> 405     </td><td>N617SW   </td><td> 55      </td><td>...      </td><td> 4       </td><td> 8       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>12       </td><td>12       </td><td>267.9070 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1728     </td><td>1825     </td><td>WN       </td><td> 628     </td><td>N389SW   </td><td> 57      </td><td>...      </td><td> 4       </td><td>14       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>18       </td><td>18       </td><td>295.3846 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1252     </td><td>1349     </td><td>WN       </td><td> 994     </td><td>N713SW   </td><td> 57      </td><td>...      </td><td> 5       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>14       </td><td>14       </td><td>267.9070 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 857     </td><td> 955     </td><td>WN       </td><td>1231     </td><td>N284WN   </td><td> 58      </td><td>...      </td><td> 5       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>14       </td><td>14       </td><td>261.8182 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1939     </td><td>2119     </td><td>WN       </td><td> 124     </td><td>N522SW   </td><td>100      </td><td>...      </td><td> 4       </td><td>15       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>19       </td><td>19       </td><td>508.8889 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 556     </td><td> 745     </td><td>WN       </td><td> 280     </td><td>N728SW   </td><td>109      </td><td>...      </td><td>13       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>22       </td><td>22       </td><td>473.7931 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1026     </td><td>1208     </td><td>WN       </td><td> 782     </td><td>N476WN   </td><td>102      </td><td>...      </td><td> 4       </td><td>12       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>16       </td><td>16       </td><td>479.3023 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1611     </td><td>1746     </td><td>WN       </td><td>1050     </td><td>N655WN   </td><td> 95      </td><td>...      </td><td> 3       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>12       </td><td>12       </td><td>496.6265 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 758     </td><td>1051     </td><td>WN       </td><td> 201     </td><td>N903WN   </td><td>113      </td><td>...      </td><td> 3       </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>13       </td><td>13       </td><td>468.6000 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1307     </td><td>1600     </td><td>WN       </td><td> 471     </td><td>N632SW   </td><td>113      </td><td>...      </td><td> 5       </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>15       </td><td>15       </td><td>478.1633 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1818     </td><td>2111     </td><td>WN       </td><td>1191     </td><td>N284WN   </td><td>113      </td><td>...      </td><td> 5       </td><td>11       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>16       </td><td>16       </td><td>483.0928 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>2047     </td><td>2334     </td><td>WN       </td><td>1674     </td><td>N366SW   </td><td>107      </td><td>...      </td><td> 4       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>13       </td><td>13       </td><td>498.5106 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 912     </td><td>1031     </td><td>WN       </td><td> 127     </td><td>N777QC   </td><td> 79      </td><td>...      </td><td> 4       </td><td>14       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>18       </td><td>18       </td><td>445.5738 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 656     </td><td> 812     </td><td>WN       </td><td> 621     </td><td>N727SW   </td><td> 76      </td><td>...      </td><td> 3       </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>12       </td><td>12       </td><td>424.6875 </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1600     </td><td>1713     </td><td>WN       </td><td>1597     </td><td>N745SW   </td><td> 73      </td><td>...      </td><td> 3       </td><td>11       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td><td>14       </td><td>14       </td><td>460.6780 </td></tr>
</tbody>
</table>




```R
# Add a second variable loss_ratio to the dataset: m1
m1 <- mutate(hflights, loss = ArrDelay - DepDelay, loss_ratio = loss/DepDelay )
head(m1)

```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th><th scope=col>loss</th><th scope=col>loss_ratio</th></tr></thead>
<tbody>
	<tr><td>2011    </td><td>1       </td><td>1       </td><td>6       </td><td>1400    </td><td>1500    </td><td>AA      </td><td>428     </td><td>N576AA  </td><td>60      </td><td>...     </td><td>224     </td><td>7       </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>-10     </td><td> -Inf   </td></tr>
	<tr><td>2011    </td><td>1       </td><td>2       </td><td>7       </td><td>1401    </td><td>1501    </td><td>AA      </td><td>428     </td><td>N557AA  </td><td>60      </td><td>...     </td><td>224     </td><td>6       </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>-10     </td><td>-10.0   </td></tr>
	<tr><td>2011    </td><td>1       </td><td>3       </td><td>1       </td><td>1352    </td><td>1502    </td><td>AA      </td><td>428     </td><td>N541AA  </td><td>70      </td><td>...     </td><td>224     </td><td>5       </td><td>17      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>  0     </td><td>  0.0   </td></tr>
	<tr><td>2011    </td><td>1       </td><td>4       </td><td>2       </td><td>1403    </td><td>1513    </td><td>AA      </td><td>428     </td><td>N403AA  </td><td>70      </td><td>...     </td><td>224     </td><td>9       </td><td>22      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>  0     </td><td>  0.0   </td></tr>
	<tr><td>2011    </td><td>1       </td><td>5       </td><td>3       </td><td>1405    </td><td>1507    </td><td>AA      </td><td>428     </td><td>N492AA  </td><td>62      </td><td>...     </td><td>224     </td><td>9       </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td> -8     </td><td> -1.6   </td></tr>
	<tr><td>2011    </td><td>1       </td><td>6       </td><td>4       </td><td>1359    </td><td>1503    </td><td>AA      </td><td>428     </td><td>N262AA  </td><td>64      </td><td>...     </td><td>224     </td><td>6       </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td> -6     </td><td>  6.0   </td></tr>
</tbody>
</table>




```R
# Add the three variables as described in the third instruction: m2
m2 <- mutate(hflights, TotalTaxi = TaxiIn + TaxiOut, ActualGroundTime = ActualElapsedTime - AirTime, Diff = TotalTaxi - ActualGroundTime )
head(m2)
```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th><th scope=col>TotalTaxi</th><th scope=col>ActualGroundTime</th><th scope=col>Diff</th></tr></thead>
<tbody>
	<tr><td>2011    </td><td>1       </td><td>1       </td><td>6       </td><td>1400    </td><td>1500    </td><td>AA      </td><td>428     </td><td>N576AA  </td><td>60      </td><td>...     </td><td>7       </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>20      </td><td>20      </td><td>0       </td></tr>
	<tr><td>2011    </td><td>1       </td><td>2       </td><td>7       </td><td>1401    </td><td>1501    </td><td>AA      </td><td>428     </td><td>N557AA  </td><td>60      </td><td>...     </td><td>6       </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>15      </td><td>15      </td><td>0       </td></tr>
	<tr><td>2011    </td><td>1       </td><td>3       </td><td>1       </td><td>1352    </td><td>1502    </td><td>AA      </td><td>428     </td><td>N541AA  </td><td>70      </td><td>...     </td><td>5       </td><td>17      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>22      </td><td>22      </td><td>0       </td></tr>
	<tr><td>2011    </td><td>1       </td><td>4       </td><td>2       </td><td>1403    </td><td>1513    </td><td>AA      </td><td>428     </td><td>N403AA  </td><td>70      </td><td>...     </td><td>9       </td><td>22      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>31      </td><td>31      </td><td>0       </td></tr>
	<tr><td>2011    </td><td>1       </td><td>5       </td><td>3       </td><td>1405    </td><td>1507    </td><td>AA      </td><td>428     </td><td>N492AA  </td><td>62      </td><td>...     </td><td>9       </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>18      </td><td>18      </td><td>0       </td></tr>
	<tr><td>2011    </td><td>1       </td><td>6       </td><td>4       </td><td>1359    </td><td>1503    </td><td>AA      </td><td>428     </td><td>N262AA  </td><td>64      </td><td>...     </td><td>6       </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td><td>19      </td><td>19      </td><td>0       </td></tr>
</tbody>
</table>




```R
#Logical operators
#R comes with a set of logical operators that you can use inside filter():

#x < y, TRUE if x is less than y
#x <= y, TRUE if x is less than or equal to y
#x == y, TRUE if x equals y
#x != y, TRUE if x does not equal y
#x >= y, TRUE if x is greater than or equal to y
#x > y, TRUE if x is greater than y
#x %in% c(a, b, c), TRUE if x is in the vector c(a, b, c)

# All flights that traveled 3000 miles or more
filter(hflights, Distance > 3000)

```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td> 924       </td><td>1413       </td><td>CO         </td><td> 1         </td><td>N69063     </td><td>529        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td>31         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>30         </td><td>7          </td><td> 925       </td><td>1410       </td><td>CO         </td><td> 1         </td><td>N76064     </td><td>525        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td>13         </td><td>19         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>29         </td><td>6          </td><td>1045       </td><td>1445       </td><td>CO         </td><td> 1         </td><td>N69063     </td><td>480        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 4         </td><td>17         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>28         </td><td>5          </td><td>1516       </td><td>1916       </td><td>CO         </td><td> 1         </td><td>N77066     </td><td>480        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 7         </td><td>10         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>27         </td><td>4          </td><td> 950       </td><td>1344       </td><td>CO         </td><td> 1         </td><td>N76055     </td><td>474        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 4         </td><td>15         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>26         </td><td>3          </td><td> 944       </td><td>1350       </td><td>CO         </td><td> 1         </td><td>N76065     </td><td>486        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>10         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>25         </td><td>2          </td><td> 924       </td><td>1337       </td><td>CO         </td><td> 1         </td><td>N68061     </td><td>493        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>15         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>24         </td><td>1          </td><td>1144       </td><td>1605       </td><td>CO         </td><td> 1         </td><td>N76064     </td><td>501        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 7         </td><td>30         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>23         </td><td>7          </td><td> 926       </td><td>1335       </td><td>CO         </td><td> 1         </td><td>N76065     </td><td>489        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td>17         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>22         </td><td>6          </td><td> 942       </td><td>1340       </td><td>CO         </td><td> 1         </td><td>N69063     </td><td>478        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 3         </td><td>10         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>21         </td><td>5          </td><td> 928       </td><td>1334       </td><td>CO         </td><td> 1         </td><td>N76065     </td><td>486        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td>19         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>20         </td><td>4          </td><td> 938       </td><td>1343       </td><td>CO         </td><td> 1         </td><td>N77066     </td><td>485        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 4         </td><td>12         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>19         </td><td>3          </td><td> 926       </td><td>1341       </td><td>CO         </td><td> 1         </td><td>N76064     </td><td>495        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td>14         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>18         </td><td>2          </td><td> 927       </td><td>1546       </td><td>CO         </td><td> 1         </td><td>N66057     </td><td> NA        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 4         </td><td>17         </td><td>0          </td><td>           </td><td>1          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>17         </td><td>1          </td><td> 924       </td><td>1349       </td><td>CO         </td><td> 1         </td><td>N76065     </td><td>505        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>22         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>16         </td><td>7          </td><td> 922       </td><td>1343       </td><td>CO         </td><td> 1         </td><td>N69063     </td><td>501        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 4         </td><td>16         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>15         </td><td>6          </td><td> 945       </td><td>1355       </td><td>CO         </td><td> 1         </td><td>N77066     </td><td>490        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>13         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>14         </td><td>5          </td><td>1117       </td><td>1506       </td><td>CO         </td><td> 1         </td><td>N67058     </td><td>469        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>12         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>13         </td><td>4          </td><td> 929       </td><td>1348       </td><td>CO         </td><td> 1         </td><td>N76065     </td><td>499        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 4         </td><td>17         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>12         </td><td>3          </td><td> 937       </td><td>1358       </td><td>CO         </td><td> 1         </td><td>N77066     </td><td>501        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td>13         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>11         </td><td>2          </td><td> 926       </td><td>1425       </td><td>CO         </td><td> 1         </td><td>N67052     </td><td>539        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 4         </td><td>38         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>10         </td><td>1          </td><td> 940       </td><td>1413       </td><td>CO         </td><td> 1         </td><td>N76064     </td><td>513        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td>11         </td><td>16         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td> 9         </td><td>7          </td><td> 956       </td><td>1417       </td><td>CO         </td><td> 1         </td><td>N69063     </td><td>501        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>12         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td> 8         </td><td>6          </td><td> 927       </td><td>1403       </td><td>CO         </td><td> 1         </td><td>N76065     </td><td>516        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td>14         </td><td>13         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td> 8         </td><td>6          </td><td>1156       </td><td>1618       </td><td>CO         </td><td>73         </td><td>N69063     </td><td>502        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 4         </td><td>11         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td> 7         </td><td>5          </td><td> 930       </td><td>1355       </td><td>CO         </td><td> 1         </td><td>N76064     </td><td>505        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 7         </td><td>23         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td> 7         </td><td>5          </td><td>1204       </td><td>1619       </td><td>CO         </td><td>73         </td><td>N76065     </td><td>495        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td>18         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td> 6         </td><td>4          </td><td> 932       </td><td>1402       </td><td>CO         </td><td> 1         </td><td>N69063     </td><td>510        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>17         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td> 6         </td><td>4          </td><td>1145       </td><td>1606       </td><td>CO         </td><td>73         </td><td>N76064     </td><td>501        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 4         </td><td>16         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td> 5         </td><td>3          </td><td> 929       </td><td>1406       </td><td>CO         </td><td> 1         </td><td>N77066     </td><td>517        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>19         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>   </td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>2011       </td><td>12         </td><td>30         </td><td>5          </td><td> 936       </td><td>1413       </td><td>CO         </td><td>1          </td><td>N69063     </td><td>517        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 4         </td><td>14         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>29         </td><td>4          </td><td> 940       </td><td>1357       </td><td>CO         </td><td>1          </td><td>N77066     </td><td>497        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td>11         </td><td>18         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>28         </td><td>3          </td><td> 933       </td><td>1329       </td><td>CO         </td><td>1          </td><td>N76064     </td><td>476        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>10         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>27         </td><td>2          </td><td> 935       </td><td>1405       </td><td>CO         </td><td>1          </td><td>N76065     </td><td>510        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td>16         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>26         </td><td>1          </td><td> 940       </td><td>1407       </td><td>CO         </td><td>1          </td><td>N77066     </td><td>507        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 8         </td><td>23         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>25         </td><td>7          </td><td>1406       </td><td>1757       </td><td>CO         </td><td>1          </td><td>N69063     </td><td>471        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 7         </td><td> 9         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>24         </td><td>6          </td><td> 937       </td><td>1410       </td><td>CO         </td><td>1          </td><td>N69063     </td><td>513        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td>18         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>23         </td><td>5          </td><td> 941       </td><td>1422       </td><td>CO         </td><td>1          </td><td>N69063     </td><td>521        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td>28         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>22         </td><td>4          </td><td>1004       </td><td>1429       </td><td>CO         </td><td>1          </td><td>N76065     </td><td>505        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 9         </td><td>15         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>21         </td><td>3          </td><td> 946       </td><td>1422       </td><td>CO         </td><td>1          </td><td>N77066     </td><td>516        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 7         </td><td>12         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>20         </td><td>2          </td><td> 940       </td><td>1407       </td><td>CO         </td><td>1          </td><td>N59053     </td><td>507        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>20         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>19         </td><td>1          </td><td> 938       </td><td>1411       </td><td>CO         </td><td>1          </td><td>N59053     </td><td>513        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>12         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>18         </td><td>7          </td><td> 931       </td><td>1459       </td><td>CO         </td><td>1          </td><td>N67058     </td><td>568        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td>21         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>17         </td><td>6          </td><td> 938       </td><td>1355       </td><td>CO         </td><td>1          </td><td>N69059     </td><td>497        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td>10         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>16         </td><td>5          </td><td> 932       </td><td>1402       </td><td>CO         </td><td>1          </td><td>N66051     </td><td>510        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td>33         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>15         </td><td>4          </td><td> 934       </td><td>1402       </td><td>CO         </td><td>1          </td><td>N66051     </td><td>508        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>19         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>14         </td><td>3          </td><td> 935       </td><td>1358       </td><td>CO         </td><td>1          </td><td>N67058     </td><td>503        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>13         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>13         </td><td>2          </td><td> 934       </td><td>1418       </td><td>CO         </td><td>1          </td><td>N66056     </td><td>524        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 8         </td><td>18         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>12         </td><td>1          </td><td> 933       </td><td>1413       </td><td>CO         </td><td>1          </td><td>N68061     </td><td>520        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td>14         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>11         </td><td>7          </td><td>1036       </td><td>1459       </td><td>CO         </td><td>1          </td><td>N67052     </td><td>503        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td> 9         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>10         </td><td>6          </td><td> 936       </td><td>1355       </td><td>CO         </td><td>1          </td><td>N67058     </td><td>499        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td> 9         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td> 9         </td><td>5          </td><td> 955       </td><td>1447       </td><td>CO         </td><td>1          </td><td>N59053     </td><td>532        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 8         </td><td>12         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td> 8         </td><td>4          </td><td> 935       </td><td>1410       </td><td>CO         </td><td>1          </td><td>N66051     </td><td>515        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>15         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td> 7         </td><td>3          </td><td> 936       </td><td>1408       </td><td>CO         </td><td>1          </td><td>N66051     </td><td>512        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>14         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td> 6         </td><td>2          </td><td> 940       </td><td>1412       </td><td>CO         </td><td>1          </td><td>N68061     </td><td>512        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 5         </td><td>27         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td> 5         </td><td>1          </td><td> 935       </td><td>1410       </td><td>CO         </td><td>1          </td><td>N59053     </td><td>515        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 7         </td><td>18         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td> 4         </td><td>7          </td><td> 934       </td><td>1406       </td><td>CO         </td><td>1          </td><td>N76062     </td><td>512        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 6         </td><td> 9         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td> 3         </td><td>6          </td><td> 935       </td><td>1408       </td><td>CO         </td><td>1          </td><td>N76055     </td><td>513        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 4         </td><td>16         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td> 2         </td><td>5          </td><td> 937       </td><td>1415       </td><td>CO         </td><td>1          </td><td>N69059     </td><td>518        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 7         </td><td>23         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td> 1         </td><td>4          </td><td> 936       </td><td>1431       </td><td>CO         </td><td>1          </td><td>N67058     </td><td>535        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 3         </td><td>14         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
</tbody>
</table>




```R
# All flights flown by one of JetBlue, Southwest, or Delta
filter(hflights, UniqueCarrier %in% c("JetBlue", "Southwest", "Delta"))
```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
</tbody>
</table>




```R
# All flights where taxiing took longer than flying
filter(hflights, AirTime < TaxiIn + TaxiOut )
```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
	<tr><td>2011       </td><td>1          </td><td>24         </td><td>1          </td><td> 731       </td><td> 904       </td><td>AA         </td><td> 460       </td><td>N545AA     </td><td>93         </td><td>...        </td><td>IAH        </td><td>DFW        </td><td>224        </td><td>14         </td><td>37         </td><td>0          </td><td>           </td><td>0          </td><td>American   </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>30         </td><td>7          </td><td>1959       </td><td>2132       </td><td>AA         </td><td> 533       </td><td>N455AA     </td><td>93         </td><td>...        </td><td>IAH        </td><td>DFW        </td><td>224        </td><td>10         </td><td>40         </td><td>0          </td><td>           </td><td>0          </td><td>American   </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>24         </td><td>1          </td><td>1621       </td><td>1749       </td><td>AA         </td><td>1121       </td><td>N484AA     </td><td>88         </td><td>...        </td><td>IAH        </td><td>DFW        </td><td>224        </td><td>10         </td><td>35         </td><td>0          </td><td>           </td><td>0          </td><td>American   </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>10         </td><td>1          </td><td> 941       </td><td>1113       </td><td>AA         </td><td>1436       </td><td>N591AA     </td><td>92         </td><td>...        </td><td>IAH        </td><td>DFW        </td><td>224        </td><td>27         </td><td>20         </td><td>0          </td><td>           </td><td>0          </td><td>American   </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1301       </td><td>1356       </td><td>CO         </td><td> 241       </td><td>N14629     </td><td>55         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 5         </td><td>23         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>2113       </td><td>2215       </td><td>CO         </td><td>1533       </td><td>N72405     </td><td>62         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 7         </td><td>25         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1434       </td><td>1539       </td><td>CO         </td><td>1541       </td><td>N16646     </td><td>65         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 5         </td><td>30         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td> 900       </td><td>1006       </td><td>CO         </td><td>1583       </td><td>N36207     </td><td>66         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 5         </td><td>29         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>30         </td><td>7          </td><td>1304       </td><td>1408       </td><td>CO         </td><td> 241       </td><td>N14645     </td><td>64         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 6         </td><td>27         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>30         </td><td>7          </td><td>2004       </td><td>2128       </td><td>CO         </td><td> 423       </td><td>N16632     </td><td>84         </td><td>...        </td><td>IAH        </td><td>MSY        </td><td>305        </td><td>10         </td><td>34         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>30         </td><td>7          </td><td>1912       </td><td>2032       </td><td>CO         </td><td> 479       </td><td>N73276     </td><td>80         </td><td>...        </td><td>IAH        </td><td>SAT        </td><td>191        </td><td> 6         </td><td>37         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>30         </td><td>7          </td><td>1141       </td><td>1251       </td><td>CO         </td><td> 741       </td><td>N76523     </td><td>70         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 4         </td><td>36         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>30         </td><td>7          </td><td>1922       </td><td>2032       </td><td>CO         </td><td>1411       </td><td>N38268     </td><td>70         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 6         </td><td>34         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>30         </td><td>7          </td><td>1813       </td><td>1914       </td><td>CO         </td><td>1558       </td><td>N77295     </td><td>61         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 6         </td><td>25         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>30         </td><td>7          </td><td>1038       </td><td>1214       </td><td>CO         </td><td>1823       </td><td>N14653     </td><td>96         </td><td>...        </td><td>IAH        </td><td>MSY        </td><td>305        </td><td> 3         </td><td>49         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>26         </td><td>3          </td><td>1533       </td><td>1629       </td><td>CO         </td><td>  35       </td><td>N19638     </td><td>56         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td>12         </td><td>17         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>26         </td><td>3          </td><td>1910       </td><td>2012       </td><td>CO         </td><td>1411       </td><td>N33266     </td><td>62         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 8         </td><td>25         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>25         </td><td>2          </td><td>1259       </td><td>1401       </td><td>CO         </td><td> 241       </td><td>N32626     </td><td>62         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 6         </td><td>27         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>25         </td><td>2          </td><td>2101       </td><td>2158       </td><td>CO         </td><td>1533       </td><td>N32404     </td><td>57         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 7         </td><td>22         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>25         </td><td>2          </td><td>1427       </td><td>1530       </td><td>CO         </td><td>1541       </td><td>N16617     </td><td>63         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 5         </td><td>29         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>24         </td><td>1          </td><td>1322       </td><td>1428       </td><td>CO         </td><td> 241       </td><td>N24633     </td><td>66         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 5         </td><td>33         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>24         </td><td>1          </td><td>1153       </td><td>1253       </td><td>CO         </td><td> 741       </td><td>N36207     </td><td>60         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 5         </td><td>26         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>24         </td><td>1          </td><td>1939       </td><td>2059       </td><td>CO         </td><td>1411       </td><td>N73275     </td><td>80         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 6         </td><td>46         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>24         </td><td>1          </td><td>1429       </td><td>1531       </td><td>CO         </td><td>1541       </td><td>N32626     </td><td>62         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 7         </td><td>27         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>24         </td><td>1          </td><td> 930       </td><td>1044       </td><td>CO         </td><td>1583       </td><td>N53441     </td><td>74         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 8         </td><td>38         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>23         </td><td>7          </td><td>1301       </td><td>1409       </td><td>CO         </td><td> 241       </td><td>N46625     </td><td>68         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 8         </td><td>30         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>23         </td><td>7          </td><td>1551       </td><td>1725       </td><td>CO         </td><td>1787       </td><td>N59630     </td><td>94         </td><td>...        </td><td>IAH        </td><td>DFW        </td><td>224        </td><td> 9         </td><td>43         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>22         </td><td>6          </td><td> 854       </td><td> 958       </td><td>CO         </td><td>1583       </td><td>N14242     </td><td>64         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 5         </td><td>30         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>21         </td><td>5          </td><td>1301       </td><td>1402       </td><td>CO         </td><td> 241       </td><td>N14639     </td><td>61         </td><td>...        </td><td>IAH        </td><td>AUS        </td><td>140        </td><td> 7         </td><td>26         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>20         </td><td>4          </td><td>1835       </td><td>2007       </td><td>CO         </td><td>   5       </td><td>N24212     </td><td>92         </td><td>...        </td><td>IAH        </td><td>MSY        </td><td>305        </td><td> 4         </td><td>44         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>   </td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>2011      </td><td>12        </td><td>23        </td><td>5         </td><td> 915      </td><td>1112      </td><td>XE        </td><td>4356      </td><td>N14938    </td><td>117       </td><td>...       </td><td>IAH       </td><td>LRD       </td><td>301       </td><td> 2        </td><td> 58       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>13        </td><td>2         </td><td>1907      </td><td>2011      </td><td>XE        </td><td>4403      </td><td>N13929    </td><td> 64       </td><td>...       </td><td>IAH       </td><td>LCH       </td><td>127       </td><td> 6        </td><td> 29       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>14        </td><td>3         </td><td>1911      </td><td>2012      </td><td>XE        </td><td>4403      </td><td>N14938    </td><td> 61       </td><td>...       </td><td>IAH       </td><td>LCH       </td><td>127       </td><td> 5        </td><td> 29       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 4        </td><td>7         </td><td>1914      </td><td>2004      </td><td>XE        </td><td>4403      </td><td>N12934    </td><td> 50       </td><td>...       </td><td>IAH       </td><td>LCH       </td><td>127       </td><td> 6        </td><td> 20       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 5        </td><td>1         </td><td>2001      </td><td>2113      </td><td>XE        </td><td>4403      </td><td>N14933    </td><td> 72       </td><td>...       </td><td>IAH       </td><td>LCH       </td><td>127       </td><td> 5        </td><td> 33       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 6        </td><td>2         </td><td>1903      </td><td>2006      </td><td>XE        </td><td>4403      </td><td>N15926    </td><td> 63       </td><td>...       </td><td>IAH       </td><td>LCH       </td><td>127       </td><td> 5        </td><td> 28       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 5        </td><td>1         </td><td>1923      </td><td>2100      </td><td>XE        </td><td>4466      </td><td>N14945    </td><td> 97       </td><td>...       </td><td>IAH       </td><td>CRP       </td><td>201       </td><td> 4        </td><td> 45       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>16        </td><td>5         </td><td>1158      </td><td>1320      </td><td>XE        </td><td>4508      </td><td>N14925    </td><td> 82       </td><td>...       </td><td>IAH       </td><td>AUS       </td><td>140       </td><td> 7        </td><td> 42       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>29        </td><td>4         </td><td>1159      </td><td>1300      </td><td>XE        </td><td>4508      </td><td>N13133    </td><td> 61       </td><td>...       </td><td>IAH       </td><td>AUS       </td><td>140       </td><td>10        </td><td> 21       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>16        </td><td>5         </td><td>1159      </td><td>1339      </td><td>XE        </td><td>4518      </td><td>N14945    </td><td>100       </td><td>...       </td><td>IAH       </td><td>CRP       </td><td>201       </td><td> 7        </td><td> 48       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>16        </td><td>5         </td><td>1955      </td><td>2116      </td><td>XE        </td><td>4522      </td><td>N14945    </td><td> 81       </td><td>...       </td><td>IAH       </td><td>SHV       </td><td>192       </td><td> 8        </td><td> 38       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>19        </td><td>1         </td><td>1850      </td><td>2003      </td><td>XE        </td><td>4522      </td><td>N14930    </td><td> 73       </td><td>...       </td><td>IAH       </td><td>SHV       </td><td>192       </td><td> 6        </td><td> 35       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>21        </td><td>3         </td><td>1928      </td><td>2037      </td><td>XE        </td><td>4522      </td><td>N12996    </td><td> 69       </td><td>...       </td><td>IAH       </td><td>SHV       </td><td>192       </td><td> 7        </td><td> 29       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>13        </td><td>2         </td><td>2322      </td><td>  38      </td><td>XE        </td><td>4551      </td><td>N16147    </td><td> 76       </td><td>...       </td><td>IAH       </td><td>SHV       </td><td>192       </td><td> 8        </td><td> 34       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 5        </td><td>1         </td><td>2127      </td><td>2230      </td><td>XE        </td><td>4551      </td><td>N15910    </td><td> 63       </td><td>...       </td><td>IAH       </td><td>SHV       </td><td>192       </td><td>11        </td><td> 21       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 5        </td><td>1         </td><td>1928      </td><td>2057      </td><td>XE        </td><td>4555      </td><td>N14940    </td><td> 89       </td><td>...       </td><td>IAH       </td><td>MLU       </td><td>262       </td><td> 5        </td><td> 47       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 5        </td><td>1         </td><td> 945      </td><td>1111      </td><td>XE        </td><td>4557      </td><td>N14930    </td><td> 86       </td><td>...       </td><td>IAH       </td><td>CRP       </td><td>201       </td><td> 3        </td><td> 41       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>15        </td><td>4         </td><td> 858      </td><td>1026      </td><td>XE        </td><td>4581      </td><td>N14938    </td><td> 88       </td><td>...       </td><td>IAH       </td><td>SAT       </td><td>191       </td><td> 3        </td><td> 48       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 4        </td><td>7         </td><td>1931      </td><td>2111      </td><td>XE        </td><td>4587      </td><td>N12567    </td><td>100       </td><td>...       </td><td>IAH       </td><td>DFW       </td><td>224       </td><td> 9        </td><td> 49       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 5        </td><td>1         </td><td>1921      </td><td>2057      </td><td>XE        </td><td>4587      </td><td>N14937    </td><td> 96       </td><td>...       </td><td>IAH       </td><td>DFW       </td><td>224       </td><td> 6        </td><td> 49       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>14        </td><td>3         </td><td> 901      </td><td>1029      </td><td>XE        </td><td>4683      </td><td>N14937    </td><td> 88       </td><td>...       </td><td>IAH       </td><td>BTR       </td><td>253       </td><td>28        </td><td> 20       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 5        </td><td>1         </td><td>1157      </td><td>1320      </td><td>XE        </td><td>4683      </td><td>N16927    </td><td> 83       </td><td>...       </td><td>IAH       </td><td>BTR       </td><td>253       </td><td> 6        </td><td> 39       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 6        </td><td>2         </td><td> 900      </td><td>1038      </td><td>XE        </td><td>4683      </td><td>N16963    </td><td> 98       </td><td>...       </td><td>IAH       </td><td>BTR       </td><td>253       </td><td>34        </td><td> 20       </td><td>0         </td><td>          </td><td>0         </td><td>ExpressJet</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>14        </td><td>3         </td><td>1727      </td><td>2017      </td><td>OO        </td><td>5156      </td><td>N771SK    </td><td>170       </td><td>...       </td><td>IAH       </td><td>DFW       </td><td>224       </td><td> 6        </td><td>120       </td><td>0         </td><td>          </td><td>0         </td><td>SkyWest   </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>29        </td><td>4         </td><td> 749      </td><td> 930      </td><td>OO        </td><td>5239      </td><td>N652BR    </td><td>101       </td><td>...       </td><td>IAH       </td><td>DAL       </td><td>216       </td><td> 3        </td><td> 57       </td><td>0         </td><td>          </td><td>0         </td><td>SkyWest   </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>24        </td><td>6         </td><td>1737      </td><td>1853      </td><td>OO        </td><td>5240      </td><td>N413SW    </td><td> 76       </td><td>...       </td><td>IAH       </td><td>DAL       </td><td>216       </td><td> 5        </td><td> 34       </td><td>0         </td><td>          </td><td>0         </td><td>SkyWest   </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>20        </td><td>2         </td><td>1931      </td><td>2044      </td><td>OO        </td><td>5241      </td><td>N468CA    </td><td> 73       </td><td>...       </td><td>IAH       </td><td>DAL       </td><td>216       </td><td> 4        </td><td> 33       </td><td>0         </td><td>          </td><td>0         </td><td>SkyWest   </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>16        </td><td>5         </td><td>1948      </td><td>2123      </td><td>OO        </td><td>5241      </td><td>N494CA    </td><td> 95       </td><td>...       </td><td>IAH       </td><td>DAL       </td><td>216       </td><td> 5        </td><td> 51       </td><td>0         </td><td>          </td><td>0         </td><td>SkyWest   </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>16        </td><td>5         </td><td>1111      </td><td>1230      </td><td>OO        </td><td>5237      </td><td>N939SW    </td><td> 79       </td><td>...       </td><td>IAH       </td><td>DAL       </td><td>216       </td><td> 4        </td><td> 37       </td><td>0         </td><td>          </td><td>0         </td><td>SkyWest   </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>23        </td><td>5         </td><td> 714      </td><td> 844      </td><td>OO        </td><td>5172      </td><td>N743SK    </td><td> 90       </td><td>...       </td><td>IAH       </td><td>DFW       </td><td>224       </td><td> 4        </td><td> 42       </td><td>0         </td><td>          </td><td>0         </td><td>SkyWest   </td><td>NA        </td></tr>
</tbody>
</table>




```R
# All flights that departed before 5am or arrived after 10pm
filter(hflights, DepTime < 500 | ArrTime > 2200)
```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
	<tr><td>2011       </td><td>1          </td><td> 4         </td><td>2          </td><td>2100       </td><td>2207       </td><td>AA         </td><td> 533       </td><td>N4XGAA     </td><td> 67        </td><td>...        </td><td>IAH        </td><td>DFW        </td><td> 224       </td><td> 3         </td><td>22         </td><td>0          </td><td>           </td><td>0          </td><td>American   </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>14         </td><td>5          </td><td>2119       </td><td>2229       </td><td>AA         </td><td> 533       </td><td>N549AA     </td><td> 70        </td><td>...        </td><td>IAH        </td><td>DFW        </td><td> 224       </td><td> 5         </td><td>20         </td><td>0          </td><td>           </td><td>0          </td><td>American   </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>10         </td><td>1          </td><td>1934       </td><td>2235       </td><td>AA         </td><td>1294       </td><td>N3BXAA     </td><td>121        </td><td>...        </td><td>IAH        </td><td>MIA        </td><td> 964       </td><td> 3         </td><td>11         </td><td>0          </td><td>           </td><td>0          </td><td>American   </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>26         </td><td>3          </td><td>1905       </td><td>2211       </td><td>AA         </td><td>1294       </td><td>N3BXAA     </td><td>126        </td><td>...        </td><td>IAH        </td><td>MIA        </td><td> 964       </td><td> 5         </td><td>10         </td><td>0          </td><td>           </td><td>0          </td><td>American   </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>30         </td><td>7          </td><td>1856       </td><td>2209       </td><td>AA         </td><td>1294       </td><td>N3CPAA     </td><td>133        </td><td>...        </td><td>IAH        </td><td>MIA        </td><td> 964       </td><td> 7         </td><td>18         </td><td>0          </td><td>           </td><td>0          </td><td>American   </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td> 9         </td><td>7          </td><td>1938       </td><td>2228       </td><td>AS         </td><td> 731       </td><td>N609AS     </td><td>290        </td><td>...        </td><td>IAH        </td><td>SEA        </td><td>1874       </td><td> 5         </td><td>32         </td><td>0          </td><td>           </td><td>0          </td><td>Alaska     </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1919       </td><td>2231       </td><td>CO         </td><td> 190       </td><td>N35260     </td><td>132        </td><td>...        </td><td>IAH        </td><td>MIA        </td><td> 964       </td><td> 5         </td><td>20         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>2116       </td><td>2344       </td><td>CO         </td><td> 209       </td><td>N24715     </td><td>268        </td><td>...        </td><td>IAH        </td><td>PDX        </td><td>1825       </td><td> 4         </td><td> 8         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1850       </td><td>2211       </td><td>CO         </td><td> 250       </td><td>N59630     </td><td>141        </td><td>...        </td><td>IAH        </td><td>RDU        </td><td>1043       </td><td> 5         </td><td>15         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>2102       </td><td>2216       </td><td>CO         </td><td> 299       </td><td>N17244     </td><td>134        </td><td>...        </td><td>IAH        </td><td>DEN        </td><td> 862       </td><td> 6         </td><td> 9         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1909       </td><td>2254       </td><td>CO         </td><td> 426       </td><td>N78506     </td><td>165        </td><td>...        </td><td>IAH        </td><td>BWI        </td><td>1235       </td><td> 4         </td><td>18         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1925       </td><td>2202       </td><td>CO         </td><td> 444       </td><td>N76514     </td><td>157        </td><td>...        </td><td>IAH        </td><td>ORD        </td><td> 925       </td><td>18         </td><td>22         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>2056       </td><td>2217       </td><td>CO         </td><td> 511       </td><td>N77520     </td><td> 81        </td><td>...        </td><td>IAH        </td><td>MFE        </td><td> 316       </td><td> 4         </td><td>17         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1901       </td><td>2332       </td><td>CO         </td><td> 582       </td><td>N19621     </td><td>211        </td><td>...        </td><td>IAH        </td><td>BOS        </td><td>1597       </td><td> 7         </td><td>16         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>2102       </td><td>2222       </td><td>CO         </td><td> 597       </td><td>N33203     </td><td>200        </td><td>...        </td><td>IAH        </td><td>LAS        </td><td>1222       </td><td> 9         </td><td>12         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1930       </td><td>2225       </td><td>CO         </td><td> 616       </td><td>N33294     </td><td>175        </td><td>...        </td><td>IAH        </td><td>MSP        </td><td>1034       </td><td>11         </td><td>25         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1917       </td><td>2234       </td><td>CO         </td><td> 644       </td><td>N37267     </td><td>137        </td><td>...        </td><td>IAH        </td><td>CLE        </td><td>1091       </td><td> 5         </td><td>16         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1915       </td><td>2248       </td><td>CO         </td><td> 658       </td><td>N37273     </td><td>153        </td><td>...        </td><td>IAH        </td><td>DCA        </td><td>1208       </td><td> 9         </td><td>16         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1940       </td><td>2349       </td><td>CO         </td><td> 732       </td><td>N33262     </td><td>189        </td><td>...        </td><td>IAH        </td><td>LGA        </td><td>1416       </td><td> 5         </td><td>27         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1930       </td><td>2224       </td><td>CO         </td><td> 755       </td><td>N11641     </td><td>114        </td><td>...        </td><td>IAH        </td><td>ATL        </td><td> 689       </td><td> 9         </td><td>16         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>2143       </td><td>2338       </td><td>CO         </td><td> 770       </td><td>N37281     </td><td>235        </td><td>...        </td><td>IAH        </td><td>SFO        </td><td>1635       </td><td> 5         </td><td> 6         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>2105       </td><td>2311       </td><td>CO         </td><td> 820       </td><td>N37255     </td><td>186        </td><td>...        </td><td>IAH        </td><td>PHX        </td><td>1009       </td><td> 6         </td><td>22         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1805       </td><td>2211       </td><td>CO         </td><td>1010       </td><td>N73259     </td><td>186        </td><td>...        </td><td>IAH        </td><td>EWR        </td><td>1400       </td><td> 9         </td><td>16         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>2120       </td><td>2323       </td><td>CO         </td><td>1046       </td><td>N79402     </td><td>123        </td><td>...        </td><td>IAH        </td><td>ORD        </td><td> 925       </td><td> 7         </td><td>10         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>2107       </td><td>2247       </td><td>CO         </td><td>1095       </td><td>N73270     </td><td>220        </td><td>...        </td><td>IAH        </td><td>LAX        </td><td>1379       </td><td> 7         </td><td>12         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1903       </td><td>2228       </td><td>CO         </td><td>1417       </td><td>N46625     </td><td>145        </td><td>...        </td><td>IAH        </td><td>PIT        </td><td>1117       </td><td> 6         </td><td>13         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>2101       </td><td>2215       </td><td>CO         </td><td>1423       </td><td>N62631     </td><td> 74        </td><td>...        </td><td>IAH        </td><td>MSY        </td><td> 305       </td><td> 6         </td><td>26         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>2053       </td><td>2235       </td><td>CO         </td><td>1459       </td><td>N87513     </td><td>222        </td><td>...        </td><td>IAH        </td><td>SNA        </td><td>1347       </td><td> 8         </td><td>13         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>1918       </td><td>2247       </td><td>CO         </td><td>1488       </td><td>N16701     </td><td>149        </td><td>...        </td><td>IAH        </td><td>DTW        </td><td>1076       </td><td> 6         </td><td>22         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>1          </td><td>31         </td><td>1          </td><td>2113       </td><td>2215       </td><td>CO         </td><td>1533       </td><td>N72405     </td><td> 62        </td><td>...        </td><td>IAH        </td><td>AUS        </td><td> 140       </td><td> 7         </td><td>25         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>   </td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>2011      </td><td>12        </td><td>27        </td><td>2         </td><td>1912      </td><td>2314      </td><td>US        </td><td>1828      </td><td>N945UW    </td><td>182       </td><td>...       </td><td>IAH       </td><td>PHL       </td><td>1325      </td><td> 5        </td><td>12        </td><td>0         </td><td>          </td><td>0         </td><td>US_Airways</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>28        </td><td>3         </td><td>2053      </td><td>2229      </td><td>US        </td><td> 278      </td><td>N640AW    </td><td>156       </td><td>...       </td><td>IAH       </td><td>PHX       </td><td>1009      </td><td>11        </td><td>14        </td><td>0         </td><td>          </td><td>0         </td><td>US_Airways</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>29        </td><td>4         </td><td>2056      </td><td>2226      </td><td>US        </td><td> 278      </td><td>N649AW    </td><td>150       </td><td>...       </td><td>IAH       </td><td>PHX       </td><td>1009      </td><td> 6        </td><td>10        </td><td>0         </td><td>          </td><td>0         </td><td>US_Airways</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>30        </td><td>5         </td><td>2056      </td><td>2318      </td><td>US        </td><td> 278      </td><td>N676AW    </td><td>202       </td><td>...       </td><td>IAH       </td><td>PHX       </td><td>1009      </td><td>11        </td><td>54        </td><td>0         </td><td>          </td><td>0         </td><td>US_Airways</td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 1        </td><td>4         </td><td>2058      </td><td>2225      </td><td>WN        </td><td>1288      </td><td>N520SW    </td><td> 87       </td><td>...       </td><td>HOU       </td><td>BHM       </td><td> 570      </td><td> 2        </td><td>11        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 1        </td><td>4         </td><td>1835      </td><td>2214      </td><td>WN        </td><td> 757      </td><td>N218WN    </td><td>159       </td><td>...       </td><td>HOU       </td><td>BWI       </td><td>1246      </td><td> 2        </td><td> 5        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 1        </td><td>4         </td><td>1946      </td><td>2349      </td><td>WN        </td><td> 112      </td><td>N791SW    </td><td>183       </td><td>...       </td><td>HOU       </td><td>EWR       </td><td>1411      </td><td> 8        </td><td> 6        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 1        </td><td>4         </td><td>1925      </td><td>2231      </td><td>WN        </td><td>  45      </td><td>N621SW    </td><td>126       </td><td>...       </td><td>HOU       </td><td>FLL       </td><td> 957      </td><td> 4        </td><td> 7        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 1        </td><td>4         </td><td>2108      </td><td>2215      </td><td>WN        </td><td>1949      </td><td>N924WN    </td><td> 67       </td><td>...       </td><td>HOU       </td><td>JAN       </td><td> 359      </td><td> 7        </td><td> 7        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 1        </td><td>4         </td><td>2034      </td><td>2241      </td><td>WN        </td><td>1568      </td><td>N942WN    </td><td>127       </td><td>...       </td><td>HOU       </td><td>MDW       </td><td> 937      </td><td> 7        </td><td> 6        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 1        </td><td>4         </td><td>2054      </td><td>2338      </td><td>WN        </td><td>1674      </td><td>N413WN    </td><td>104       </td><td>...       </td><td>HOU       </td><td>TPA       </td><td> 781      </td><td> 3        </td><td> 8        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 2        </td><td>5         </td><td>2050      </td><td>2212      </td><td>WN        </td><td>1288      </td><td>N506SW    </td><td> 82       </td><td>...       </td><td>HOU       </td><td>BHM       </td><td> 570      </td><td> 2        </td><td> 7        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 2        </td><td>5         </td><td>1900      </td><td>2242      </td><td>WN        </td><td> 757      </td><td>N272WN    </td><td>162       </td><td>...       </td><td>HOU       </td><td>BWI       </td><td>1246      </td><td> 3        </td><td>11        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 2        </td><td>5         </td><td>1925      </td><td>2334      </td><td>WN        </td><td> 112      </td><td>N786SW    </td><td>189       </td><td>...       </td><td>HOU       </td><td>EWR       </td><td>1411      </td><td> 9        </td><td>10        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 2        </td><td>5         </td><td>1923      </td><td>2229      </td><td>WN        </td><td>  45      </td><td>N485WN    </td><td>126       </td><td>...       </td><td>HOU       </td><td>FLL       </td><td> 957      </td><td> 4        </td><td> 8        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 2        </td><td>5         </td><td>2107      </td><td>2206      </td><td>WN        </td><td>1949      </td><td>N235WN    </td><td> 59       </td><td>...       </td><td>HOU       </td><td>JAN       </td><td> 359      </td><td> 4        </td><td> 7        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 2        </td><td>5         </td><td>2023      </td><td>2306      </td><td>WN        </td><td>1191      </td><td>N211WN    </td><td>103       </td><td>...       </td><td>HOU       </td><td>TPA       </td><td> 781      </td><td> 4        </td><td> 7        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 2        </td><td>5         </td><td>2052      </td><td>2344      </td><td>WN        </td><td>1674      </td><td>N602SW    </td><td>112       </td><td>...       </td><td>HOU       </td><td>TPA       </td><td> 781      </td><td> 5        </td><td> 7        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 3        </td><td>6         </td><td>1940      </td><td>2239      </td><td>WN        </td><td>2081      </td><td>N623SW    </td><td>119       </td><td>...       </td><td>HOU       </td><td>MCO       </td><td> 849      </td><td> 4        </td><td> 7        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 3        </td><td>6         </td><td>1940      </td><td>2229      </td><td>WN        </td><td>2170      </td><td>N480WN    </td><td>109       </td><td>...       </td><td>HOU       </td><td>TPA       </td><td> 781      </td><td> 4        </td><td> 8        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 4        </td><td>7         </td><td>1830      </td><td>2207      </td><td>WN        </td><td>2923      </td><td>N476WN    </td><td>157       </td><td>...       </td><td>HOU       </td><td>BWI       </td><td>1246      </td><td> 4        </td><td> 8        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 4        </td><td>7         </td><td>1915      </td><td>2222      </td><td>WN        </td><td>3079      </td><td>N424WN    </td><td>127       </td><td>...       </td><td>HOU       </td><td>FLL       </td><td> 957      </td><td> 4        </td><td> 8        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 4        </td><td>7         </td><td>2040      </td><td>2322      </td><td>WN        </td><td>3619      </td><td>N440LV    </td><td>102       </td><td>...       </td><td>HOU       </td><td>TPA       </td><td> 781      </td><td> 4        </td><td> 9        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 5        </td><td>1         </td><td>1908      </td><td>2220      </td><td>WN        </td><td>  45      </td><td>N788SA    </td><td>132       </td><td>...       </td><td>HOU       </td><td>FLL       </td><td> 957      </td><td> 4        </td><td>14        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 5        </td><td>1         </td><td>2043      </td><td>2329      </td><td>WN        </td><td>1674      </td><td>N397SW    </td><td>106       </td><td>...       </td><td>HOU       </td><td>TPA       </td><td> 781      </td><td> 2        </td><td>11        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 6        </td><td>2         </td><td>2139      </td><td>2256      </td><td>WN        </td><td>1288      </td><td>N660SW    </td><td> 77       </td><td>...       </td><td>HOU       </td><td>BHM       </td><td> 570      </td><td> 4        </td><td> 6        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 6        </td><td>2         </td><td>1849      </td><td>2217      </td><td>WN        </td><td> 757      </td><td>N220WN    </td><td>148       </td><td>...       </td><td>HOU       </td><td>BWI       </td><td>1246      </td><td> 4        </td><td>10        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 6        </td><td>2         </td><td>1939      </td><td>2347      </td><td>WN        </td><td> 112      </td><td>N218WN    </td><td>188       </td><td>...       </td><td>HOU       </td><td>EWR       </td><td>1411      </td><td> 7        </td><td>13        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 6        </td><td>2         </td><td>1910      </td><td>2217      </td><td>WN        </td><td>  45      </td><td>N253WN    </td><td>127       </td><td>...       </td><td>HOU       </td><td>FLL       </td><td> 957      </td><td> 3        </td><td> 8        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 6        </td><td>2         </td><td>2047      </td><td>2334      </td><td>WN        </td><td>1674      </td><td>N366SW    </td><td>107       </td><td>...       </td><td>HOU       </td><td>TPA       </td><td> 781      </td><td> 4        </td><td> 9        </td><td>0         </td><td>          </td><td>0         </td><td>Southwest </td><td>NA        </td></tr>
</tbody>
</table>




```R
# All flights that departed late but arrived ahead of schedule
filter(hflights, DepDelay > 0 & ArrDelay < 0)

```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
	<tr><td>2011    </td><td>1       </td><td> 2      </td><td>7       </td><td>1401    </td><td>1501    </td><td>AA      </td><td> 428    </td><td>N557AA  </td><td> 60     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 6      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td> 5      </td><td>3       </td><td>1405    </td><td>1507    </td><td>AA      </td><td> 428    </td><td>N492AA  </td><td> 62     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 9      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>18      </td><td>2       </td><td>1408    </td><td>1508    </td><td>AA      </td><td> 428    </td><td>N507AA  </td><td> 60     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 7      </td><td>11      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>18      </td><td>2       </td><td> 721    </td><td> 827    </td><td>AA      </td><td> 460    </td><td>N558AA  </td><td> 66     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 7      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>12      </td><td>3       </td><td>2015    </td><td>2113    </td><td>AA      </td><td> 533    </td><td>N555AA  </td><td> 58     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 9      </td><td>10      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>13      </td><td>4       </td><td>2020    </td><td>2116    </td><td>AA      </td><td> 533    </td><td>N4XCAA  </td><td> 56     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 4      </td><td> 8      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>26      </td><td>3       </td><td>2009    </td><td>2103    </td><td>AA      </td><td> 533    </td><td>N403AA  </td><td> 54     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 9      </td><td> 6      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td> 1      </td><td>6       </td><td>1631    </td><td>1736    </td><td>AA      </td><td>1121    </td><td>N4WVAA  </td><td> 65     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td>16      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>10      </td><td>1       </td><td>1639    </td><td>1740    </td><td>AA      </td><td>1121    </td><td>N531AA  </td><td> 61     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 8      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>12      </td><td>3       </td><td>1631    </td><td>1739    </td><td>AA      </td><td>1121    </td><td>N468AA  </td><td> 68     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 5      </td><td>19      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>15      </td><td>6       </td><td>1632    </td><td>1736    </td><td>AA      </td><td>1121    </td><td>N274AA  </td><td> 64     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 5      </td><td>11      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>17      </td><td>1       </td><td>1632    </td><td>1744    </td><td>AA      </td><td>1121    </td><td>N580AA  </td><td> 72     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td>10      </td><td>11      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>27      </td><td>4       </td><td>1634    </td><td>1740    </td><td>AA      </td><td>1121    </td><td>N557AA  </td><td> 66     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td>10      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>30      </td><td>7       </td><td>1635    </td><td>1733    </td><td>AA      </td><td>1121    </td><td>N403AA  </td><td> 58     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 9      </td><td>10      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td> 1      </td><td>6       </td><td>1756    </td><td>2112    </td><td>AA      </td><td>1294    </td><td>N3DGAA  </td><td>136     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td> 964    </td><td> 9      </td><td>14      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td> 7      </td><td>5       </td><td>1757    </td><td>2108    </td><td>AA      </td><td>1294    </td><td>N3CYAA  </td><td>131     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td> 964    </td><td> 9      </td><td>15      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>31      </td><td>1       </td><td>1757    </td><td>2101    </td><td>AA      </td><td>1294    </td><td>N3DJAA  </td><td>124     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td> 964    </td><td> 4      </td><td>16      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td> 5      </td><td>3       </td><td> 916    </td><td>1019    </td><td>AA      </td><td>1436    </td><td>N548AA  </td><td> 63     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 4      </td><td>19      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>24      </td><td>1       </td><td> 912    </td><td>1017    </td><td>AA      </td><td>1436    </td><td>N567AA  </td><td> 65     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 9      </td><td>14      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td> 4      </td><td>2       </td><td>1026    </td><td>1333    </td><td>AA      </td><td>1700    </td><td>N3BAAA  </td><td>127     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td> 964    </td><td> 5      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td> 5      </td><td>3       </td><td>1021    </td><td>1331    </td><td>AA      </td><td>1700    </td><td>N3CDAA  </td><td>130     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td> 964    </td><td>10      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td> 9      </td><td>7       </td><td>1029    </td><td>1338    </td><td>AA      </td><td>1700    </td><td>N3CPAA  </td><td>129     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td> 964    </td><td>10      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>14      </td><td>5       </td><td>1024    </td><td>1327    </td><td>AA      </td><td>1700    </td><td>N3AUAA  </td><td>123     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td> 964    </td><td> 5      </td><td> 8      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>16      </td><td>7       </td><td>1021    </td><td>1332    </td><td>AA      </td><td>1700    </td><td>N3BJAA  </td><td>131     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td> 964    </td><td> 4      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>12      </td><td>3       </td><td>1206    </td><td>1305    </td><td>AA      </td><td>1820    </td><td>N593AA  </td><td> 59     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 8      </td><td>10      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>23      </td><td>7       </td><td>1217    </td><td>1308    </td><td>AA      </td><td>1820    </td><td>N436AA  </td><td> 51     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td> 224    </td><td> 5      </td><td> 7      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>16      </td><td>7       </td><td> 605    </td><td> 910    </td><td>AA      </td><td>1994    </td><td>N3AHAA  </td><td>125     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td> 964    </td><td> 4      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td> 3      </td><td>1       </td><td>1827    </td><td>2107    </td><td>AS      </td><td> 731    </td><td>N627AS  </td><td>280     </td><td>...     </td><td>IAH     </td><td>SEA     </td><td>1874    </td><td> 4      </td><td>16      </td><td>0       </td><td>        </td><td>0       </td><td>Alaska  </td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td>25      </td><td>2       </td><td>1826    </td><td>2101    </td><td>AS      </td><td> 731    </td><td>N607AS  </td><td>275     </td><td>...     </td><td>IAH     </td><td>SEA     </td><td>1874    </td><td> 4      </td><td>16      </td><td>0       </td><td>        </td><td>0       </td><td>Alaska  </td><td>NA      </td></tr>
	<tr><td>2011    </td><td>1       </td><td> 2      </td><td>7       </td><td> 703    </td><td>1113    </td><td>B6      </td><td> 620    </td><td>N324JB  </td><td>190     </td><td>...     </td><td>HOU     </td><td>JFK     </td><td>1428    </td><td> 6      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>JetBlue </td><td>NA      </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>   </td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>2011     </td><td>12       </td><td>5        </td><td>1        </td><td>1104     </td><td>1302     </td><td>WN       </td><td> 517     </td><td>N214WN   </td><td>118      </td><td>...      </td><td>HOU      </td><td>MDW      </td><td> 937     </td><td>3        </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>5        </td><td>1        </td><td> 826     </td><td>1028     </td><td>WN       </td><td> 640     </td><td>N761RR   </td><td>122      </td><td>...      </td><td>HOU      </td><td>MDW      </td><td> 937     </td><td>4        </td><td>13       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>5        </td><td>1        </td><td>1636     </td><td>1736     </td><td>WN       </td><td>1300     </td><td>N732SW   </td><td> 60      </td><td>...      </td><td>HOU      </td><td>MSY      </td><td> 302     </td><td>5        </td><td>12       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>5        </td><td>1        </td><td>1229     </td><td>1340     </td><td>WN       </td><td> 581     </td><td>N688SW   </td><td> 71      </td><td>...      </td><td>HOU      </td><td>OKC      </td><td> 419     </td><td>3        </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>5        </td><td>1        </td><td>1246     </td><td>1632     </td><td>WN       </td><td>3085     </td><td>N375SW   </td><td>166      </td><td>...      </td><td>HOU      </td><td>PHL      </td><td>1336     </td><td>5        </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>5        </td><td>1        </td><td>1142     </td><td>1309     </td><td>WN       </td><td>1212     </td><td>N414WN   </td><td>207      </td><td>...      </td><td>HOU      </td><td>SAN      </td><td>1313     </td><td>3        </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>5        </td><td>1        </td><td> 602     </td><td> 751     </td><td>WN       </td><td> 280     </td><td>N271LV   </td><td>109      </td><td>...      </td><td>HOU      </td><td>STL      </td><td> 687     </td><td>4        </td><td>12       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>5        </td><td>1        </td><td>1820     </td><td>2111     </td><td>WN       </td><td>1191     </td><td>N465WN   </td><td>111      </td><td>...      </td><td>HOU      </td><td>TPA      </td><td> 781     </td><td>4        </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>5        </td><td>1        </td><td>2043     </td><td>2329     </td><td>WN       </td><td>1674     </td><td>N397SW   </td><td>106      </td><td>...      </td><td>HOU      </td><td>TPA      </td><td> 781     </td><td>2        </td><td>11       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>5        </td><td>1        </td><td> 703     </td><td> 818     </td><td>WN       </td><td> 621     </td><td>N245WN   </td><td> 75      </td><td>...      </td><td>HOU      </td><td>TUL      </td><td> 453     </td><td>5        </td><td>11       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1346     </td><td>1431     </td><td>WN       </td><td>1684     </td><td>N356SW   </td><td> 45      </td><td>...      </td><td>HOU      </td><td>AUS      </td><td> 148     </td><td>4        </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1156     </td><td>1315     </td><td>WN       </td><td> 231     </td><td>N746SW   </td><td> 79      </td><td>...      </td><td>HOU      </td><td>BHM      </td><td> 570     </td><td>3        </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1251     </td><td>1422     </td><td>WN       </td><td> 153     </td><td>N704SW   </td><td> 91      </td><td>...      </td><td>HOU      </td><td>BNA      </td><td> 670     </td><td>5        </td><td>11       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1047     </td><td>1219     </td><td>WN       </td><td>1662     </td><td>N348SW   </td><td> 92      </td><td>...      </td><td>HOU      </td><td>BNA      </td><td> 670     </td><td>5        </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1044     </td><td>1417     </td><td>WN       </td><td> 439     </td><td>N798SW   </td><td>153      </td><td>...      </td><td>HOU      </td><td>BWI      </td><td>1246     </td><td>5        </td><td> 8       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1849     </td><td>2217     </td><td>WN       </td><td> 757     </td><td>N220WN   </td><td>148      </td><td>...      </td><td>HOU      </td><td>BWI      </td><td>1246     </td><td>4        </td><td>10       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1633     </td><td>1726     </td><td>WN       </td><td>  42     </td><td>N353SW   </td><td> 53      </td><td>...      </td><td>HOU      </td><td>DAL      </td><td> 239     </td><td>3        </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1241     </td><td>1352     </td><td>WN       </td><td> 873     </td><td>N732SW   </td><td>191      </td><td>...      </td><td>HOU      </td><td>LAS      </td><td>1235     </td><td>4        </td><td> 8       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1352     </td><td>1527     </td><td>WN       </td><td> 468     </td><td>N232WN   </td><td>215      </td><td>...      </td><td>HOU      </td><td>LAX      </td><td>1390     </td><td>7        </td><td> 8       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1951     </td><td>2123     </td><td>WN       </td><td>2623     </td><td>N399WN   </td><td>212      </td><td>...      </td><td>HOU      </td><td>LAX      </td><td>1390     </td><td>9        </td><td>11       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>2139     </td><td>  28     </td><td>WN       </td><td>  55     </td><td>N411WN   </td><td>109      </td><td>...      </td><td>HOU      </td><td>MCO      </td><td> 849     </td><td>3        </td><td> 8       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1722     </td><td>1921     </td><td>WN       </td><td>  37     </td><td>N616SW   </td><td>119      </td><td>...      </td><td>HOU      </td><td>MDW      </td><td> 937     </td><td>3        </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1104     </td><td>1311     </td><td>WN       </td><td> 517     </td><td>N239WN   </td><td>127      </td><td>...      </td><td>HOU      </td><td>MDW      </td><td> 937     </td><td>5        </td><td>13       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1936     </td><td>2147     </td><td>WN       </td><td>1568     </td><td>N767SW   </td><td>131      </td><td>...      </td><td>HOU      </td><td>MDW      </td><td> 937     </td><td>8        </td><td>15       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1339     </td><td>1533     </td><td>WN       </td><td>3242     </td><td>N509SW   </td><td>114      </td><td>...      </td><td>HOU      </td><td>MDW      </td><td> 937     </td><td>3        </td><td> 7       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1115     </td><td>1315     </td><td>WN       </td><td>1167     </td><td>N455WN   </td><td>240      </td><td>...      </td><td>HOU      </td><td>OAK      </td><td>1642     </td><td>6        </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td> 836     </td><td> 946     </td><td>WN       </td><td>1223     </td><td>N394SW   </td><td> 70      </td><td>...      </td><td>HOU      </td><td>OKC      </td><td> 419     </td><td>4        </td><td> 8       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1026     </td><td>1208     </td><td>WN       </td><td> 782     </td><td>N476WN   </td><td>102      </td><td>...      </td><td>HOU      </td><td>STL      </td><td> 687     </td><td>4        </td><td>12       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1611     </td><td>1746     </td><td>WN       </td><td>1050     </td><td>N655WN   </td><td> 95      </td><td>...      </td><td>HOU      </td><td>STL      </td><td> 687     </td><td>3        </td><td> 9       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
	<tr><td>2011     </td><td>12       </td><td>6        </td><td>2        </td><td>1818     </td><td>2111     </td><td>WN       </td><td>1191     </td><td>N284WN   </td><td>113      </td><td>...      </td><td>HOU      </td><td>TPA      </td><td> 781     </td><td>5        </td><td>11       </td><td>0        </td><td>         </td><td>0        </td><td>Southwest</td><td>NA       </td></tr>
</tbody>
</table>




```R
# All flights that were cancelled after being delayed
filter(hflights, Cancelled == 1 & DepDelay > 0 )
```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
	<tr><td>2011              </td><td> 1                </td><td>26                </td><td>3                 </td><td>1926              </td><td>NA                </td><td>CO                </td><td> 310              </td><td>N77865            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>EWR               </td><td>1400              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>Continental       </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 1                </td><td>11                </td><td>2                 </td><td>1100              </td><td>NA                </td><td>US                </td><td> 944              </td><td>N452UW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>CLT               </td><td> 913              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>US_Airways        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 1                </td><td>19                </td><td>3                 </td><td>1811              </td><td>NA                </td><td>XE                </td><td>2376              </td><td>N15932            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ICT               </td><td> 542              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 1                </td><td> 7                </td><td>5                 </td><td>2028              </td><td>NA                </td><td>XE                </td><td>3050              </td><td>N15912            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>JAX               </td><td> 817              </td><td>NA                </td><td>19                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>ExpressJet        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 2                </td><td> 4                </td><td>5                 </td><td>1638              </td><td>NA                </td><td>AA                </td><td>1121              </td><td>N537AA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DFW               </td><td> 224              </td><td>NA                </td><td>19                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American          </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 2                </td><td> 8                </td><td>2                 </td><td>1057              </td><td>NA                </td><td>CO                </td><td> 408              </td><td>N11641            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>EWR               </td><td>1400              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Continental       </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 2                </td><td> 2                </td><td>3                 </td><td> 802              </td><td>NA                </td><td>XE                </td><td>2189              </td><td>N17928            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DAL               </td><td> 217              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 2                </td><td> 9                </td><td>3                 </td><td> 904              </td><td>NA                </td><td>XE                </td><td>2605              </td><td>N15941            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DAL               </td><td> 217              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 2                </td><td> 1                </td><td>2                 </td><td>1508              </td><td>NA                </td><td>OO                </td><td>5812              </td><td>N959SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>19                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 3                </td><td>31                </td><td>4                 </td><td>1016              </td><td>NA                </td><td>CO                </td><td> 586              </td><td>N19136            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MCO               </td><td> 853              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>Continental       </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td> 4                </td><td>1                 </td><td>1632              </td><td>NA                </td><td>DL                </td><td>   8              </td><td>N600TR            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Delta             </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td> 8                </td><td>5                 </td><td>1608              </td><td>NA                </td><td>WN                </td><td>   4              </td><td>N365SW            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DAL               </td><td> 239              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Southwest         </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td>21                </td><td>4                 </td><td> 953              </td><td>NA                </td><td>WN                </td><td>3840              </td><td>N455WN            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>SAT               </td><td> 192              </td><td>NA                </td><td> 5                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Southwest         </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td> 4                </td><td>1                 </td><td>1946              </td><td>NA                </td><td>XE                </td><td>2700              </td><td>N15973            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>19                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td> 4                </td><td>1                 </td><td>1854              </td><td>NA                </td><td>XE                </td><td>2748              </td><td>N13968            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MOB               </td><td> 427              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>ExpressJet        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td>11                </td><td>1                 </td><td>1400              </td><td>NA                </td><td>XE                </td><td>2769              </td><td>N13970            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ELP               </td><td> 667              </td><td>NA                </td><td>26                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>ExpressJet        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td>25                </td><td>1                 </td><td>1131              </td><td>NA                </td><td>XE                </td><td>2826              </td><td>N15926            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DAL               </td><td> 217              </td><td>NA                </td><td>13                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td>25                </td><td>1                 </td><td>1257              </td><td>NA                </td><td>XE                </td><td>2964              </td><td>N13936            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DFW               </td><td> 224              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 6                </td><td>15                </td><td>3                 </td><td>1740              </td><td>NA                </td><td>DL                </td><td>   8              </td><td>N704DK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>Delta             </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 6                </td><td>11                </td><td>6                 </td><td>1649              </td><td>NA                </td><td>FL                </td><td>1595              </td><td>N946AT            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>BKG               </td><td> 490              </td><td>NA                </td><td>25                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>AirTran           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 7                </td><td>25                </td><td>1                 </td><td>1654              </td><td>NA                </td><td>CO                </td><td>1422              </td><td>N58606            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>C                 </td><td>0                 </td><td>Continental       </td><td>FFA               </td></tr>
	<tr><td>2011              </td><td> 7                </td><td>21                </td><td>4                 </td><td>2059              </td><td>NA                </td><td>XE                </td><td>2705              </td><td>N15926            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>GPT               </td><td> 376              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>ExpressJet        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 7                </td><td>12                </td><td>2                 </td><td>1556              </td><td>NA                </td><td>UA                </td><td> 993              </td><td>N808UA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>IAD               </td><td>1190              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>United            </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 7                </td><td> 7                </td><td>4                 </td><td>1245              </td><td>NA                </td><td>US                </td><td>1170              </td><td>N456UW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>CLT               </td><td> 912              </td><td>NA                </td><td>15                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>US_Airways        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 8                </td><td>14                </td><td>7                 </td><td>1938              </td><td>NA                </td><td>XE                </td><td>3019              </td><td>N13994            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>CMH               </td><td> 986              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 8                </td><td>11                </td><td>4                 </td><td>2002              </td><td>NA                </td><td>OO                </td><td>5810              </td><td>N978SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MAF               </td><td> 429              </td><td>NA                </td><td>15                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 8                </td><td>18                </td><td>4                 </td><td>1808              </td><td>NA                </td><td>AA                </td><td>1294              </td><td>N3FLAA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MIA               </td><td> 964              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American          </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>29                </td><td>4                 </td><td>1800              </td><td>NA                </td><td>XE                </td><td>2125              </td><td>N14570            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MOB               </td><td> 427              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>C                 </td><td>0                 </td><td>ExpressJet        </td><td>FFA               </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>26                </td><td>1                 </td><td>1544              </td><td>NA                </td><td>EV                </td><td>5222              </td><td>N851AS            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MEM               </td><td> 468              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>16                </td><td>5                 </td><td>1807              </td><td>NA                </td><td>OO                </td><td>2009              </td><td>N794SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DFW               </td><td> 224              </td><td>NA                </td><td>10                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>SkyWest           </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>16                </td><td>5                 </td><td>1234              </td><td>NA                </td><td>OO                </td><td>2059              </td><td>N752SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ELP               </td><td> 667              </td><td>NA                </td><td>12                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>SkyWest           </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>10                </td><td>24                </td><td>1                 </td><td> 631              </td><td>NA                </td><td>WN                </td><td>   2              </td><td>N359SW            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DAL               </td><td> 239              </td><td>NA                </td><td> 6                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Southwest         </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>11                </td><td> 8                </td><td>2                 </td><td>1855              </td><td>NA                </td><td>XE                </td><td>4343              </td><td>N16944            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>LFT               </td><td> 201              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>11                </td><td>15                </td><td>2                 </td><td>1452              </td><td>NA                </td><td>XE                </td><td>4450              </td><td>N13903            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>LFT               </td><td> 201              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>13                </td><td>2                 </td><td>2324              </td><td>NA                </td><td>XE                </td><td>4088              </td><td>N14938            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>LFT               </td><td> 201              </td><td>NA                </td><td> 8                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>11                </td><td>7                 </td><td>2245              </td><td>NA                </td><td>XE                </td><td>4342              </td><td>N11535            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>LRD               </td><td> 301              </td><td>NA                </td><td> 8                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>21                </td><td>3                 </td><td>2159              </td><td>NA                </td><td>XE                </td><td>4595              </td><td>N16149            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>VPS               </td><td> 528              </td><td>NA                </td><td> 9                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>31                </td><td>6                 </td><td>1738              </td><td>NA                </td><td>XE                </td><td>4662              </td><td>N16944            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>PNS               </td><td> 489              </td><td>NA                </td><td>14                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>22                </td><td>4                 </td><td>1633              </td><td>NA                </td><td>OO                </td><td>5159              </td><td>N724SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>SkyWest           </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>28                </td><td>3                 </td><td>1827              </td><td>NA                </td><td>OO                </td><td>5244              </td><td>N912SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ELP               </td><td> 667              </td><td>NA                </td><td>20                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
</tbody>
</table>




```R
# Select the flights that had JFK as their destination
filter(hflights, Dest == "JFK")
```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
	<tr><td>2011   </td><td>1      </td><td> 1     </td><td>6      </td><td> 654   </td><td>1124   </td><td>B6     </td><td>620    </td><td>N324JB </td><td>210    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 6     </td><td>23     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 1     </td><td>6      </td><td>1639   </td><td>2110   </td><td>B6     </td><td>622    </td><td>N324JB </td><td>211    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td>12     </td><td>11     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 2     </td><td>7      </td><td> 703   </td><td>1113   </td><td>B6     </td><td>620    </td><td>N324JB </td><td>190    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 6     </td><td>12     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 2     </td><td>7      </td><td>1604   </td><td>2040   </td><td>B6     </td><td>622    </td><td>N324JB </td><td>216    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 9     </td><td>31     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 3     </td><td>1      </td><td> 659   </td><td>1100   </td><td>B6     </td><td>620    </td><td>N229JB </td><td>181    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 3     </td><td>12     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 3     </td><td>1      </td><td>1801   </td><td>2200   </td><td>B6     </td><td>622    </td><td>N206JB </td><td>179    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 5     </td><td> 9     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 4     </td><td>2      </td><td> 654   </td><td>1103   </td><td>B6     </td><td>620    </td><td>N267JB </td><td>189    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 9     </td><td>12     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 4     </td><td>2      </td><td>1608   </td><td>2034   </td><td>B6     </td><td>622    </td><td>N267JB </td><td>206    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 8     </td><td>23     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 5     </td><td>3      </td><td> 700   </td><td>1103   </td><td>B6     </td><td>620    </td><td>N708JB </td><td>183    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 4     </td><td>12     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 5     </td><td>3      </td><td>1544   </td><td>1954   </td><td>B6     </td><td>624    </td><td>N644JB </td><td>190    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td>14     </td><td>10     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 6     </td><td>4      </td><td>1532   </td><td>1943   </td><td>B6     </td><td>624    </td><td>N641JB </td><td>191    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 7     </td><td> 9     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 7     </td><td>5      </td><td> 654   </td><td>1117   </td><td>B6     </td><td>620    </td><td>N641JB </td><td>203    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 6     </td><td>25     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 7     </td><td>5      </td><td>1542   </td><td>1956   </td><td>B6     </td><td>624    </td><td>N564JB </td><td>194    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 9     </td><td>10     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 8     </td><td>6      </td><td> 654   </td><td>1058   </td><td>B6     </td><td>620    </td><td>N630JB </td><td>184    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 9     </td><td>13     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 9     </td><td>7      </td><td> 653   </td><td>1059   </td><td>B6     </td><td>620    </td><td>N599JB </td><td>186    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 3     </td><td>20     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td> 9     </td><td>7      </td><td>1618   </td><td>2057   </td><td>B6     </td><td>624    </td><td>N625JB </td><td>219    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td>11     </td><td>12     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td>10     </td><td>1      </td><td> 656   </td><td>1102   </td><td>B6     </td><td>620    </td><td>N625JB </td><td>186    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 4     </td><td>16     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td>10     </td><td>1      </td><td>1554   </td><td>2001   </td><td>B6     </td><td>624    </td><td>N504JB </td><td>187    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 7     </td><td>10     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td>11     </td><td>2      </td><td> 653   </td><td>1053   </td><td>B6     </td><td>620    </td><td>N504JB </td><td>180    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 5     </td><td>14     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td>11     </td><td>2      </td><td>  NA   </td><td>  NA   </td><td>B6     </td><td>624    </td><td>N537JB </td><td> NA    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td>NA     </td><td>NA     </td><td>1      </td><td>B      </td><td>0      </td><td>JetBlue</td><td>weather</td></tr>
	<tr><td>2011   </td><td>1      </td><td>12     </td><td>3      </td><td>1532   </td><td>1953   </td><td>B6     </td><td>624    </td><td>N504JB </td><td>201    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 8     </td><td>16     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td>13     </td><td>4      </td><td>1522   </td><td>1938   </td><td>B6     </td><td>624    </td><td>N597JB </td><td>196    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 8     </td><td>10     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td>14     </td><td>5      </td><td> 808   </td><td>1229   </td><td>B6     </td><td>620    </td><td>N597JB </td><td>201    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 7     </td><td> 9     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td>14     </td><td>5      </td><td>1534   </td><td>2015   </td><td>B6     </td><td>624    </td><td>N729JB </td><td>221    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 8     </td><td>24     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td>15     </td><td>6      </td><td> 700   </td><td>1114   </td><td>B6     </td><td>620    </td><td>N503JB </td><td>194    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 4     </td><td>17     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td>16     </td><td>7      </td><td> 652   </td><td>1055   </td><td>B6     </td><td>620    </td><td>N706JB </td><td>183    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 4     </td><td>13     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td>16     </td><td>7      </td><td>1551   </td><td>2004   </td><td>B6     </td><td>624    </td><td>N565JB </td><td>193    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 5     </td><td>12     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td>17     </td><td>1      </td><td> 730   </td><td>1135   </td><td>B6     </td><td>620    </td><td>N523JB </td><td>185    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 4     </td><td>13     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td>17     </td><td>1      </td><td>1531   </td><td>1946   </td><td>B6     </td><td>624    </td><td>N779JB </td><td>195    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 7     </td><td>15     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>1      </td><td>18     </td><td>2      </td><td> 659   </td><td>1102   </td><td>B6     </td><td>620    </td><td>N779JB </td><td>183    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 6     </td><td>15     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>   </td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>2011   </td><td>12     </td><td>17     </td><td>6      </td><td> 641   </td><td>1038   </td><td>B6     </td><td>620    </td><td>N247JB </td><td>177    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 4     </td><td>11     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>17     </td><td>6      </td><td>1616   </td><td>2033   </td><td>B6     </td><td>622    </td><td>N247JB </td><td>197    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td>16     </td><td>11     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>18     </td><td>7      </td><td> 637   </td><td>1050   </td><td>B6     </td><td>620    </td><td>N324JB </td><td>193    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 4     </td><td> 9     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>18     </td><td>7      </td><td>1726   </td><td>2149   </td><td>B6     </td><td>622    </td><td>N247JB </td><td>203    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 7     </td><td>12     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>19     </td><td>1      </td><td> 640   </td><td>1106   </td><td>B6     </td><td>620    </td><td>N247JB </td><td>206    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 9     </td><td>11     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>19     </td><td>1      </td><td>1543   </td><td>2004   </td><td>B6     </td><td>622    </td><td>N292JB </td><td>201    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 6     </td><td>12     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>20     </td><td>2      </td><td> 647   </td><td>1059   </td><td>B6     </td><td>620    </td><td>N292JB </td><td>192    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 4     </td><td>17     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>20     </td><td>2      </td><td>1624   </td><td>2044   </td><td>B6     </td><td>622    </td><td>N306JB </td><td>200    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 6     </td><td>11     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>21     </td><td>3      </td><td> 634   </td><td>1039   </td><td>B6     </td><td>620    </td><td>N267JB </td><td>185    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 5     </td><td> 9     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>21     </td><td>3      </td><td>1756   </td><td>2230   </td><td>B6     </td><td>622    </td><td>N316JB </td><td>214    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 8     </td><td>23     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>22     </td><td>4      </td><td> 634   </td><td>1039   </td><td>B6     </td><td>620    </td><td>N231JB </td><td>185    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 6     </td><td>13     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>22     </td><td>4      </td><td>1640   </td><td>2053   </td><td>B6     </td><td>622    </td><td>N306JB </td><td>193    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 7     </td><td>12     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>23     </td><td>5      </td><td> 633   </td><td>1038   </td><td>B6     </td><td>620    </td><td>N284JB </td><td>185    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 5     </td><td>17     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>23     </td><td>5      </td><td>1606   </td><td>2015   </td><td>B6     </td><td>622    </td><td>N273JB </td><td>189    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 8     </td><td>11     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>24     </td><td>6      </td><td> 635   </td><td>1035   </td><td>B6     </td><td>620    </td><td>N323JB </td><td>180    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 5     </td><td>10     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>24     </td><td>6      </td><td>1600   </td><td>2012   </td><td>B6     </td><td>622    </td><td>N328JB </td><td>192    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 8     </td><td>14     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>25     </td><td>7      </td><td> 638   </td><td>1052   </td><td>B6     </td><td>620    </td><td>N273JB </td><td>194    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 9     </td><td>15     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>25     </td><td>7      </td><td>1608   </td><td>2013   </td><td>B6     </td><td>622    </td><td>N192JB </td><td>185    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 6     </td><td>11     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>26     </td><td>1      </td><td> 633   </td><td>1046   </td><td>B6     </td><td>620    </td><td>N216JB </td><td>193    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 5     </td><td>13     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>26     </td><td>1      </td><td>1550   </td><td>2002   </td><td>B6     </td><td>622    </td><td>N216JB </td><td>192    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td>10     </td><td>12     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>27     </td><td>2      </td><td> 634   </td><td>1040   </td><td>B6     </td><td>620    </td><td>N339JB </td><td>186    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 6     </td><td>10     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>27     </td><td>2      </td><td>1955   </td><td>  39   </td><td>B6     </td><td>622    </td><td>N294JB </td><td>224    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 6     </td><td>43     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>28     </td><td>3      </td><td> 632   </td><td>1047   </td><td>B6     </td><td>620    </td><td>N231JB </td><td>195    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 4     </td><td>14     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>28     </td><td>3      </td><td>1748   </td><td>2147   </td><td>B6     </td><td>622    </td><td>N281JB </td><td>179    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 3     </td><td> 8     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>29     </td><td>4      </td><td> 633   </td><td>1050   </td><td>B6     </td><td>620    </td><td>N274JB </td><td>197    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 4     </td><td>17     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>29     </td><td>4      </td><td>1541   </td><td>1959   </td><td>B6     </td><td>622    </td><td>N206JB </td><td>198    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 7     </td><td> 8     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>30     </td><td>5      </td><td> 634   </td><td>1040   </td><td>B6     </td><td>620    </td><td>N317JB </td><td>186    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 4     </td><td>12     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>30     </td><td>5      </td><td>1541   </td><td>1957   </td><td>B6     </td><td>622    </td><td>N296JB </td><td>196    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 5     </td><td>10     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>31     </td><td>6      </td><td> 831   </td><td>1251   </td><td>B6     </td><td>620    </td><td>N247JB </td><td>200    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 5     </td><td>20     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
	<tr><td>2011   </td><td>12     </td><td>31     </td><td>6      </td><td>1544   </td><td>2009   </td><td>B6     </td><td>622    </td><td>N323JB </td><td>205    </td><td>...    </td><td>HOU    </td><td>JFK    </td><td>1428   </td><td> 4     </td><td>11     </td><td>0      </td><td>       </td><td>0      </td><td>JetBlue</td><td>NA     </td></tr>
</tbody>
</table>




```R
# Combine the Year, Month and DayofMonth variables to create a Date column: c2
c2 <- mutate(c1, Date = paste(Year, Month , DayofMonth, sep="-"))

# Print out a selection of columns of c2
select(c2, Date, DepTime, ArrTime, TailNum)

```


<table>
<thead><tr><th scope=col>Date</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>TailNum</th></tr></thead>
<tbody>
	<tr><td>2011-1-1 </td><td> 654     </td><td>1124     </td><td>N324JB   </td></tr>
	<tr><td>2011-1-1 </td><td>1639     </td><td>2110     </td><td>N324JB   </td></tr>
	<tr><td>2011-1-2 </td><td> 703     </td><td>1113     </td><td>N324JB   </td></tr>
	<tr><td>2011-1-2 </td><td>1604     </td><td>2040     </td><td>N324JB   </td></tr>
	<tr><td>2011-1-3 </td><td> 659     </td><td>1100     </td><td>N229JB   </td></tr>
	<tr><td>2011-1-3 </td><td>1801     </td><td>2200     </td><td>N206JB   </td></tr>
	<tr><td>2011-1-4 </td><td> 654     </td><td>1103     </td><td>N267JB   </td></tr>
	<tr><td>2011-1-4 </td><td>1608     </td><td>2034     </td><td>N267JB   </td></tr>
	<tr><td>2011-1-5 </td><td> 700     </td><td>1103     </td><td>N708JB   </td></tr>
	<tr><td>2011-1-5 </td><td>1544     </td><td>1954     </td><td>N644JB   </td></tr>
	<tr><td>2011-1-6 </td><td>1532     </td><td>1943     </td><td>N641JB   </td></tr>
	<tr><td>2011-1-7 </td><td> 654     </td><td>1117     </td><td>N641JB   </td></tr>
	<tr><td>2011-1-7 </td><td>1542     </td><td>1956     </td><td>N564JB   </td></tr>
	<tr><td>2011-1-8 </td><td> 654     </td><td>1058     </td><td>N630JB   </td></tr>
	<tr><td>2011-1-9 </td><td> 653     </td><td>1059     </td><td>N599JB   </td></tr>
	<tr><td>2011-1-9 </td><td>1618     </td><td>2057     </td><td>N625JB   </td></tr>
	<tr><td>2011-1-10</td><td> 656     </td><td>1102     </td><td>N625JB   </td></tr>
	<tr><td>2011-1-10</td><td>1554     </td><td>2001     </td><td>N504JB   </td></tr>
	<tr><td>2011-1-11</td><td> 653     </td><td>1053     </td><td>N504JB   </td></tr>
	<tr><td>2011-1-11</td><td>  NA     </td><td>  NA     </td><td>N537JB   </td></tr>
	<tr><td>2011-1-12</td><td>1532     </td><td>1953     </td><td>N504JB   </td></tr>
	<tr><td>2011-1-13</td><td>1522     </td><td>1938     </td><td>N597JB   </td></tr>
	<tr><td>2011-1-14</td><td> 808     </td><td>1229     </td><td>N597JB   </td></tr>
	<tr><td>2011-1-14</td><td>1534     </td><td>2015     </td><td>N729JB   </td></tr>
	<tr><td>2011-1-15</td><td> 700     </td><td>1114     </td><td>N503JB   </td></tr>
	<tr><td>2011-1-16</td><td> 652     </td><td>1055     </td><td>N706JB   </td></tr>
	<tr><td>2011-1-16</td><td>1551     </td><td>2004     </td><td>N565JB   </td></tr>
	<tr><td>2011-1-17</td><td> 730     </td><td>1135     </td><td>N523JB   </td></tr>
	<tr><td>2011-1-17</td><td>1531     </td><td>1946     </td><td>N779JB   </td></tr>
	<tr><td>2011-1-18</td><td> 659     </td><td>1102     </td><td>N779JB   </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>2011-12-17</td><td> 641      </td><td>1038      </td><td>N247JB    </td></tr>
	<tr><td>2011-12-17</td><td>1616      </td><td>2033      </td><td>N247JB    </td></tr>
	<tr><td>2011-12-18</td><td> 637      </td><td>1050      </td><td>N324JB    </td></tr>
	<tr><td>2011-12-18</td><td>1726      </td><td>2149      </td><td>N247JB    </td></tr>
	<tr><td>2011-12-19</td><td> 640      </td><td>1106      </td><td>N247JB    </td></tr>
	<tr><td>2011-12-19</td><td>1543      </td><td>2004      </td><td>N292JB    </td></tr>
	<tr><td>2011-12-20</td><td> 647      </td><td>1059      </td><td>N292JB    </td></tr>
	<tr><td>2011-12-20</td><td>1624      </td><td>2044      </td><td>N306JB    </td></tr>
	<tr><td>2011-12-21</td><td> 634      </td><td>1039      </td><td>N267JB    </td></tr>
	<tr><td>2011-12-21</td><td>1756      </td><td>2230      </td><td>N316JB    </td></tr>
	<tr><td>2011-12-22</td><td> 634      </td><td>1039      </td><td>N231JB    </td></tr>
	<tr><td>2011-12-22</td><td>1640      </td><td>2053      </td><td>N306JB    </td></tr>
	<tr><td>2011-12-23</td><td> 633      </td><td>1038      </td><td>N284JB    </td></tr>
	<tr><td>2011-12-23</td><td>1606      </td><td>2015      </td><td>N273JB    </td></tr>
	<tr><td>2011-12-24</td><td> 635      </td><td>1035      </td><td>N323JB    </td></tr>
	<tr><td>2011-12-24</td><td>1600      </td><td>2012      </td><td>N328JB    </td></tr>
	<tr><td>2011-12-25</td><td> 638      </td><td>1052      </td><td>N273JB    </td></tr>
	<tr><td>2011-12-25</td><td>1608      </td><td>2013      </td><td>N192JB    </td></tr>
	<tr><td>2011-12-26</td><td> 633      </td><td>1046      </td><td>N216JB    </td></tr>
	<tr><td>2011-12-26</td><td>1550      </td><td>2002      </td><td>N216JB    </td></tr>
	<tr><td>2011-12-27</td><td> 634      </td><td>1040      </td><td>N339JB    </td></tr>
	<tr><td>2011-12-27</td><td>1955      </td><td>  39      </td><td>N294JB    </td></tr>
	<tr><td>2011-12-28</td><td> 632      </td><td>1047      </td><td>N231JB    </td></tr>
	<tr><td>2011-12-28</td><td>1748      </td><td>2147      </td><td>N281JB    </td></tr>
	<tr><td>2011-12-29</td><td> 633      </td><td>1050      </td><td>N274JB    </td></tr>
	<tr><td>2011-12-29</td><td>1541      </td><td>1959      </td><td>N206JB    </td></tr>
	<tr><td>2011-12-30</td><td> 634      </td><td>1040      </td><td>N317JB    </td></tr>
	<tr><td>2011-12-30</td><td>1541      </td><td>1957      </td><td>N296JB    </td></tr>
	<tr><td>2011-12-31</td><td> 831      </td><td>1251      </td><td>N247JB    </td></tr>
	<tr><td>2011-12-31</td><td>1544      </td><td>2009      </td><td>N323JB    </td></tr>
</tbody>
</table>




```R
# Definition of dtc
dtc <- filter(hflights, Cancelled == 1, !is.na(DepDelay))

# Arrange dtc by departure delays
arrange(dtc,DepDelay)

```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
	<tr><td>2011              </td><td> 7                </td><td>23                </td><td>6                 </td><td> 605              </td><td>NA                </td><td>F9                </td><td> 225              </td><td>N912FR            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DEN               </td><td> 883              </td><td>NA                </td><td>10                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Frontier          </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 1                </td><td>17                </td><td>1                 </td><td> 916              </td><td>NA                </td><td>XE                </td><td>3068              </td><td>N13936            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>HRL               </td><td> 295              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>12                </td><td> 1                </td><td>4                 </td><td> 541              </td><td>NA                </td><td>US                </td><td> 282              </td><td>N840AW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>PHX               </td><td>1009              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>US_Airways        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>10                </td><td>12                </td><td>3                 </td><td>2022              </td><td>NA                </td><td>MQ                </td><td>3724              </td><td>N539MQ            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>LAX               </td><td>1379              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American_Eagle    </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 7                </td><td>29                </td><td>5                 </td><td>1424              </td><td>NA                </td><td>CO                </td><td>1079              </td><td>N14628            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ORD               </td><td> 925              </td><td>NA                </td><td>13                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Continental       </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>29                </td><td>4                 </td><td>1639              </td><td>NA                </td><td>OO                </td><td>2062              </td><td>N724SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>SkyWest           </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 2                </td><td> 9                </td><td>3                 </td><td> 555              </td><td>NA                </td><td>MQ                </td><td>3265              </td><td>N613MQ            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DFW               </td><td> 247              </td><td>NA                </td><td>11                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American_Eagle    </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 5                </td><td> 9                </td><td>1                 </td><td> 715              </td><td>NA                </td><td>OO                </td><td>1177              </td><td>N758SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DTW               </td><td>1076              </td><td>NA                </td><td>17                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 1                </td><td>20                </td><td>4                 </td><td>1413              </td><td>NA                </td><td>UA                </td><td> 552              </td><td>N509UA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>IAD               </td><td>1190              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>United            </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 1                </td><td>17                </td><td>1                 </td><td> 831              </td><td>NA                </td><td>WN                </td><td>   1              </td><td>N714CB            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>HRL               </td><td> 276              </td><td>NA                </td><td> 8                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>Southwest         </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 2                </td><td>21                </td><td>1                 </td><td>2257              </td><td>NA                </td><td>OO                </td><td>1111              </td><td>N778SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>AUS               </td><td> 140              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 3                </td><td>18                </td><td>5                 </td><td> 727              </td><td>NA                </td><td>UA                </td><td> 109              </td><td>N469UA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DEN               </td><td> 862              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>United            </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td>30                </td><td>6                 </td><td> 612              </td><td>NA                </td><td>EV                </td><td>5386              </td><td>N844AS            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MEM               </td><td> 469              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td>10                </td><td>7                 </td><td>1147              </td><td>NA                </td><td>EV                </td><td>5402              </td><td>N684BR            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MEM               </td><td> 469              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 5                </td><td>23                </td><td>1                 </td><td> 657              </td><td>NA                </td><td>EV                </td><td>5445              </td><td>N606LR            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>ATL               </td><td> 696              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 6                </td><td>20                </td><td>1                 </td><td>1037              </td><td>NA                </td><td>OO                </td><td>5817              </td><td>N443SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>CLT               </td><td> 913              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 7                </td><td>17                </td><td>7                 </td><td>1917              </td><td>NA                </td><td>MQ                </td><td>3717              </td><td>N503MQ            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ORD               </td><td> 925              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American_Eagle    </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>25                </td><td>7                 </td><td>1652              </td><td>NA                </td><td>XE                </td><td>4375              </td><td>N12946            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MOB               </td><td> 427              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>ExpressJet        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td> 7                </td><td>4                 </td><td>2118              </td><td>NA                </td><td>OO                </td><td>5819              </td><td>N916SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MAF               </td><td> 429              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>29                </td><td>4                 </td><td> 723              </td><td>NA                </td><td>EV                </td><td>4882              </td><td>N355CA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DTW               </td><td>1075              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>10                </td><td>12                </td><td>3                 </td><td> 758              </td><td>NA                </td><td>WN                </td><td>   8              </td><td>N405WN            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DAL               </td><td> 239              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Southwest         </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 5                </td><td>16                </td><td>1                 </td><td>1619              </td><td>NA                </td><td>EV                </td><td>5401              </td><td>N856AS            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MEM               </td><td> 469              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 6                </td><td>26                </td><td>7                 </td><td>1629              </td><td>NA                </td><td>WN                </td><td>  42              </td><td>N640SW            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DAL               </td><td> 239              </td><td>NA                </td><td>13                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Southwest         </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 8                </td><td>26                </td><td>5                 </td><td>1054              </td><td>NA                </td><td>XE                </td><td>2397              </td><td>N11192            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>CHS               </td><td> 925              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 8                </td><td>18                </td><td>4                 </td><td>1809              </td><td>NA                </td><td>OO                </td><td>2028              </td><td>N758SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>OMA               </td><td> 781              </td><td>NA                </td><td>32                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>SkyWest           </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 1                </td><td>26                </td><td>3                 </td><td>1703              </td><td>NA                </td><td>CO                </td><td> 410              </td><td>N77296            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>IAD               </td><td>1190              </td><td>NA                </td><td>13                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>Continental       </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 8                </td><td>11                </td><td>4                 </td><td>1320              </td><td>NA                </td><td>CO                </td><td>1669              </td><td>N73275            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MIA               </td><td> 964              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Continental       </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>11                </td><td>7                 </td><td>1303              </td><td>NA                </td><td>UA                </td><td> 399              </td><td>N528UA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DEN               </td><td> 862              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>United            </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td>25                </td><td>1                 </td><td>1131              </td><td>NA                </td><td>XE                </td><td>2826              </td><td>N15926            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DAL               </td><td> 217              </td><td>NA                </td><td>13                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>10                </td><td>24                </td><td>1                 </td><td> 631              </td><td>NA                </td><td>WN                </td><td>   2              </td><td>N359SW            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DAL               </td><td> 239              </td><td>NA                </td><td> 6                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Southwest         </td><td>carrier           </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>   </td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>2011              </td><td>12                </td><td>31                </td><td>6                 </td><td>1738              </td><td>NA                </td><td>XE                </td><td>4662              </td><td>N16944            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>PNS               </td><td> 489              </td><td>NA                </td><td>14                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 7                </td><td>25                </td><td>1                 </td><td>1654              </td><td>NA                </td><td>CO                </td><td>1422              </td><td>N58606            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>C                 </td><td>0                 </td><td>Continental       </td><td>FFA               </td></tr>
	<tr><td>2011              </td><td> 1                </td><td>26                </td><td>3                 </td><td>1926              </td><td>NA                </td><td>CO                </td><td> 310              </td><td>N77865            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>EWR               </td><td>1400              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>Continental       </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>16                </td><td>5                 </td><td>1807              </td><td>NA                </td><td>OO                </td><td>2009              </td><td>N794SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DFW               </td><td> 224              </td><td>NA                </td><td>10                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>SkyWest           </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>28                </td><td>3                 </td><td>1827              </td><td>NA                </td><td>OO                </td><td>5244              </td><td>N912SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ELP               </td><td> 667              </td><td>NA                </td><td>20                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 2                </td><td> 1                </td><td>2                 </td><td>1508              </td><td>NA                </td><td>OO                </td><td>5812              </td><td>N959SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>19                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 8                </td><td>11                </td><td>4                 </td><td>2002              </td><td>NA                </td><td>OO                </td><td>5810              </td><td>N978SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MAF               </td><td> 429              </td><td>NA                </td><td>15                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td> 4                </td><td>1                 </td><td>1632              </td><td>NA                </td><td>DL                </td><td>   8              </td><td>N600TR            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Delta             </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 6                </td><td>11                </td><td>6                 </td><td>1649              </td><td>NA                </td><td>FL                </td><td>1595              </td><td>N946AT            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>BKG               </td><td> 490              </td><td>NA                </td><td>25                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>AirTran           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>16                </td><td>5                 </td><td>1234              </td><td>NA                </td><td>OO                </td><td>2059              </td><td>N752SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ELP               </td><td> 667              </td><td>NA                </td><td>12                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>SkyWest           </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>21                </td><td>3                 </td><td>2159              </td><td>NA                </td><td>XE                </td><td>4595              </td><td>N16149            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>VPS               </td><td> 528              </td><td>NA                </td><td> 9                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 1                </td><td> 7                </td><td>5                 </td><td>2028              </td><td>NA                </td><td>XE                </td><td>3050              </td><td>N15912            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>JAX               </td><td> 817              </td><td>NA                </td><td>19                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>ExpressJet        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>11                </td><td> 8                </td><td>2                 </td><td>1855              </td><td>NA                </td><td>XE                </td><td>4343              </td><td>N16944            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>LFT               </td><td> 201              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>11                </td><td>7                 </td><td>2245              </td><td>NA                </td><td>XE                </td><td>4342              </td><td>N11535            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>LRD               </td><td> 301              </td><td>NA                </td><td> 8                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>29                </td><td>4                 </td><td>1800              </td><td>NA                </td><td>XE                </td><td>2125              </td><td>N14570            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MOB               </td><td> 427              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>C                 </td><td>0                 </td><td>ExpressJet        </td><td>FFA               </td></tr>
	<tr><td>2011              </td><td> 4                </td><td>25                </td><td>1                 </td><td>1257              </td><td>NA                </td><td>XE                </td><td>2964              </td><td>N13936            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DFW               </td><td> 224              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>22                </td><td>4                 </td><td>1633              </td><td>NA                </td><td>OO                </td><td>5159              </td><td>N724SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>SkyWest           </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td> 4                </td><td>1                 </td><td>1854              </td><td>NA                </td><td>XE                </td><td>2748              </td><td>N13968            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MOB               </td><td> 427              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>ExpressJet        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 6                </td><td>15                </td><td>3                 </td><td>1740              </td><td>NA                </td><td>DL                </td><td>   8              </td><td>N704DK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>Delta             </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 7                </td><td>12                </td><td>2                 </td><td>1556              </td><td>NA                </td><td>UA                </td><td> 993              </td><td>N808UA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>IAD               </td><td>1190              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>United            </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>13                </td><td>2                 </td><td>2324              </td><td>NA                </td><td>XE                </td><td>4088              </td><td>N14938            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>LFT               </td><td> 201              </td><td>NA                </td><td> 8                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td> 4                </td><td>1                 </td><td>1946              </td><td>NA                </td><td>XE                </td><td>2700              </td><td>N15973            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>19                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 1                </td><td>11                </td><td>2                 </td><td>1100              </td><td>NA                </td><td>US                </td><td> 944              </td><td>N452UW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>CLT               </td><td> 913              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>US_Airways        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 7                </td><td> 7                </td><td>4                 </td><td>1245              </td><td>NA                </td><td>US                </td><td>1170              </td><td>N456UW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>CLT               </td><td> 912              </td><td>NA                </td><td>15                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>US_Airways        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 3                </td><td>31                </td><td>4                 </td><td>1016              </td><td>NA                </td><td>CO                </td><td> 586              </td><td>N19136            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MCO               </td><td> 853              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>Continental       </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 8                </td><td>14                </td><td>7                 </td><td>1938              </td><td>NA                </td><td>XE                </td><td>3019              </td><td>N13994            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>CMH               </td><td> 986              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>ExpressJet        </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 2                </td><td> 8                </td><td>2                 </td><td>1057              </td><td>NA                </td><td>CO                </td><td> 408              </td><td>N11641            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>EWR               </td><td>1400              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Continental       </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>26                </td><td>1                 </td><td>1544              </td><td>NA                </td><td>EV                </td><td>5222              </td><td>N851AS            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MEM               </td><td> 468              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 7                </td><td>21                </td><td>4                 </td><td>2059              </td><td>NA                </td><td>XE                </td><td>2705              </td><td>N15926            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>GPT               </td><td> 376              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>ExpressJet        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td> 8                </td><td>5                 </td><td>1608              </td><td>NA                </td><td>WN                </td><td>   4              </td><td>N365SW            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DAL               </td><td> 239              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Southwest         </td><td>carrier           </td></tr>
</tbody>
</table>




```R

# Arrange dtc so that cancellation reasons are grouped
arrange(dtc,CancellationCode)
```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
	<tr><td>2011              </td><td>1                 </td><td>20                </td><td>4                 </td><td>1413              </td><td>NA                </td><td>UA                </td><td> 552              </td><td>N509UA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>IAD               </td><td>1190              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>United            </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>1                 </td><td> 7                </td><td>5                 </td><td>2028              </td><td>NA                </td><td>XE                </td><td>3050              </td><td>N15912            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>JAX               </td><td> 817              </td><td>NA                </td><td>19                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>ExpressJet        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>2                 </td><td> 4                </td><td>5                 </td><td>1638              </td><td>NA                </td><td>AA                </td><td>1121              </td><td>N537AA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DFW               </td><td> 224              </td><td>NA                </td><td>19                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American          </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>2                 </td><td> 8                </td><td>2                 </td><td>1057              </td><td>NA                </td><td>CO                </td><td> 408              </td><td>N11641            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>EWR               </td><td>1400              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Continental       </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>2                 </td><td> 1                </td><td>2                 </td><td>1508              </td><td>NA                </td><td>OO                </td><td>5812              </td><td>N959SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>19                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>2                 </td><td>21                </td><td>1                 </td><td>2257              </td><td>NA                </td><td>OO                </td><td>1111              </td><td>N778SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>AUS               </td><td> 140              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>2                 </td><td> 9                </td><td>3                 </td><td> 555              </td><td>NA                </td><td>MQ                </td><td>3265              </td><td>N613MQ            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DFW               </td><td> 247              </td><td>NA                </td><td>11                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American_Eagle    </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>3                 </td><td>18                </td><td>5                 </td><td> 727              </td><td>NA                </td><td>UA                </td><td> 109              </td><td>N469UA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DEN               </td><td> 862              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>United            </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>4                 </td><td> 4                </td><td>1                 </td><td>1632              </td><td>NA                </td><td>DL                </td><td>   8              </td><td>N600TR            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Delta             </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>4                 </td><td> 8                </td><td>5                 </td><td>1608              </td><td>NA                </td><td>WN                </td><td>   4              </td><td>N365SW            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DAL               </td><td> 239              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Southwest         </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>4                 </td><td>21                </td><td>4                 </td><td> 953              </td><td>NA                </td><td>WN                </td><td>3840              </td><td>N455WN            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>SAT               </td><td> 192              </td><td>NA                </td><td> 5                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Southwest         </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>4                 </td><td> 4                </td><td>1                 </td><td>1854              </td><td>NA                </td><td>XE                </td><td>2748              </td><td>N13968            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MOB               </td><td> 427              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>ExpressJet        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>4                 </td><td>11                </td><td>1                 </td><td>1400              </td><td>NA                </td><td>XE                </td><td>2769              </td><td>N13970            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ELP               </td><td> 667              </td><td>NA                </td><td>26                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>ExpressJet        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>4                 </td><td> 7                </td><td>4                 </td><td>2118              </td><td>NA                </td><td>OO                </td><td>5819              </td><td>N916SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MAF               </td><td> 429              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>4                 </td><td>30                </td><td>6                 </td><td> 612              </td><td>NA                </td><td>EV                </td><td>5386              </td><td>N844AS            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MEM               </td><td> 469              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>4                 </td><td>10                </td><td>7                 </td><td>1147              </td><td>NA                </td><td>EV                </td><td>5402              </td><td>N684BR            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MEM               </td><td> 469              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>5                 </td><td> 9                </td><td>1                 </td><td> 715              </td><td>NA                </td><td>OO                </td><td>1177              </td><td>N758SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DTW               </td><td>1076              </td><td>NA                </td><td>17                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>5                 </td><td>16                </td><td>1                 </td><td>1619              </td><td>NA                </td><td>EV                </td><td>5401              </td><td>N856AS            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MEM               </td><td> 469              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>5                 </td><td>23                </td><td>1                 </td><td> 657              </td><td>NA                </td><td>EV                </td><td>5445              </td><td>N606LR            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>ATL               </td><td> 696              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>6                 </td><td>26                </td><td>7                 </td><td>1629              </td><td>NA                </td><td>WN                </td><td>  42              </td><td>N640SW            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DAL               </td><td> 239              </td><td>NA                </td><td>13                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Southwest         </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>6                 </td><td>20                </td><td>1                 </td><td>1037              </td><td>NA                </td><td>OO                </td><td>5817              </td><td>N443SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>CLT               </td><td> 913              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>6                 </td><td>11                </td><td>6                 </td><td>1649              </td><td>NA                </td><td>FL                </td><td>1595              </td><td>N946AT            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>BKG               </td><td> 490              </td><td>NA                </td><td>25                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>AirTran           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>7                 </td><td>29                </td><td>5                 </td><td>1424              </td><td>NA                </td><td>CO                </td><td>1079              </td><td>N14628            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ORD               </td><td> 925              </td><td>NA                </td><td>13                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Continental       </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>7                 </td><td>21                </td><td>4                 </td><td>2059              </td><td>NA                </td><td>XE                </td><td>2705              </td><td>N15926            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>GPT               </td><td> 376              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>ExpressJet        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>7                 </td><td>23                </td><td>6                 </td><td> 605              </td><td>NA                </td><td>F9                </td><td> 225              </td><td>N912FR            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DEN               </td><td> 883              </td><td>NA                </td><td>10                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Frontier          </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>7                 </td><td>17                </td><td>7                 </td><td>1917              </td><td>NA                </td><td>MQ                </td><td>3717              </td><td>N503MQ            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ORD               </td><td> 925              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American_Eagle    </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>7                 </td><td>12                </td><td>2                 </td><td>1556              </td><td>NA                </td><td>UA                </td><td> 993              </td><td>N808UA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>IAD               </td><td>1190              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>United            </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>7                 </td><td> 7                </td><td>4                 </td><td>1245              </td><td>NA                </td><td>US                </td><td>1170              </td><td>N456UW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>CLT               </td><td> 912              </td><td>NA                </td><td>15                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>US_Airways        </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>8                 </td><td>11                </td><td>4                 </td><td>2002              </td><td>NA                </td><td>OO                </td><td>5810              </td><td>N978SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MAF               </td><td> 429              </td><td>NA                </td><td>15                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>8                 </td><td>18                </td><td>4                 </td><td>1808              </td><td>NA                </td><td>AA                </td><td>1294              </td><td>N3FLAA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MIA               </td><td> 964              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American          </td><td>carrier           </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>   </td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>2011       </td><td>12         </td><td>11         </td><td>7          </td><td>1303       </td><td>NA         </td><td>UA         </td><td> 399       </td><td>N528UA     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>DEN        </td><td> 862       </td><td>NA         </td><td>NA         </td><td>1          </td><td>A          </td><td>0          </td><td>United     </td><td>carrier    </td></tr>
	<tr><td>2011       </td><td>12         </td><td> 1         </td><td>4          </td><td> 541       </td><td>NA         </td><td>US         </td><td> 282       </td><td>N840AW     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>PHX        </td><td>1009       </td><td>NA         </td><td>NA         </td><td>1          </td><td>A          </td><td>0          </td><td>US_Airways </td><td>carrier    </td></tr>
	<tr><td>2011       </td><td> 1         </td><td>26         </td><td>3          </td><td>1926       </td><td>NA         </td><td>CO         </td><td> 310       </td><td>N77865     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>EWR        </td><td>1400       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>Continental</td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 1         </td><td>26         </td><td>3          </td><td>1703       </td><td>NA         </td><td>CO         </td><td> 410       </td><td>N77296     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>IAD        </td><td>1190       </td><td>NA         </td><td>13         </td><td>1          </td><td>B          </td><td>0          </td><td>Continental</td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 1         </td><td>11         </td><td>2          </td><td>1100       </td><td>NA         </td><td>US         </td><td> 944       </td><td>N452UW     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>CLT        </td><td> 913       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>US_Airways </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 1         </td><td>17         </td><td>1          </td><td> 831       </td><td>NA         </td><td>WN         </td><td>   1       </td><td>N714CB     </td><td>NA         </td><td>...        </td><td>HOU        </td><td>HRL        </td><td> 276       </td><td>NA         </td><td> 8         </td><td>1          </td><td>B          </td><td>0          </td><td>Southwest  </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 1         </td><td>19         </td><td>3          </td><td>1811       </td><td>NA         </td><td>XE         </td><td>2376       </td><td>N15932     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>ICT        </td><td> 542       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 1         </td><td>17         </td><td>1          </td><td> 916       </td><td>NA         </td><td>XE         </td><td>3068       </td><td>N13936     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>HRL        </td><td> 295       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 2         </td><td> 2         </td><td>3          </td><td> 802       </td><td>NA         </td><td>XE         </td><td>2189       </td><td>N17928     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>DAL        </td><td> 217       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 2         </td><td> 9         </td><td>3          </td><td> 904       </td><td>NA         </td><td>XE         </td><td>2605       </td><td>N15941     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>DAL        </td><td> 217       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 3         </td><td>31         </td><td>4          </td><td>1016       </td><td>NA         </td><td>CO         </td><td> 586       </td><td>N19136     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>MCO        </td><td> 853       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>Continental</td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 4         </td><td> 4         </td><td>1          </td><td>1946       </td><td>NA         </td><td>XE         </td><td>2700       </td><td>N15973     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>ATL        </td><td> 689       </td><td>NA         </td><td>19         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 4         </td><td>25         </td><td>1          </td><td>1131       </td><td>NA         </td><td>XE         </td><td>2826       </td><td>N15926     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>DAL        </td><td> 217       </td><td>NA         </td><td>13         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 4         </td><td>25         </td><td>1          </td><td>1257       </td><td>NA         </td><td>XE         </td><td>2964       </td><td>N13936     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>DFW        </td><td> 224       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 6         </td><td>15         </td><td>3          </td><td>1740       </td><td>NA         </td><td>DL         </td><td>   8       </td><td>N704DK     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>ATL        </td><td> 689       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>Delta      </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 8         </td><td>26         </td><td>5          </td><td>1054       </td><td>NA         </td><td>XE         </td><td>2397       </td><td>N11192     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>CHS        </td><td> 925       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 8         </td><td>14         </td><td>7          </td><td>1938       </td><td>NA         </td><td>XE         </td><td>3019       </td><td>N13994     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>CMH        </td><td> 986       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 8         </td><td>18         </td><td>4          </td><td>1809       </td><td>NA         </td><td>OO         </td><td>2028       </td><td>N758SK     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>OMA        </td><td> 781       </td><td>NA         </td><td>32         </td><td>1          </td><td>B          </td><td>0          </td><td>SkyWest    </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 9         </td><td>16         </td><td>5          </td><td>1807       </td><td>NA         </td><td>OO         </td><td>2009       </td><td>N794SK     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>DFW        </td><td> 224       </td><td>NA         </td><td>10         </td><td>1          </td><td>B          </td><td>0          </td><td>SkyWest    </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 9         </td><td>16         </td><td>5          </td><td>1234       </td><td>NA         </td><td>OO         </td><td>2059       </td><td>N752SK     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>ELP        </td><td> 667       </td><td>NA         </td><td>12         </td><td>1          </td><td>B          </td><td>0          </td><td>SkyWest    </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 9         </td><td>29         </td><td>4          </td><td>1639       </td><td>NA         </td><td>OO         </td><td>2062       </td><td>N724SK     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>ATL        </td><td> 689       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>SkyWest    </td><td>weather    </td></tr>
	<tr><td>2011       </td><td>11         </td><td> 8         </td><td>2          </td><td>1855       </td><td>NA         </td><td>XE         </td><td>4343       </td><td>N16944     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>LFT        </td><td> 201       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td>11         </td><td>15         </td><td>2          </td><td>1452       </td><td>NA         </td><td>XE         </td><td>4450       </td><td>N13903     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>LFT        </td><td> 201       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td>12         </td><td>13         </td><td>2          </td><td>2324       </td><td>NA         </td><td>XE         </td><td>4088       </td><td>N14938     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>LFT        </td><td> 201       </td><td>NA         </td><td> 8         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td>12         </td><td>11         </td><td>7          </td><td>2245       </td><td>NA         </td><td>XE         </td><td>4342       </td><td>N11535     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>LRD        </td><td> 301       </td><td>NA         </td><td> 8         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td>12         </td><td>21         </td><td>3          </td><td>2159       </td><td>NA         </td><td>XE         </td><td>4595       </td><td>N16149     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>VPS        </td><td> 528       </td><td>NA         </td><td> 9         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td>12         </td><td>31         </td><td>6          </td><td>1738       </td><td>NA         </td><td>XE         </td><td>4662       </td><td>N16944     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>PNS        </td><td> 489       </td><td>NA         </td><td>14         </td><td>1          </td><td>B          </td><td>0          </td><td>ExpressJet </td><td>weather    </td></tr>
	<tr><td>2011       </td><td>12         </td><td>22         </td><td>4          </td><td>1633       </td><td>NA         </td><td>OO         </td><td>5159       </td><td>N724SK     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>ATL        </td><td> 689       </td><td>NA         </td><td>NA         </td><td>1          </td><td>B          </td><td>0          </td><td>SkyWest    </td><td>weather    </td></tr>
	<tr><td>2011       </td><td> 7         </td><td>25         </td><td>1          </td><td>1654       </td><td>NA         </td><td>CO         </td><td>1422       </td><td>N58606     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>ATL        </td><td> 689       </td><td>NA         </td><td>NA         </td><td>1          </td><td>C          </td><td>0          </td><td>Continental</td><td>FFA        </td></tr>
	<tr><td>2011       </td><td> 9         </td><td>29         </td><td>4          </td><td>1800       </td><td>NA         </td><td>XE         </td><td>2125       </td><td>N14570     </td><td>NA         </td><td>...        </td><td>IAH        </td><td>MOB        </td><td> 427       </td><td>NA         </td><td>NA         </td><td>1          </td><td>C          </td><td>0          </td><td>ExpressJet </td><td>FFA        </td></tr>
</tbody>
</table>




```R
# Arrange dtc according to carrier and departure delays
arrange(dtc,UniqueCarrier, DepDelay)

```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
	<tr><td>2011              </td><td> 8                </td><td>18                </td><td>4                 </td><td>1808              </td><td>NA                </td><td>AA                </td><td>1294              </td><td>N3FLAA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MIA               </td><td> 964              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American          </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 2                </td><td> 4                </td><td>5                 </td><td>1638              </td><td>NA                </td><td>AA                </td><td>1121              </td><td>N537AA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DFW               </td><td> 224              </td><td>NA                </td><td>19                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American          </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 7                </td><td>29                </td><td>5                 </td><td>1424              </td><td>NA                </td><td>CO                </td><td>1079              </td><td>N14628            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ORD               </td><td> 925              </td><td>NA                </td><td>13                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Continental       </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 1                </td><td>26                </td><td>3                 </td><td>1703              </td><td>NA                </td><td>CO                </td><td> 410              </td><td>N77296            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>IAD               </td><td>1190              </td><td>NA                </td><td>13                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>Continental       </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 8                </td><td>11                </td><td>4                 </td><td>1320              </td><td>NA                </td><td>CO                </td><td>1669              </td><td>N73275            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MIA               </td><td> 964              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Continental       </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 7                </td><td>25                </td><td>1                 </td><td>1654              </td><td>NA                </td><td>CO                </td><td>1422              </td><td>N58606            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>C                 </td><td>0                 </td><td>Continental       </td><td>FFA               </td></tr>
	<tr><td>2011              </td><td> 1                </td><td>26                </td><td>3                 </td><td>1926              </td><td>NA                </td><td>CO                </td><td> 310              </td><td>N77865            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>EWR               </td><td>1400              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>Continental       </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 3                </td><td>31                </td><td>4                 </td><td>1016              </td><td>NA                </td><td>CO                </td><td> 586              </td><td>N19136            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MCO               </td><td> 853              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>Continental       </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 2                </td><td> 8                </td><td>2                 </td><td>1057              </td><td>NA                </td><td>CO                </td><td> 408              </td><td>N11641            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>EWR               </td><td>1400              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Continental       </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td> 4                </td><td>1                 </td><td>1632              </td><td>NA                </td><td>DL                </td><td>   8              </td><td>N600TR            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Delta             </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 6                </td><td>15                </td><td>3                 </td><td>1740              </td><td>NA                </td><td>DL                </td><td>   8              </td><td>N704DK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>Delta             </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td>30                </td><td>6                 </td><td> 612              </td><td>NA                </td><td>EV                </td><td>5386              </td><td>N844AS            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MEM               </td><td> 469              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td>10                </td><td>7                 </td><td>1147              </td><td>NA                </td><td>EV                </td><td>5402              </td><td>N684BR            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MEM               </td><td> 469              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 5                </td><td>23                </td><td>1                 </td><td> 657              </td><td>NA                </td><td>EV                </td><td>5445              </td><td>N606LR            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>ATL               </td><td> 696              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>29                </td><td>4                 </td><td> 723              </td><td>NA                </td><td>EV                </td><td>4882              </td><td>N355CA            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DTW               </td><td>1075              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 5                </td><td>16                </td><td>1                 </td><td>1619              </td><td>NA                </td><td>EV                </td><td>5401              </td><td>N856AS            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MEM               </td><td> 469              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>26                </td><td>1                 </td><td>1544              </td><td>NA                </td><td>EV                </td><td>5222              </td><td>N851AS            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MEM               </td><td> 468              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Atlantic_Southeast</td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 7                </td><td>23                </td><td>6                 </td><td> 605              </td><td>NA                </td><td>F9                </td><td> 225              </td><td>N912FR            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DEN               </td><td> 883              </td><td>NA                </td><td>10                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>Frontier          </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 6                </td><td>11                </td><td>6                 </td><td>1649              </td><td>NA                </td><td>FL                </td><td>1595              </td><td>N946AT            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>BKG               </td><td> 490              </td><td>NA                </td><td>25                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>AirTran           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td>10                </td><td>12                </td><td>3                 </td><td>2022              </td><td>NA                </td><td>MQ                </td><td>3724              </td><td>N539MQ            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>LAX               </td><td>1379              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American_Eagle    </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 2                </td><td> 9                </td><td>3                 </td><td> 555              </td><td>NA                </td><td>MQ                </td><td>3265              </td><td>N613MQ            </td><td>NA                </td><td>...               </td><td>HOU               </td><td>DFW               </td><td> 247              </td><td>NA                </td><td>11                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American_Eagle    </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 7                </td><td>17                </td><td>7                 </td><td>1917              </td><td>NA                </td><td>MQ                </td><td>3717              </td><td>N503MQ            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ORD               </td><td> 925              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>American_Eagle    </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>29                </td><td>4                 </td><td>1639              </td><td>NA                </td><td>OO                </td><td>2062              </td><td>N724SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ATL               </td><td> 689              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>SkyWest           </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 5                </td><td> 9                </td><td>1                 </td><td> 715              </td><td>NA                </td><td>OO                </td><td>1177              </td><td>N758SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DTW               </td><td>1076              </td><td>NA                </td><td>17                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 2                </td><td>21                </td><td>1                 </td><td>2257              </td><td>NA                </td><td>OO                </td><td>1111              </td><td>N778SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>AUS               </td><td> 140              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 6                </td><td>20                </td><td>1                 </td><td>1037              </td><td>NA                </td><td>OO                </td><td>5817              </td><td>N443SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>CLT               </td><td> 913              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 4                </td><td> 7                </td><td>4                 </td><td>2118              </td><td>NA                </td><td>OO                </td><td>5819              </td><td>N916SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>MAF               </td><td> 429              </td><td>NA                </td><td>NA                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>2011              </td><td> 8                </td><td>18                </td><td>4                 </td><td>1809              </td><td>NA                </td><td>OO                </td><td>2028              </td><td>N758SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>OMA               </td><td> 781              </td><td>NA                </td><td>32                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>SkyWest           </td><td>weather           </td></tr>
	<tr><td>2011              </td><td> 9                </td><td>16                </td><td>5                 </td><td>1807              </td><td>NA                </td><td>OO                </td><td>2009              </td><td>N794SK            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>DFW               </td><td> 224              </td><td>NA                </td><td>10                </td><td>1                 </td><td>B                 </td><td>0                 </td><td>SkyWest           </td><td>weather           </td></tr>
	<tr><td>2011              </td><td>12                </td><td>28                </td><td>3                 </td><td>1827              </td><td>NA                </td><td>OO                </td><td>5244              </td><td>N912SW            </td><td>NA                </td><td>...               </td><td>IAH               </td><td>ELP               </td><td> 667              </td><td>NA                </td><td>20                </td><td>1                 </td><td>A                 </td><td>0                 </td><td>SkyWest           </td><td>carrier           </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>   </td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>2011      </td><td>12        </td><td> 1        </td><td>4         </td><td> 541      </td><td>NA        </td><td>US        </td><td> 282      </td><td>N840AW    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>PHX       </td><td>1009      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>US_Airways</td><td>carrier   </td></tr>
	<tr><td>2011      </td><td> 1        </td><td>11        </td><td>2         </td><td>1100      </td><td>NA        </td><td>US        </td><td> 944      </td><td>N452UW    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>CLT       </td><td> 913      </td><td>NA        </td><td>NA        </td><td>1         </td><td>B         </td><td>0         </td><td>US_Airways</td><td>weather   </td></tr>
	<tr><td>2011      </td><td> 7        </td><td> 7        </td><td>4         </td><td>1245      </td><td>NA        </td><td>US        </td><td>1170      </td><td>N456UW    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>CLT       </td><td> 912      </td><td>NA        </td><td>15        </td><td>1         </td><td>A         </td><td>0         </td><td>US_Airways</td><td>carrier   </td></tr>
	<tr><td>2011      </td><td> 1        </td><td>17        </td><td>1         </td><td> 831      </td><td>NA        </td><td>WN        </td><td>   1      </td><td>N714CB    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>HRL       </td><td> 276      </td><td>NA        </td><td> 8        </td><td>1         </td><td>B         </td><td>0         </td><td>Southwest </td><td>weather   </td></tr>
	<tr><td>2011      </td><td>10        </td><td>12        </td><td>3         </td><td> 758      </td><td>NA        </td><td>WN        </td><td>   8      </td><td>N405WN    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>DAL       </td><td> 239      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>Southwest </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td> 6        </td><td>26        </td><td>7         </td><td>1629      </td><td>NA        </td><td>WN        </td><td>  42      </td><td>N640SW    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>DAL       </td><td> 239      </td><td>NA        </td><td>13        </td><td>1         </td><td>A         </td><td>0         </td><td>Southwest </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>10        </td><td>24        </td><td>1         </td><td> 631      </td><td>NA        </td><td>WN        </td><td>   2      </td><td>N359SW    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>DAL       </td><td> 239      </td><td>NA        </td><td> 6        </td><td>1         </td><td>A         </td><td>0         </td><td>Southwest </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td> 4        </td><td>21        </td><td>4         </td><td> 953      </td><td>NA        </td><td>WN        </td><td>3840      </td><td>N455WN    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>SAT       </td><td> 192      </td><td>NA        </td><td> 5        </td><td>1         </td><td>A         </td><td>0         </td><td>Southwest </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td> 4        </td><td> 8        </td><td>5         </td><td>1608      </td><td>NA        </td><td>WN        </td><td>   4      </td><td>N365SW    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>DAL       </td><td> 239      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>Southwest </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td> 1        </td><td>17        </td><td>1         </td><td> 916      </td><td>NA        </td><td>XE        </td><td>3068      </td><td>N13936    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>HRL       </td><td> 295      </td><td>NA        </td><td>NA        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td>12        </td><td>25        </td><td>7         </td><td>1652      </td><td>NA        </td><td>XE        </td><td>4375      </td><td>N12946    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>MOB       </td><td> 427      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>ExpressJet</td><td>carrier   </td></tr>
	<tr><td>2011      </td><td> 8        </td><td>26        </td><td>5         </td><td>1054      </td><td>NA        </td><td>XE        </td><td>2397      </td><td>N11192    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>CHS       </td><td> 925      </td><td>NA        </td><td>NA        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td> 4        </td><td>25        </td><td>1         </td><td>1131      </td><td>NA        </td><td>XE        </td><td>2826      </td><td>N15926    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>DAL       </td><td> 217      </td><td>NA        </td><td>13        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td> 2        </td><td> 2        </td><td>3         </td><td> 802      </td><td>NA        </td><td>XE        </td><td>2189      </td><td>N17928    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>DAL       </td><td> 217      </td><td>NA        </td><td>NA        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td> 2        </td><td> 9        </td><td>3         </td><td> 904      </td><td>NA        </td><td>XE        </td><td>2605      </td><td>N15941    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>DAL       </td><td> 217      </td><td>NA        </td><td>NA        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td> 4        </td><td>11        </td><td>1         </td><td>1400      </td><td>NA        </td><td>XE        </td><td>2769      </td><td>N13970    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>ELP       </td><td> 667      </td><td>NA        </td><td>26        </td><td>1         </td><td>A         </td><td>0         </td><td>ExpressJet</td><td>carrier   </td></tr>
	<tr><td>2011      </td><td> 1        </td><td>19        </td><td>3         </td><td>1811      </td><td>NA        </td><td>XE        </td><td>2376      </td><td>N15932    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>ICT       </td><td> 542      </td><td>NA        </td><td>NA        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td>11        </td><td>15        </td><td>2         </td><td>1452      </td><td>NA        </td><td>XE        </td><td>4450      </td><td>N13903    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>LFT       </td><td> 201      </td><td>NA        </td><td>NA        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td>12        </td><td>31        </td><td>6         </td><td>1738      </td><td>NA        </td><td>XE        </td><td>4662      </td><td>N16944    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>PNS       </td><td> 489      </td><td>NA        </td><td>14        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td>12        </td><td>21        </td><td>3         </td><td>2159      </td><td>NA        </td><td>XE        </td><td>4595      </td><td>N16149    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>VPS       </td><td> 528      </td><td>NA        </td><td> 9        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td> 1        </td><td> 7        </td><td>5         </td><td>2028      </td><td>NA        </td><td>XE        </td><td>3050      </td><td>N15912    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>JAX       </td><td> 817      </td><td>NA        </td><td>19        </td><td>1         </td><td>A         </td><td>0         </td><td>ExpressJet</td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>11        </td><td> 8        </td><td>2         </td><td>1855      </td><td>NA        </td><td>XE        </td><td>4343      </td><td>N16944    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>LFT       </td><td> 201      </td><td>NA        </td><td>NA        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td>12        </td><td>11        </td><td>7         </td><td>2245      </td><td>NA        </td><td>XE        </td><td>4342      </td><td>N11535    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>LRD       </td><td> 301      </td><td>NA        </td><td> 8        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td> 9        </td><td>29        </td><td>4         </td><td>1800      </td><td>NA        </td><td>XE        </td><td>2125      </td><td>N14570    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>MOB       </td><td> 427      </td><td>NA        </td><td>NA        </td><td>1         </td><td>C         </td><td>0         </td><td>ExpressJet</td><td>FFA       </td></tr>
	<tr><td>2011      </td><td> 4        </td><td>25        </td><td>1         </td><td>1257      </td><td>NA        </td><td>XE        </td><td>2964      </td><td>N13936    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>DFW       </td><td> 224      </td><td>NA        </td><td>NA        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td> 4        </td><td> 4        </td><td>1         </td><td>1854      </td><td>NA        </td><td>XE        </td><td>2748      </td><td>N13968    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>MOB       </td><td> 427      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>ExpressJet</td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td>13        </td><td>2         </td><td>2324      </td><td>NA        </td><td>XE        </td><td>4088      </td><td>N14938    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>LFT       </td><td> 201      </td><td>NA        </td><td> 8        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td> 4        </td><td> 4        </td><td>1         </td><td>1946      </td><td>NA        </td><td>XE        </td><td>2700      </td><td>N15973    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>ATL       </td><td> 689      </td><td>NA        </td><td>19        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td> 8        </td><td>14        </td><td>7         </td><td>1938      </td><td>NA        </td><td>XE        </td><td>3019      </td><td>N13994    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>CMH       </td><td> 986      </td><td>NA        </td><td>NA        </td><td>1         </td><td>B         </td><td>0         </td><td>ExpressJet</td><td>weather   </td></tr>
	<tr><td>2011      </td><td> 7        </td><td>21        </td><td>4         </td><td>2059      </td><td>NA        </td><td>XE        </td><td>2705      </td><td>N15926    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>GPT       </td><td> 376      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>ExpressJet</td><td>carrier   </td></tr>
</tbody>
</table>




```R
# Arrange according to carrier and decreasing departure delays
arrange(hflights, UniqueCarrier, desc(DepDelay))
```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
	<tr><td>2011    </td><td>12      </td><td>12      </td><td>1       </td><td> 650    </td><td> 808    </td><td>AA      </td><td>1740    </td><td>N473AA  </td><td> 78     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>14      </td><td>15      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>11      </td><td>19      </td><td>6       </td><td>1752    </td><td>1910    </td><td>AA      </td><td>1903    </td><td>N495AA  </td><td> 78     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 7      </td><td>31      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>12      </td><td>22      </td><td>4       </td><td>1728    </td><td>1848    </td><td>AA      </td><td>1903    </td><td>N580AA  </td><td> 80     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 8      </td><td>32      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>10      </td><td>23      </td><td>7       </td><td>2305    </td><td>   2    </td><td>AA      </td><td> 742    </td><td>N548AA  </td><td> 57     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 5      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 9      </td><td>27      </td><td>2       </td><td>1206    </td><td>1300    </td><td>AA      </td><td>1948    </td><td>N4YUAA  </td><td> 54     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>10      </td><td> 7      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 3      </td><td>17      </td><td>4       </td><td>1647    </td><td>1747    </td><td>AA      </td><td>1505    </td><td>N584AA  </td><td> 60     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 7      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 6      </td><td>21      </td><td>2       </td><td> 955    </td><td>1315    </td><td>AA      </td><td> 466    </td><td>N3FTAA  </td><td>140     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td>964     </td><td> 9      </td><td>11      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 5      </td><td>20      </td><td>5       </td><td>2359    </td><td> 130    </td><td>AA      </td><td> 426    </td><td>N565AA  </td><td> 91     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 8      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 4      </td><td>19      </td><td>2       </td><td>2023    </td><td>2142    </td><td>AA      </td><td>1925    </td><td>N467AA  </td><td> 79     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>11      </td><td>18      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 5      </td><td>12      </td><td>4       </td><td>2133    </td><td>  53    </td><td>AA      </td><td>1294    </td><td>N3AYAA  </td><td>140     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td>964     </td><td> 5      </td><td>14      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>10      </td><td> 9      </td><td>7       </td><td>1805    </td><td>1930    </td><td>AA      </td><td> 742    </td><td>N555AA  </td><td> 85     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td>22      </td><td>18      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 4      </td><td>14      </td><td>4       </td><td>2117    </td><td>  21    </td><td>AA      </td><td>1294    </td><td>N3ENAA  </td><td>124     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td>964     </td><td> 5      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 6      </td><td>24      </td><td>5       </td><td>2137    </td><td>  56    </td><td>AA      </td><td>1294    </td><td>N3GCAA  </td><td>139     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td>964     </td><td> 3      </td><td>17      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 8      </td><td>19      </td><td>5       </td><td>1340    </td><td>1716    </td><td>AA      </td><td>1700    </td><td>N3FLAA  </td><td>156     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td>964     </td><td>21      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 6      </td><td>25      </td><td>6       </td><td> 906    </td><td>1229    </td><td>AA      </td><td> 466    </td><td>N3BSAA  </td><td>143     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td>964     </td><td> 8      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 4      </td><td>24      </td><td>7       </td><td>2304    </td><td>   3    </td><td>AA      </td><td> 426    </td><td>N594AA  </td><td> 59     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 5      </td><td> 7      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 2      </td><td> 4      </td><td>5       </td><td>2049    </td><td>2353    </td><td>AA      </td><td>1294    </td><td>N3CXAA  </td><td>124     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td>964     </td><td> 7      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>12      </td><td>16      </td><td>5       </td><td>2025    </td><td>2347    </td><td>AA      </td><td>1294    </td><td>N3ECAA  </td><td>142     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td>964     </td><td> 3      </td><td>27      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 5      </td><td>25      </td><td>3       </td><td>1918    </td><td>2039    </td><td>AA      </td><td>1925    </td><td>N526AA  </td><td> 81     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 5      </td><td>22      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 8      </td><td>24      </td><td>3       </td><td>1432    </td><td>1540    </td><td>AA      </td><td>1848    </td><td>N535AA  </td><td> 68     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 4      </td><td>21      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 4      </td><td> 4      </td><td>1       </td><td>1135    </td><td>1323    </td><td>AA      </td><td> 493    </td><td>N426AA  </td><td>108     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 9      </td><td>44      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>10      </td><td>17      </td><td>1       </td><td>1250    </td><td>1622    </td><td>AA      </td><td>1946    </td><td>N3DRAA  </td><td>152     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td>964     </td><td>12      </td><td>24      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 8      </td><td> 7      </td><td>7       </td><td>2239    </td><td>2331    </td><td>AA      </td><td> 426    </td><td>N558AA  </td><td> 52     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 2      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 5      </td><td>28      </td><td>6       </td><td>1630    </td><td>1725    </td><td>AA      </td><td>1566    </td><td>N536AA  </td><td> 55     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 5      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 7      </td><td>22      </td><td>5       </td><td>1139    </td><td>1247    </td><td>AA      </td><td>1995    </td><td>N578AA  </td><td> 68     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 5      </td><td>22      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 4      </td><td>17      </td><td>7       </td><td>2008    </td><td>2309    </td><td>AA      </td><td>1294    </td><td>N3DEAA  </td><td>121     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td>964     </td><td> 4      </td><td>10      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>11      </td><td>18      </td><td>5       </td><td>1954    </td><td>2310    </td><td>AA      </td><td>1294    </td><td>N3DNAA  </td><td>136     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td>964     </td><td>13      </td><td> 9      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 4      </td><td>28      </td><td>4       </td><td>1843    </td><td>1949    </td><td>AA      </td><td>1925    </td><td>N528AA  </td><td> 66     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 5      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td>10      </td><td>24      </td><td>1       </td><td>1356    </td><td>1455    </td><td>AA      </td><td>1848    </td><td>N482AA  </td><td> 59     </td><td>...     </td><td>IAH     </td><td>DFW     </td><td>224     </td><td> 5      </td><td>12      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>2011    </td><td> 6      </td><td>13      </td><td>1       </td><td>2014    </td><td>2328    </td><td>AA      </td><td>1294    </td><td>N3FBAA  </td><td>134     </td><td>...     </td><td>IAH     </td><td>MIA     </td><td>964     </td><td> 7      </td><td>13      </td><td>0       </td><td>        </td><td>0       </td><td>American</td><td>NA      </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>   </td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>2011   </td><td>4      </td><td> 9     </td><td>6      </td><td> 515   </td><td> 855   </td><td>YV     </td><td>2780   </td><td>N926LR </td><td>160    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>15     </td><td>18     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>4      </td><td>12     </td><td>2      </td><td> 515   </td><td> 851   </td><td>YV     </td><td>2780   </td><td>N926LR </td><td>156    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>13     </td><td>13     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>4      </td><td>14     </td><td>4      </td><td> 515   </td><td> 824   </td><td>YV     </td><td>2780   </td><td>N924FJ </td><td>129    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>12     </td><td> 8     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>4      </td><td>22     </td><td>5      </td><td> 515   </td><td> 837   </td><td>YV     </td><td>2780   </td><td>N921FJ </td><td>142    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>13     </td><td>12     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>4      </td><td>23     </td><td>6      </td><td>1325   </td><td>1655   </td><td>YV     </td><td>2782   </td><td>N916FJ </td><td>150    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td> 9     </td><td>17     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>4      </td><td>24     </td><td>7      </td><td> 515   </td><td> 846   </td><td>YV     </td><td>2780   </td><td>N920FJ </td><td>151    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>19     </td><td>11     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>4      </td><td>25     </td><td>1      </td><td> 515   </td><td> 852   </td><td>YV     </td><td>2780   </td><td>N905FJ </td><td>157    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>13     </td><td>15     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>4      </td><td>28     </td><td>4      </td><td> 515   </td><td> 833   </td><td>YV     </td><td>2780   </td><td>N942LR </td><td>138    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>12     </td><td>11     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>7      </td><td> 3     </td><td>7      </td><td>1520   </td><td>1855   </td><td>YV     </td><td>2636   </td><td>N918FJ </td><td>155    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 912   </td><td>14     </td><td>17     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>7      </td><td>24     </td><td>7      </td><td>1520   </td><td>1855   </td><td>YV     </td><td>2636   </td><td>N929LR </td><td>155    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 912   </td><td>10     </td><td>16     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>2      </td><td>19     </td><td>6      </td><td>1004   </td><td>1355   </td><td>YV     </td><td>7290   </td><td>N508MJ </td><td>171    </td><td>...    </td><td>IAH    </td><td>IAD    </td><td>1190   </td><td>14     </td><td>13     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>5      </td><td>22     </td><td>7      </td><td>1524   </td><td>1846   </td><td>YV     </td><td>2636   </td><td>N919FJ </td><td>142    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>15     </td><td>11     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>5      </td><td>29     </td><td>7      </td><td>1524   </td><td>1900   </td><td>YV     </td><td>2636   </td><td>N918FJ </td><td>156    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>17     </td><td>14     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>7      </td><td>31     </td><td>7      </td><td>1519   </td><td>1933   </td><td>YV     </td><td>2636   </td><td>N927LR </td><td>194    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 912   </td><td>23     </td><td>39     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>3      </td><td>19     </td><td>6      </td><td>1453   </td><td>1541   </td><td>YV     </td><td>2699   </td><td>N907FJ </td><td>168    </td><td>...    </td><td>IAH    </td><td>PHX    </td><td>1009   </td><td> 9     </td><td> 9     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>4      </td><td>20     </td><td>3      </td><td>1323   </td><td>1649   </td><td>YV     </td><td>2782   </td><td>N908FJ </td><td>146    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td> 9     </td><td>14     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>6      </td><td>19     </td><td>7      </td><td>1518   </td><td>1845   </td><td>YV     </td><td>2636   </td><td>N932LR </td><td>147    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>24     </td><td>10     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>3      </td><td> 5     </td><td>6      </td><td>1002   </td><td>1358   </td><td>YV     </td><td>7231   </td><td>N501MJ </td><td>176    </td><td>...    </td><td>IAH    </td><td>IAD    </td><td>1190   </td><td> 4     </td><td>30     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>4      </td><td> 9     </td><td>6      </td><td>1322   </td><td>1700   </td><td>YV     </td><td>2782   </td><td>N911FJ </td><td>158    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>17     </td><td>21     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>2      </td><td>26     </td><td>6      </td><td>1001   </td><td>1335   </td><td>YV     </td><td>7290   </td><td>N521LR </td><td>154    </td><td>...    </td><td>IAH    </td><td>IAD    </td><td>1190   </td><td> 4     </td><td>16     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>4      </td><td>19     </td><td>2      </td><td> 511   </td><td> 840   </td><td>YV     </td><td>2780   </td><td>N956LR </td><td>149    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td> 9     </td><td>15     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>6      </td><td> 5     </td><td>7      </td><td>1516   </td><td>1937   </td><td>YV     </td><td>2636   </td><td>N922FJ </td><td>201    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>77     </td><td> 9     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>6      </td><td>26     </td><td>7      </td><td>1516   </td><td>1847   </td><td>YV     </td><td>2636   </td><td>N932LR </td><td>151    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td> 9     </td><td>13     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>8      </td><td>14     </td><td>7      </td><td>1516   </td><td>1925   </td><td>YV     </td><td>2636   </td><td>N938LR </td><td>189    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 912   </td><td> 5     </td><td>55     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>4      </td><td>17     </td><td>7      </td><td> 510   </td><td> 835   </td><td>YV     </td><td>2780   </td><td>N923FJ </td><td>145    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>12     </td><td>22     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>4      </td><td>18     </td><td>1      </td><td> 510   </td><td> 830   </td><td>YV     </td><td>2780   </td><td>N956LR </td><td>140    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td> 7     </td><td>14     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>4      </td><td>21     </td><td>4      </td><td> 510   </td><td> 832   </td><td>YV     </td><td>2780   </td><td>N918FJ </td><td>142    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>14     </td><td>11     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>5      </td><td> 8     </td><td>7      </td><td>1519   </td><td>1858   </td><td>YV     </td><td>2636   </td><td>N913FJ </td><td>159    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>31     </td><td>13     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>7      </td><td>10     </td><td>7      </td><td>1514   </td><td>1849   </td><td>YV     </td><td>2636   </td><td>N904FJ </td><td>155    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 912   </td><td>14     </td><td>15     </td><td>0      </td><td>       </td><td>0      </td><td>Mesa   </td><td>NA     </td></tr>
	<tr><td>2011   </td><td>5      </td><td>15     </td><td>7      </td><td>  NA   </td><td>  NA   </td><td>YV     </td><td>2636   </td><td>N933LR </td><td> NA    </td><td>...    </td><td>IAH    </td><td>CLT    </td><td> 913   </td><td>NA     </td><td>NA     </td><td>1      </td><td>A      </td><td>0      </td><td>Mesa   </td><td>carrier</td></tr>
</tbody>
</table>




```R
# Arrange flights by total delay (normal order).
arrange(hflights, DepDelay + ArrDelay)
```


<table>
<thead><tr><th scope=col>Year</th><th scope=col>Month</th><th scope=col>DayofMonth</th><th scope=col>DayOfWeek</th><th scope=col>DepTime</th><th scope=col>ArrTime</th><th scope=col>UniqueCarrier</th><th scope=col>FlightNum</th><th scope=col>TailNum</th><th scope=col>ActualElapsedTime</th><th scope=col>...</th><th scope=col>Origin</th><th scope=col>Dest</th><th scope=col>Distance</th><th scope=col>TaxiIn</th><th scope=col>TaxiOut</th><th scope=col>Cancelled</th><th scope=col>CancellationCode</th><th scope=col>Diverted</th><th scope=col>Carrier</th><th scope=col>Code</th></tr></thead>
<tbody>
	<tr><td>2011       </td><td> 7         </td><td> 3         </td><td>7          </td><td>1914       </td><td>2039       </td><td>XE         </td><td>2804       </td><td>N12157     </td><td> 85        </td><td>...        </td><td>IAH        </td><td>MEM        </td><td> 468       </td><td> 4         </td><td>15         </td><td>0          </td><td>           </td><td>0          </td><td>ExpressJet </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 8         </td><td>31         </td><td>3          </td><td> 934       </td><td>1039       </td><td>OO         </td><td>2040       </td><td>N783SK     </td><td>185        </td><td>...        </td><td>IAH        </td><td>BFL        </td><td>1428       </td><td> 3         </td><td>10         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 8         </td><td>21         </td><td>7          </td><td> 935       </td><td>1039       </td><td>OO         </td><td>2001       </td><td>N767SK     </td><td>184        </td><td>...        </td><td>IAH        </td><td>BFL        </td><td>1428       </td><td> 3         </td><td>10         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 8         </td><td>28         </td><td>7          </td><td>2059       </td><td>2206       </td><td>OO         </td><td>2003       </td><td>N783SK     </td><td>187        </td><td>...        </td><td>IAH        </td><td>BFL        </td><td>1428       </td><td> 5         </td><td>11         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 8         </td><td>29         </td><td>1          </td><td> 935       </td><td>1041       </td><td>OO         </td><td>2040       </td><td>N767SK     </td><td>186        </td><td>...        </td><td>IAH        </td><td>BFL        </td><td>1428       </td><td> 4         </td><td>13         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>25         </td><td>7          </td><td> 741       </td><td> 926       </td><td>OO         </td><td>4591       </td><td>N814SK     </td><td>165        </td><td>...        </td><td>IAH        </td><td>SLC        </td><td>1195       </td><td> 4         </td><td>14         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 1         </td><td>30         </td><td>7          </td><td> 620       </td><td> 812       </td><td>OO         </td><td>4461       </td><td>N804SK     </td><td>172        </td><td>...        </td><td>IAH        </td><td>SLC        </td><td>1195       </td><td> 5         </td><td>11         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 8         </td><td> 3         </td><td>3          </td><td>1741       </td><td>1810       </td><td>XE         </td><td>2603       </td><td>N11107     </td><td> 89        </td><td>...        </td><td>IAH        </td><td>HOB        </td><td> 501       </td><td> 5         </td><td>11         </td><td>0          </td><td>           </td><td>0          </td><td>ExpressJet </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 8         </td><td> 4         </td><td>4          </td><td> 930       </td><td>1041       </td><td>OO         </td><td>1171       </td><td>N715SK     </td><td>191        </td><td>...        </td><td>IAH        </td><td>BFL        </td><td>1428       </td><td> 4         </td><td>10         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 8         </td><td>18         </td><td>4          </td><td> 939       </td><td>1043       </td><td>OO         </td><td>2001       </td><td>N783SK     </td><td>184        </td><td>...        </td><td>IAH        </td><td>BFL        </td><td>1428       </td><td> 4         </td><td> 8         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 8         </td><td>26         </td><td>5          </td><td>2107       </td><td>2205       </td><td>OO         </td><td>2003       </td><td>N713SK     </td><td>178        </td><td>...        </td><td>IAH        </td><td>BFL        </td><td>1428       </td><td> 5         </td><td>10         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 9         </td><td>11         </td><td>7          </td><td>1451       </td><td>1857       </td><td>B6         </td><td> 622       </td><td>N658JB     </td><td>186        </td><td>...        </td><td>HOU        </td><td>JFK        </td><td>1428       </td><td> 6         </td><td>19         </td><td>0          </td><td>           </td><td>0          </td><td>JetBlue    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>24         </td><td>6          </td><td>1112       </td><td>1314       </td><td>OO         </td><td>5440       </td><td>N728SK     </td><td>182        </td><td>...        </td><td>IAH        </td><td>ASE        </td><td> 913       </td><td> 3         </td><td>48         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 9         </td><td>13         </td><td>2          </td><td>1838       </td><td>1933       </td><td>XE         </td><td>2376       </td><td>N15932     </td><td> 55        </td><td>...        </td><td>IAH        </td><td>MLU        </td><td> 262       </td><td> 4         </td><td> 9         </td><td>0          </td><td>           </td><td>0          </td><td>ExpressJet </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>24         </td><td>6          </td><td>2129       </td><td>2337       </td><td>CO         </td><td>1552       </td><td>N37437     </td><td>248        </td><td>...        </td><td>IAH        </td><td>SEA        </td><td>1874       </td><td> 5         </td><td> 9         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 8         </td><td>16         </td><td>2          </td><td> 928       </td><td>1207       </td><td>CO         </td><td>   1       </td><td>N69059     </td><td>459        </td><td>...        </td><td>IAH        </td><td>HNL        </td><td>3904       </td><td> 7         </td><td>11         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 5         </td><td>29         </td><td>7          </td><td> 627       </td><td> 812       </td><td>OO         </td><td>4484       </td><td>N822SK     </td><td>165        </td><td>...        </td><td>IAH        </td><td>SLC        </td><td>1195       </td><td> 4         </td><td> 8         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 9         </td><td>14         </td><td>3          </td><td>1840       </td><td>1933       </td><td>XE         </td><td>4645       </td><td>N14933     </td><td> 53        </td><td>...        </td><td>IAH        </td><td>MLU        </td><td> 262       </td><td> 4         </td><td> 9         </td><td>0          </td><td>           </td><td>0          </td><td>ExpressJet </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 1         </td><td>19         </td><td>3          </td><td> 754       </td><td> 837       </td><td>XE         </td><td>2001       </td><td>N16951     </td><td> 43        </td><td>...        </td><td>IAH        </td><td>LFT        </td><td> 201       </td><td> 4         </td><td> 7         </td><td>0          </td><td>           </td><td>0          </td><td>ExpressJet </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 8         </td><td>30         </td><td>2          </td><td> 938       </td><td>1049       </td><td>OO         </td><td>2040       </td><td>N779SK     </td><td>191        </td><td>...        </td><td>IAH        </td><td>BFL        </td><td>1428       </td><td> 3         </td><td>11         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>11         </td><td>24         </td><td>4          </td><td>1720       </td><td>2022       </td><td>AA         </td><td>1294       </td><td>N3GVAA     </td><td>122        </td><td>...        </td><td>IAH        </td><td>MIA        </td><td> 964       </td><td> 4         </td><td> 7         </td><td>0          </td><td>           </td><td>0          </td><td>American   </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>11         </td><td>24         </td><td>4          </td><td>2100       </td><td>2312       </td><td>CO         </td><td>1616       </td><td>N27205     </td><td>132        </td><td>...        </td><td>IAH        </td><td>ORD        </td><td> 925       </td><td> 4         </td><td>11         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 8         </td><td>27         </td><td>6          </td><td> 938       </td><td>1040       </td><td>OO         </td><td>2001       </td><td>N744SK     </td><td>182        </td><td>...        </td><td>IAH        </td><td>BFL        </td><td>1428       </td><td> 4         </td><td>16         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td> 4         </td><td>7          </td><td> 946       </td><td>1056       </td><td>XE         </td><td>6105       </td><td>N23139     </td><td>130        </td><td>...        </td><td>IAH        </td><td>DEN        </td><td> 862       </td><td> 8         </td><td>10         </td><td>0          </td><td>           </td><td>0          </td><td>ExpressJet </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 6         </td><td>11         </td><td>6          </td><td>1753       </td><td>2106       </td><td>AA         </td><td>1294       </td><td>N3BUAA     </td><td>133        </td><td>...        </td><td>IAH        </td><td>MIA        </td><td> 964       </td><td> 4         </td><td>11         </td><td>0          </td><td>           </td><td>0          </td><td>American   </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 7         </td><td>17         </td><td>7          </td><td>2059       </td><td>2210       </td><td>OO         </td><td>1172       </td><td>N779SK     </td><td>191        </td><td>...        </td><td>IAH        </td><td>BFL        </td><td>1428       </td><td> 5         </td><td>16         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td> 8         </td><td>20         </td><td>6          </td><td> 936       </td><td>1043       </td><td>OO         </td><td>2001       </td><td>N776SK     </td><td>187        </td><td>...        </td><td>IAH        </td><td>BFL        </td><td>1428       </td><td> 4         </td><td>13         </td><td>0          </td><td>           </td><td>0          </td><td>SkyWest    </td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>24         </td><td>6          </td><td>1015       </td><td>1435       </td><td>CO         </td><td>1134       </td><td>N16646     </td><td>200        </td><td>...        </td><td>IAH        </td><td>BOS        </td><td>1597       </td><td> 9         </td><td>19         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td>24         </td><td>6          </td><td>2051       </td><td>  30       </td><td>CO         </td><td>1452       </td><td>N38424     </td><td>159        </td><td>...        </td><td>IAH        </td><td>EWR        </td><td>1400       </td><td> 9         </td><td> 7         </td><td>0          </td><td>           </td><td>0          </td><td>Continental</td><td>NA         </td></tr>
	<tr><td>2011       </td><td>12         </td><td> 3         </td><td>6          </td><td>1913       </td><td>2106       </td><td>UA         </td><td> 473       </td><td>N460UA     </td><td>233        </td><td>...        </td><td>IAH        </td><td>SFO        </td><td>1635       </td><td>10         </td><td>16         </td><td>0          </td><td>           </td><td>0          </td><td>United     </td><td>NA         </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>   </td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>2011      </td><td>12        </td><td>21        </td><td>3         </td><td>  NA      </td><td>  NA      </td><td>OO        </td><td>5237      </td><td>N958SW    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>DAL       </td><td> 216      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>SkyWest   </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td>11        </td><td>7         </td><td>1942      </td><td>  58      </td><td>OO        </td><td>5199      </td><td>N794SK    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>MSP       </td><td>1034      </td><td> 6        </td><td>14        </td><td>0         </td><td>          </td><td>1         </td><td>SkyWest   </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>31        </td><td>6         </td><td>  NA      </td><td>  NA      </td><td>OO        </td><td>5193      </td><td>N727SK    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>OKC       </td><td> 395      </td><td>NA        </td><td>NA        </td><td>1         </td><td>B         </td><td>0         </td><td>SkyWest   </td><td>weather   </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 4        </td><td>7         </td><td>2054      </td><td>  NA      </td><td>OO        </td><td>5194      </td><td>N738SK    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>ORF       </td><td>1201      </td><td>NA        </td><td>19        </td><td>0         </td><td>          </td><td>1         </td><td>SkyWest   </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>12        </td><td>1         </td><td>  NA      </td><td>  NA      </td><td>OO        </td><td>5162      </td><td>N702SK    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>OMA       </td><td> 781      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>SkyWest   </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 4        </td><td>7         </td><td>  NA      </td><td>  NA      </td><td>OO        </td><td>5162      </td><td>N768SK    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>OMA       </td><td> 781      </td><td>NA        </td><td>NA        </td><td>1         </td><td>B         </td><td>0         </td><td>SkyWest   </td><td>weather   </td></tr>
	<tr><td>2011      </td><td>12        </td><td>12        </td><td>1         </td><td>1854      </td><td>2351      </td><td>OO        </td><td>5170      </td><td>N702SK    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>MKE       </td><td> 984      </td><td> 5        </td><td>24        </td><td>0         </td><td>          </td><td>1         </td><td>SkyWest   </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>31        </td><td>6         </td><td>  NA      </td><td>  NA      </td><td>OO        </td><td>5173      </td><td>N793SK    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>DFW       </td><td> 224      </td><td>NA        </td><td>NA        </td><td>1         </td><td>C         </td><td>0         </td><td>SkyWest   </td><td>FFA       </td></tr>
	<tr><td>2011      </td><td>12        </td><td>12        </td><td>1         </td><td>  NA      </td><td>  NA      </td><td>OO        </td><td>5176      </td><td>N794SK    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>CMH       </td><td> 986      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>SkyWest   </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 1        </td><td>4         </td><td>  NA      </td><td>  NA      </td><td>OO        </td><td>5218      </td><td>N770SK    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>MCI       </td><td> 643      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>SkyWest   </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td>12        </td><td>1         </td><td> 733      </td><td>1153      </td><td>OO        </td><td>5218      </td><td>N794SK    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>MCI       </td><td> 643      </td><td> 3        </td><td>14        </td><td>0         </td><td>          </td><td>1         </td><td>SkyWest   </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>12        </td><td>1         </td><td>1757      </td><td>2306      </td><td>OO        </td><td>5223      </td><td>N794SK    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>TUS       </td><td> 936      </td><td> 7        </td><td>25        </td><td>0         </td><td>          </td><td>1         </td><td>SkyWest   </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>29        </td><td>4         </td><td> 934      </td><td>1656      </td><td>OO        </td><td>5226      </td><td>N912SW    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>ATL       </td><td> 689      </td><td>10        </td><td>57        </td><td>0         </td><td>          </td><td>1         </td><td>SkyWest   </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>31        </td><td>6         </td><td> 932      </td><td>  NA      </td><td>OO        </td><td>5337      </td><td>N758SK    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>ASE       </td><td> 913      </td><td>NA        </td><td>12        </td><td>0         </td><td>          </td><td>1         </td><td>SkyWest   </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td>11        </td><td>7         </td><td>1303      </td><td>  NA      </td><td>UA        </td><td> 399      </td><td>N528UA    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>DEN       </td><td> 862      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>United    </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td>27        </td><td>2         </td><td>  NA      </td><td>  NA      </td><td>UA        </td><td> 855      </td><td>          </td><td>NA        </td><td>...       </td><td>IAH       </td><td>SFO       </td><td>1635      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>United    </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 1        </td><td>4         </td><td> 541      </td><td>  NA      </td><td>US        </td><td> 282      </td><td>N840AW    </td><td>NA        </td><td>...       </td><td>IAH       </td><td>PHX       </td><td>1009      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>US_Airways</td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 9        </td><td>5         </td><td>  NA      </td><td>  NA      </td><td>US        </td><td>1828      </td><td>          </td><td>NA        </td><td>...       </td><td>IAH       </td><td>PHL       </td><td>1325      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>US_Airways</td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td>27        </td><td>2         </td><td>  NA      </td><td>  NA      </td><td>US        </td><td>1170      </td><td>          </td><td>NA        </td><td>...       </td><td>IAH       </td><td>CLT       </td><td> 912      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>US_Airways</td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td>30        </td><td>5         </td><td>  NA      </td><td>  NA      </td><td>US        </td><td> 403      </td><td>          </td><td>NA        </td><td>...       </td><td>IAH       </td><td>PHX       </td><td>1009      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>US_Airways</td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 1        </td><td>4         </td><td>  NA      </td><td>  NA      </td><td>WN        </td><td>   9      </td><td>N230WN    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>HRL       </td><td> 277      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>Southwest </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 2        </td><td>5         </td><td>  NA      </td><td>  NA      </td><td>WN        </td><td>   6      </td><td>N946WN    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>DAL       </td><td> 239      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>Southwest </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 2        </td><td>5         </td><td>  NA      </td><td>  NA      </td><td>WN        </td><td>  16      </td><td>N281WN    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>DAL       </td><td> 239      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>Southwest </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 2        </td><td>5         </td><td>  NA      </td><td>  NA      </td><td>WN        </td><td>1167      </td><td>N510SW    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>OAK       </td><td>1642      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>Southwest </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 3        </td><td>6         </td><td>  NA      </td><td>  NA      </td><td>WN        </td><td>1491      </td><td>N348SW    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>DAL       </td><td> 239      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>Southwest </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 4        </td><td>7         </td><td>1050      </td><td>1843      </td><td>WN        </td><td>1797      </td><td>N791SW    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>BWI       </td><td>1246      </td><td> 6        </td><td>11        </td><td>0         </td><td>          </td><td>1         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 4        </td><td>7         </td><td>  NA      </td><td>  NA      </td><td>WN        </td><td>2387      </td><td>N928WN    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>DAL       </td><td> 239      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>Southwest </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 5        </td><td>1         </td><td>  NA      </td><td>  NA      </td><td>WN        </td><td>  38      </td><td>N604SW    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>DAL       </td><td> 239      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>Southwest </td><td>carrier   </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 5        </td><td>1         </td><td> 819      </td><td>1221      </td><td>WN        </td><td> 269      </td><td>N665WN    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>JAN       </td><td> 359      </td><td> 6        </td><td> 9        </td><td>0         </td><td>          </td><td>1         </td><td>Southwest </td><td>NA        </td></tr>
	<tr><td>2011      </td><td>12        </td><td> 6        </td><td>2         </td><td>  NA      </td><td>  NA      </td><td>WN        </td><td>  16      </td><td>N362SW    </td><td>NA        </td><td>...       </td><td>HOU       </td><td>DAL       </td><td> 239      </td><td>NA        </td><td>NA        </td><td>1         </td><td>A         </td><td>0         </td><td>Southwest </td><td>carrier   </td></tr>
</tbody>
</table>




```R
# Print out a summary with variables min_dist and max_dist
summarise(hflights, min_dist = min(Distance) , max_dist = max(Distance))
```


<table>
<thead><tr><th scope=col>min_dist</th><th scope=col>max_dist</th></tr></thead>
<tbody>
	<tr><td>79  </td><td>3904</td></tr>
</tbody>
</table>




```R
# Print out a summary with variable max_div
summarise(filter(hflights,Diverted == 1 ), max_div = max(Distance))

```


<table>
<thead><tr><th scope=col>max_div</th></tr></thead>
<tbody>
	<tr><td>3904</td></tr>
</tbody>
</table>




```R
# Remove rows that have NA ArrDelay: temp1
temp1 <- filter(hflights, !is.na(ArrDelay))

# Generate summary about ArrDelay column of temp1
summarise(temp1, earliest = min(ArrDelay), average = mean(ArrDelay), latest = max(ArrDelay), sd = sd(ArrDelay))

```


<table>
<thead><tr><th scope=col>earliest</th><th scope=col>average</th><th scope=col>latest</th><th scope=col>sd</th></tr></thead>
<tbody>
	<tr><td>-70     </td><td>7.094334</td><td>978     </td><td>30.70852</td></tr>
</tbody>
</table>




```R

# Keep rows that have no NA TaxiIn and no NA TaxiOut: temp2
temp2 <- filter(hflights, !is.na(TaxiIn) & !is.na(TaxiOut))

# Print the maximum taxiing difference of temp2 with summarise()
summarise(temp2, max_taxi_diff = max(abs(TaxiIn - TaxiOut)))
```


<table>
<thead><tr><th scope=col>max_taxi_diff</th></tr></thead>
<tbody>
	<tr><td>160</td></tr>
</tbody>
</table>




```R
#dplyr aggregate functions
#dplyr provides several helpful aggregate functions of its own, in addition to the ones that are already defined in R. These include:

#first(x) - The first element of vector x.
#last(x) - The last element of vector x.
#nth(x, n) - The nth element of vector x.
#n() - The number of rows in the data.frame or group of observations that summarise() describes.
#n_distinct(x) - The number of unique values in vector x.

# Generate summarizing statistics for hflights
summarise(hflights,
          n_obs = n(),
          n_carrier = n_distinct(UniqueCarrier),
          n_dest = n_distinct(Dest))

```


<table>
<thead><tr><th scope=col>n_obs</th><th scope=col>n_carrier</th><th scope=col>n_dest</th></tr></thead>
<tbody>
	<tr><td>227496</td><td>15    </td><td>116   </td></tr>
</tbody>
</table>




```R
# All American Airline flights
aa <- filter(hflights, UniqueCarrier == "American")

# Generate summarizing statistics for aa 
summarise(aa,
          n_flights = n(),
          n_canc = sum(Cancelled),
          avg_delay = mean(ArrDelay, na.rm=TRUE))
```


<table>
<thead><tr><th scope=col>n_flights</th><th scope=col>n_canc</th><th scope=col>avg_delay</th></tr></thead>
<tbody>
	<tr><td>0  </td><td>0  </td><td>NaN</td></tr>
</tbody>
</table>




```R
# Write the 'piped' version of the English sentences.
 hflights %>% mutate(diff = TaxiOut - TaxiIn) %>% filter(!is.na(diff)) %>% summarise(avg = mean(diff))
```


<table>
<thead><tr><th scope=col>avg</th></tr></thead>
<tbody>
	<tr><td>8.992064</td></tr>
</tbody>
</table>




```R
 # Chain together mutate(), filter() and summarise()
hflights %>% mutate(RealTime = ActualElapsedTime + 100, mph = Distance / RealTime * 60) %>%
    filter(!is.na(mph) & mph < 70) %>% summarise(n_less = n(), n_dest = n_distinct(Dest), min_dist = min(Distance), max_dist = max(Distance))

```


<table>
<thead><tr><th scope=col>n_less</th><th scope=col>n_dest</th><th scope=col>min_dist</th><th scope=col>max_dist</th></tr></thead>
<tbody>
	<tr><td>6726</td><td>13  </td><td>79  </td><td>305 </td></tr>
</tbody>
</table>




```R
# Finish the command with a filter() and summarise() call
hflights %>%
  mutate(RealTime = ActualElapsedTime + 100, mph = Distance / RealTime * 60) %>% filter(mph < 105 | Cancelled == 1 | Diverted == 1) %>% summarise(n_non = n(), n_dest = n_distinct(Dest), min_dist = min(Distance), max_dist = max(Distance))
  
```


<table>
<thead><tr><th scope=col>n_non</th><th scope=col>n_dest</th><th scope=col>min_dist</th><th scope=col>max_dist</th></tr></thead>
<tbody>
	<tr><td>42400</td><td>113  </td><td>79   </td><td>3904 </td></tr>
</tbody>
</table>




```R
# Count the number of overnight flights
hflights %>% filter(!is.na(DepTime) & !is.na(ArrTime) & DepTime > ArrTime) %>% summarise(num = n())
```


<table>
<thead><tr><th scope=col>num</th></tr></thead>
<tbody>
	<tr><td>2718</td></tr>
</tbody>
</table>




```R
# Make an ordered per-carrier summary of hflights
hflights %>%
  group_by(UniqueCarrier) %>%
  summarise(p_canc = mean(Cancelled == 1) * 100,
            avg_delay = mean(ArrDelay, na.rm = TRUE)) %>%
  arrange(avg_delay, p_canc)
```


<table>
<thead><tr><th scope=col>UniqueCarrier</th><th scope=col>p_canc</th><th scope=col>avg_delay</th></tr></thead>
<tbody>
	<tr><td>US        </td><td>1.1268986 </td><td>-0.6307692</td></tr>
	<tr><td>AA        </td><td>1.8495684 </td><td> 0.8917558</td></tr>
	<tr><td>FL        </td><td>0.9817672 </td><td> 1.8536239</td></tr>
	<tr><td>AS        </td><td>0.0000000 </td><td> 3.1923077</td></tr>
	<tr><td>YV        </td><td>1.2658228 </td><td> 4.0128205</td></tr>
	<tr><td>DL        </td><td>1.5903067 </td><td> 6.0841374</td></tr>
	<tr><td>CO        </td><td>0.6782614 </td><td> 6.0986983</td></tr>
	<tr><td>MQ        </td><td>2.9044750 </td><td> 7.1529751</td></tr>
	<tr><td>EV        </td><td>3.4482759 </td><td> 7.2569543</td></tr>
	<tr><td>WN        </td><td>1.5504047 </td><td> 7.5871430</td></tr>
	<tr><td>F9        </td><td>0.7159905 </td><td> 7.6682692</td></tr>
	<tr><td>XE        </td><td>1.5495599 </td><td> 8.1865242</td></tr>
	<tr><td>OO        </td><td>1.3946828 </td><td> 8.6934922</td></tr>
	<tr><td>B6        </td><td>2.5899281 </td><td> 9.8588410</td></tr>
	<tr><td>UA        </td><td>1.6409266 </td><td>10.4628628</td></tr>
</tbody>
</table>




```R
# Ordered overview of average arrival delays per carrier
hflights %>% filter(!is.na(ArrDelay) & ArrDelay > 0) %>% group_by(UniqueCarrier) %>% summarise(avg = mean(ArrDelay)) %>% mutate(rank = rank(avg)) %>% arrange(rank)

```


<table>
<thead><tr><th scope=col>UniqueCarrier</th><th scope=col>avg</th><th scope=col>rank</th></tr></thead>
<tbody>
	<tr><td>YV      </td><td>18.67568</td><td> 1      </td></tr>
	<tr><td>F9      </td><td>18.68683</td><td> 2      </td></tr>
	<tr><td>US      </td><td>20.70235</td><td> 3      </td></tr>
	<tr><td>CO      </td><td>22.13374</td><td> 4      </td></tr>
	<tr><td>AS      </td><td>22.91195</td><td> 5      </td></tr>
	<tr><td>OO      </td><td>24.14663</td><td> 6      </td></tr>
	<tr><td>XE      </td><td>24.19337</td><td> 7      </td></tr>
	<tr><td>WN      </td><td>25.27750</td><td> 8      </td></tr>
	<tr><td>FL      </td><td>27.85693</td><td> 9      </td></tr>
	<tr><td>AA      </td><td>28.49740</td><td>10      </td></tr>
	<tr><td>DL      </td><td>32.12463</td><td>11      </td></tr>
	<tr><td>UA      </td><td>32.48067</td><td>12      </td></tr>
	<tr><td>MQ      </td><td>38.75135</td><td>13      </td></tr>
	<tr><td>EV      </td><td>40.24231</td><td>14      </td></tr>
	<tr><td>B6      </td><td>45.47744</td><td>15      </td></tr>
</tbody>
</table>




```R

# How many airplanes only flew to one destination?
hflights %>%
  group_by(TailNum) %>%
  summarise(ndest = n_distinct(Dest)) %>%
  filter(ndest == 1) %>%
  summarise(nplanes = n())

```


<table>
<thead><tr><th scope=col>nplanes</th></tr></thead>
<tbody>
	<tr><td>1526</td></tr>
</tbody>
</table>




```R
# Find the most visited destination for each carrier
hflights %>%
  group_by(UniqueCarrier, Dest) %>%
  summarise(n = n()) %>%
  mutate(rank = rank(desc(n))) %>%
  filter(rank == 1)
```


<table>
<thead><tr><th scope=col>UniqueCarrier</th><th scope=col>Dest</th><th scope=col>n</th><th scope=col>rank</th></tr></thead>
<tbody>
	<tr><td>AA  </td><td>DFW </td><td>2105</td><td>1   </td></tr>
	<tr><td>AS  </td><td>SEA </td><td> 365</td><td>1   </td></tr>
	<tr><td>B6  </td><td>JFK </td><td> 695</td><td>1   </td></tr>
	<tr><td>CO  </td><td>EWR </td><td>3924</td><td>1   </td></tr>
	<tr><td>DL  </td><td>ATL </td><td>2396</td><td>1   </td></tr>
	<tr><td>EV  </td><td>DTW </td><td> 851</td><td>1   </td></tr>
	<tr><td>F9  </td><td>DEN </td><td> 837</td><td>1   </td></tr>
	<tr><td>FL  </td><td>ATL </td><td>2029</td><td>1   </td></tr>
	<tr><td>MQ  </td><td>DFW </td><td>2424</td><td>1   </td></tr>
	<tr><td>OO  </td><td>COS </td><td>1335</td><td>1   </td></tr>
	<tr><td>UA  </td><td>SFO </td><td> 643</td><td>1   </td></tr>
	<tr><td>US  </td><td>CLT </td><td>2212</td><td>1   </td></tr>
	<tr><td>WN  </td><td>DAL </td><td>8243</td><td>1   </td></tr>
	<tr><td>XE  </td><td>CRP </td><td>3175</td><td>1   </td></tr>
	<tr><td>YV  </td><td>CLT </td><td>  71</td><td>1   </td></tr>
</tbody>
</table>




```R
# Use summarise to calculate n_carrier
hflights %>% summarise(n_carrier = n_distinct(UniqueCarrier))
  
```


<table>
<thead><tr><th scope=col>n_carrier</th></tr></thead>
<tbody>
	<tr><td>15</td></tr>
</tbody>
</table>




```R
# Set up a connection to the mysql database
#my_db <- src_mysql(dbname = "dplyr", 
#                   host = "courses.csrrinzqubik.us-east-1.rds.amazonaws.com", 
#                   port = 3306, 
#                   user = "******",
#                   password = "******")

# Reference a table within that source: nycflights
#nycflights <- tbl(my_db, "dplyr")

# glimpse at nycflights
#glimpse(nycflights)

# Ordered, grouped summary of nycflights
#nycflights %>% group_by(carrier) %>% summarise(n_flights = n(), avg_delay = mean(arr_delay)) %>% arrange(avg_delay)  




```
