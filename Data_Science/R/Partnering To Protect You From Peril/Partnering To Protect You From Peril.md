
## 1. Ebola, hurricanes, and forest fires, oh my
<p>Have you ever wondered who keeps an eye on your favorite restaurants to make sure your food is safe? Or removes old tires filled with standing water that could attract mosquitos? In the US, these tasks are among the services provided by over 2,500 local health departments serving all communities across the country. In addition to basic services that keep us safe on a daily basis, local health departments also prepare for and respond to large-scale national, regional, and local emergencies.</p>
<p>Health department size and service provision vary widely depending on the needs and size of its constituent population, which can range from a few hundred to a few million people. Every few years, the National Association of County and City Health Officials (NACCHO) surveys health departments about their resources and the services they provide to constituents. </p>
<p>In 2016, the survey asked each health department to identify five health departments they connected to the most. Connections among health departments facilitate information sharing and coordination of services and are especially important during public health emergencies. The Ebola outbreak in 2014, Hurricane Harvey in 2017, and the California wildfires in 2018 are examples of national, regional, and state emergencies requiring coordination of public health services.</p>
<p>To understand the partnerships underlying the public health response to emergencies, let's examine the network of local health departments and identify key health departments and gaps in the network at the national, regional, and state levels.  </p>

![jpg](1.jpg)


```R
# load the libraries
library(readr)
library(dplyr)
library(igraph)
library(ggraph)

# Import the edgelist from the naccho2016clean.csv file
health.dep.edges <- read_csv(file = "datasets/naccho2016clean.csv")

# Import the attributes from the naccho2016att.csv file
health.dep.nodes <- read_csv(file = "datasets/naccho2016att.csv")

# Merge the edgelist and attributes into a network object
health.dep.net <- graph_from_data_frame(d = health.dep.edges, 
                       vertices = health.dep.nodes, 
                       directed = FALSE)

# Show the network object
health.dep.net
```

    IGRAPH UN-B 2058 5818 -- 
    + attr: name (v/c), tobacco (v/n), nutrition (v/n), state (v/c), type
    | (v/c), rurality (v/c), population (v/n), leader.tenure (v/n), fte
    | (v/n)
    + edges (vertex names):
     [1] AK001--OR024 AK001--AK101 AL038--AL050 AL038--KY032 AL038--AL080
     [6] AL038--TN020 AL038--AL066 AR004--MO048 AR004--OK072 AR005--AR008
    [11] AR005--AR044 AR005--AR050 AR005--AR063 AR002--AR006 AR006--AR009
    [16] AR006--AR021 AR006--AR022 AR006--AR039 AR007--AR020 AR007--AR051
    [21] AR005--AR008 AR008--AR043 AR008--AR071 AR008--AR057 AR002--AR009
    [26] AR009--AR021 AR009--AR022 AR009--AR058 AR006--AR009 AR010--AR014
    + ... omitted several edges

## 2. Cleaning up the network object
<p>With more than 2,500 health departments in the US, the national network of partnerships may be large and complex. The first step in any analysis is to clean up the data. The health department network shows partnerships, which would logically be represented by a single link between any two health departments that partner. Local health departments do not typically partner with themselves, so there would be no loops in the network.</p>


```R
# check for loops and multiples
is_simple(health.dep.net)

# remove loops and multiples
health.dep.net <- igraph::simplify(health.dep.net, 
                       remove.multiple = TRUE, 
                       remove.loops = TRUE)

# check for loops and multiples again
is_simple(health.dep.net)
```


FALSE

TRUE

## 3. Getting to know the network
<p>After cleaning up the network object, the next step is some exploratory analysis to get to know the network. </p>


```R
# count the number of vertices in the network
( num.health.dep <- vcount(graph = health.dep.net) )

# count the number of edges in the network
( num.connections <- ecount(graph = health.dep.net) )

# compute network density 
( net.density <- edge_density(graph = health.dep.net, loops = FALSE) )
```


2058

4979

0.00235229865263697


## 4. Connections facilitating coordination nationwide
<p>In 2014-2016 there was an outbreak of Ebola in West Africa. In late 2014, a case of Ebola was identified in Texas and health departments nationwide worked to prepare for the potential of a widespread outbreak. While this potential was never realized (there were just 4 cases eventually diagnosed in the US), it isn't difficult to imagine a large-scale infectious disease outbreak that requires coordination across the country to protect the uninfected and treat the infected. </p>
<p>Central network members can facilitate or control the spread of information and other resources and are often considered key or important network members. There are several different types of centrality. Two of the more commonly used are degree centrality and betweenness centrality. Degree centrality is a count of the number of connections a node has. Betweenness centrality quantifies the extent to which a node lies in the shortest path between any two other nodes in the network, often playing a bridging role.</p>
<p>The nodes with the highest degree and betweenness centrality may be key to spreading information and coordinating efforts nationwide. Nodes that have both high degree and high betweenness may be especially important.</p>


```R
# identify highly connected nodes using degree
health.dep.nodes$health.dep.degree <- degree(health.dep.net)
arrange(health.dep.nodes, -health.dep.degree)

# identify bridges nodes using betweenness
health.dep.nodes$health.dep.between <- betweenness(health.dep.net)
arrange(health.dep.nodes, -health.dep.between)
```


<table>
<thead><tr><th scope=col>nacchoid</th><th scope=col>tobacco</th><th scope=col>nutrition</th><th scope=col>state</th><th scope=col>type</th><th scope=col>rurality</th><th scope=col>population</th><th scope=col>leader.tenure</th><th scope=col>fte</th><th scope=col>health.dep.degree</th></tr></thead>
<tbody>
	<tr><td>KY009       </td><td> 1          </td><td> 1          </td><td>KY          </td><td>county      </td><td>rural       </td><td>  35758     </td><td>10.4449005  </td><td>  55.00     </td><td>24          </td></tr>
	<tr><td>NC060       </td><td> 1          </td><td> 1          </td><td>NC          </td><td>county      </td><td>urban       </td><td> 140420     </td><td> 4.4161534  </td><td>  98.40     </td><td>22          </td></tr>
	<tr><td>KY021       </td><td> 1          </td><td> 1          </td><td>KY          </td><td>county      </td><td>urban       </td><td>  50815     </td><td> 3.6605065  </td><td>  27.00     </td><td>21          </td></tr>
	<tr><td>OK014       </td><td> 1          </td><td> 1          </td><td>OK          </td><td>county      </td><td>urban       </td><td> 269908     </td><td> 2.6365504  </td><td> 105.00     </td><td>21          </td></tr>
	<tr><td>OH066       </td><td> 1          </td><td> 0          </td><td>OH          </td><td>county      </td><td>rural       </td><td>  63180     </td><td>10.3764543  </td><td>  24.00     </td><td>19          </td></tr>
	<tr><td>OH092       </td><td> 0          </td><td> 1          </td><td>OH          </td><td>city        </td><td>rural       </td><td> 175914     </td><td> 3.7672827  </td><td>  70.50     </td><td>19          </td></tr>
	<tr><td>TX144       </td><td> 1          </td><td> 1          </td><td>TX          </td><td>county      </td><td>urban       </td><td>2020286     </td><td>        NA  </td><td> 472.00     </td><td>19          </td></tr>
	<tr><td>WI068       </td><td> 1          </td><td> 1          </td><td>WI          </td><td>county      </td><td>urban       </td><td>  43437     </td><td>18.0369606  </td><td>     NA     </td><td>19          </td></tr>
	<tr><td>IL011       </td><td>NA          </td><td>NA          </td><td>IL          </td><td>county      </td><td>rural       </td><td>  13520     </td><td>24.5284061  </td><td>  44.00     </td><td>18          </td></tr>
	<tr><td>MO049       </td><td> 0          </td><td> 0          </td><td>MO          </td><td>city        </td><td>rural       </td><td> 470800     </td><td>17.6016426  </td><td> 158.00     </td><td>18          </td></tr>
	<tr><td>NC021       </td><td> 1          </td><td> 1          </td><td>NC          </td><td>county      </td><td>urban       </td><td> 326328     </td><td> 6.7488022  </td><td> 243.00     </td><td>18          </td></tr>
	<tr><td>FL002       </td><td> 1          </td><td> 1          </td><td>FL          </td><td>county      </td><td>urban       </td><td> 256380     </td><td> 4.3969884  </td><td>     NA     </td><td>17          </td></tr>
	<tr><td>FL047       </td><td> 1          </td><td> 1          </td><td>FL          </td><td>county      </td><td>urban       </td><td>1253001     </td><td> 0.8596851  </td><td> 512.00     </td><td>17          </td></tr>
	<tr><td>IL033       </td><td> 1          </td><td> 1          </td><td>IL          </td><td>county      </td><td>rural       </td><td>  59677     </td><td>18.7488022  </td><td>  51.07     </td><td>17          </td></tr>
	<tr><td>KS036       </td><td> 1          </td><td> 1          </td><td>KS          </td><td>county      </td><td>urban       </td><td> 574272     </td><td> 6.9842572  </td><td> 135.00     </td><td>17          </td></tr>
	<tr><td>NC093       </td><td> 1          </td><td> 1          </td><td>NC          </td><td>multi-county</td><td>rural       </td><td> 134805     </td><td>15.7481175  </td><td> 180.00     </td><td>17          </td></tr>
	<tr><td>OK010       </td><td> 1          </td><td> 1          </td><td>OK          </td><td>county      </td><td>rural       </td><td>  48821     </td><td>14.6639290  </td><td>  41.00     </td><td>17          </td></tr>
	<tr><td>WA022       </td><td> 1          </td><td> 1          </td><td>WA          </td><td>county      </td><td>urban       </td><td>2079967     </td><td> 1.6372348  </td><td>1244.00     </td><td>17          </td></tr>
	<tr><td>FL045       </td><td> 1          </td><td> 1          </td><td>FL          </td><td>county      </td><td>urban       </td><td> 196512     </td><td>16.2819977  </td><td>  94.65     </td><td>16          </td></tr>
	<tr><td>FL050       </td><td> 1          </td><td> 1          </td><td>FL          </td><td>county      </td><td>urban       </td><td> 485331     </td><td> 3.3182752  </td><td> 175.00     </td><td>16          </td></tr>
	<tr><td>IL008       </td><td> 1          </td><td> 1          </td><td>IL          </td><td>multi-ciy   </td><td>urban       </td><td> 126557     </td><td> 8.8788500  </td><td>  98.00     </td><td>16          </td></tr>
	<tr><td>MO025       </td><td> 1          </td><td> 1          </td><td>MO          </td><td>city-county </td><td>urban       </td><td> 172717     </td><td>16.7501717  </td><td>  67.00     </td><td>16          </td></tr>
	<tr><td>OH040       </td><td> 1          </td><td> 1          </td><td>OH          </td><td>county      </td><td>urban       </td><td> 173213     </td><td> 3.2470911  </td><td>  66.00     </td><td>16          </td></tr>
	<tr><td>TX146       </td><td> 0          </td><td> 1          </td><td>TX          </td><td>city        </td><td>urban       </td><td>2239558     </td><td>11.7563314  </td><td>1240.00     </td><td>16          </td></tr>
	<tr><td>WA026       </td><td> 1          </td><td> 1          </td><td>WA          </td><td>county      </td><td>urban       </td><td> 484318     </td><td> 6.8336754  </td><td> 217.00     </td><td>16          </td></tr>
	<tr><td>IN053       </td><td> 1          </td><td> 1          </td><td>IN          </td><td>county      </td><td>urban       </td><td> 934243     </td><td>21.2457218  </td><td>     NA     </td><td>15          </td></tr>
	<tr><td>MA043       </td><td> 1          </td><td> 1          </td><td>MA          </td><td>city        </td><td>urban       </td><td> 109694     </td><td> 8.9965773  </td><td>  47.00     </td><td>15          </td></tr>
	<tr><td>OH033       </td><td> 1          </td><td> 1          </td><td>OH          </td><td>county      </td><td>urban       </td><td> 835957     </td><td>13.7932920  </td><td> 495.00     </td><td>15          </td></tr>
	<tr><td>OH037       </td><td> 1          </td><td> 1          </td><td>OH          </td><td>county      </td><td>urban       </td><td> 842517     </td><td>13.2457218  </td><td>     NA     </td><td>15          </td></tr>
	<tr><td>OH049       </td><td> 1          </td><td> 1          </td><td>OH          </td><td>city        </td><td>urban       </td><td> 451470     </td><td>16.9308701  </td><td>  81.00     </td><td>15          </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>TN108       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>TX004       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>TX014       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>TX113       </td><td> 0          </td><td> 0          </td><td>TX          </td><td>county      </td><td>rural       </td><td> 37653      </td><td> 0.8788501  </td><td>15.00       </td><td>1           </td></tr>
	<tr><td>TX140       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>TX143       </td><td>NA          </td><td>NA          </td><td>TX          </td><td>county      </td><td>urban       </td><td> 55621      </td><td> 7.8959618  </td><td> 7.50       </td><td>1           </td></tr>
	<tr><td>TX145       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>TX151       </td><td> 1          </td><td> 1          </td><td>TX          </td><td>county      </td><td>urban       </td><td> 80110      </td><td>23.8302536  </td><td>35.00       </td><td>1           </td></tr>
	<tr><td>TX156       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>TX159       </td><td> 0          </td><td> 0          </td><td>TX          </td><td>county      </td><td>rural       </td><td> 47894      </td><td> 3.2443533  </td><td> 4.75       </td><td>1           </td></tr>
	<tr><td>TX164       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>TX167       </td><td> 0          </td><td> 0          </td><td>TX          </td><td>city        </td><td>urban       </td><td>278480      </td><td> 0.9856263  </td><td>21.00       </td><td>1           </td></tr>
	<tr><td>TX172       </td><td>NA          </td><td> 0          </td><td>TX          </td><td>county      </td><td>rural       </td><td>185025      </td><td> 3.2443533  </td><td>10.00       </td><td>1           </td></tr>
	<tr><td>TX175       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>TX181       </td><td> 0          </td><td> 0          </td><td>TX          </td><td>county      </td><td>rural       </td><td> 27117      </td><td>30.2450371  </td><td> 2.00       </td><td>1           </td></tr>
	<tr><td>TX193       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>TX247       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>UT002       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>VA057       </td><td> 0          </td><td> 1          </td><td>VA          </td><td>county      </td><td>urban       </td><td>363050      </td><td>14.9596167  </td><td>80.00       </td><td>1           </td></tr>
	<tr><td>VA070       </td><td> 1          </td><td> 0          </td><td>VA          </td><td>multi-county</td><td>urban       </td><td>230199      </td><td> 5.4976044  </td><td>80.00       </td><td>1           </td></tr>
	<tr><td>WI013       </td><td> 1          </td><td> 1          </td><td>WI          </td><td>county      </td><td>rural       </td><td> 34423      </td><td> 6.3709788  </td><td> 7.80       </td><td>1           </td></tr>
	<tr><td>WI090       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>WI101       </td><td> 1          </td><td> 0          </td><td>WI          </td><td>city        </td><td>rural       </td><td> 19410      </td><td> 4.2409310  </td><td> 4.50       </td><td>1           </td></tr>
	<tr><td>WI106       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>WV004       </td><td> 1          </td><td> 0          </td><td>WV          </td><td>county      </td><td>rural       </td><td> 14463      </td><td> 1.4565367  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>WV007       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>WV008       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>WV014       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>WV040       </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>NA          </td><td>    NA      </td><td>        NA  </td><td>   NA       </td><td>1           </td></tr>
	<tr><td>WY049       </td><td> 1          </td><td> 0          </td><td>WY          </td><td>county      </td><td>rural       </td><td> 37811      </td><td> 0.2381930  </td><td> 7.00       </td><td>1           </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>nacchoid</th><th scope=col>tobacco</th><th scope=col>nutrition</th><th scope=col>state</th><th scope=col>type</th><th scope=col>rurality</th><th scope=col>population</th><th scope=col>leader.tenure</th><th scope=col>fte</th><th scope=col>health.dep.degree</th><th scope=col>health.dep.between</th></tr></thead>
<tbody>
	<tr><td>WA022       </td><td>1           </td><td>1           </td><td>WA          </td><td>county      </td><td>urban       </td><td>2079967     </td><td> 1.6372348  </td><td>1244.00     </td><td>17          </td><td>669781.78   </td></tr>
	<tr><td>MA043       </td><td>1           </td><td>1           </td><td>MA          </td><td>city        </td><td>urban       </td><td> 109694     </td><td> 8.9965773  </td><td>  47.00     </td><td>15          </td><td>316283.61   </td></tr>
	<tr><td>MO049       </td><td>0           </td><td>0           </td><td>MO          </td><td>city        </td><td>rural       </td><td> 470800     </td><td>17.6016426  </td><td> 158.00     </td><td>18          </td><td>301857.56   </td></tr>
	<tr><td>TX144       </td><td>1           </td><td>1           </td><td>TX          </td><td>county      </td><td>urban       </td><td>2020286     </td><td>        NA  </td><td> 472.00     </td><td>19          </td><td>287214.88   </td></tr>
	<tr><td>IN053       </td><td>1           </td><td>1           </td><td>IN          </td><td>county      </td><td>urban       </td><td> 934243     </td><td>21.2457218  </td><td>     NA     </td><td>15          </td><td>263147.78   </td></tr>
	<tr><td>KY047       </td><td>1           </td><td>1           </td><td>KY          </td><td>multi-county</td><td>rural       </td><td>  44542     </td><td>11.8138266  </td><td>  60.00     </td><td>13          </td><td>260935.16   </td></tr>
	<tr><td>MO102       </td><td>1           </td><td>1           </td><td>MO          </td><td>county      </td><td>urban       </td><td>1001876     </td><td> 1.1608487  </td><td> 501.00     </td><td>13          </td><td>211836.38   </td></tr>
	<tr><td>CA045       </td><td>1           </td><td>1           </td><td>CA          </td><td>county      </td><td>urban       </td><td>9502247     </td><td> 1.5797399  </td><td>3740.00     </td><td>12          </td><td>165662.72   </td></tr>
	<tr><td>WI062       </td><td>1           </td><td>1           </td><td>WI          </td><td>county      </td><td>rural       </td><td>  35563     </td><td> 4.1095142  </td><td>  21.00     </td><td> 9          </td><td>165177.71   </td></tr>
	<tr><td>IA069       </td><td>1           </td><td>1           </td><td>IA          </td><td>county      </td><td>urban       </td><td> 217751     </td><td> 3.9698837  </td><td>  50.30     </td><td>13          </td><td>163217.25   </td></tr>
	<tr><td>WA026       </td><td>1           </td><td>1           </td><td>WA          </td><td>county      </td><td>urban       </td><td> 484318     </td><td> 6.8336754  </td><td> 217.00     </td><td>16          </td><td>158327.61   </td></tr>
	<tr><td>AZ008       </td><td>1           </td><td>1           </td><td>AZ          </td><td>county      </td><td>urban       </td><td>4087191     </td><td> 9.4647503  </td><td> 662.73     </td><td>10          </td><td>151378.33   </td></tr>
	<tr><td>NC009       </td><td>0           </td><td>0           </td><td>NC          </td><td>county      </td><td>urban       </td><td> 250539     </td><td> 1.1389459  </td><td> 132.00     </td><td> 8          </td><td>147355.00   </td></tr>
	<tr><td>NJ005       </td><td>1           </td><td>1           </td><td>NJ          </td><td>multi-city  </td><td>urban       </td><td> 301815     </td><td>        NA  </td><td> 169.50     </td><td> 5          </td><td>136379.06   </td></tr>
	<tr><td>CT064       </td><td>1           </td><td>1           </td><td>CT          </td><td>city        </td><td>urban       </td><td> 130282     </td><td> 0.8788501  </td><td>     NA     </td><td> 6          </td><td>136028.30   </td></tr>
	<tr><td>CA034       </td><td>1           </td><td>1           </td><td>CA          </td><td>county      </td><td>urban       </td><td> 371694     </td><td> 2.2505133  </td><td> 749.00     </td><td> 5          </td><td>129875.49   </td></tr>
	<tr><td>CA010       </td><td>1           </td><td>1           </td><td>CA          </td><td>county      </td><td>rural       </td><td> 183087     </td><td> 2.6721423  </td><td>  76.00     </td><td> 5          </td><td>122530.47   </td></tr>
	<tr><td>IL009       </td><td>0           </td><td>1           </td><td>IL          </td><td>city        </td><td>urban       </td><td>2722389     </td><td> 0.2464066  </td><td> 536.00     </td><td>13          </td><td>120856.84   </td></tr>
	<tr><td>OK072       </td><td>1           </td><td>1           </td><td>OK          </td><td>county      </td><td>urban       </td><td> 629598     </td><td> 5.4127312  </td><td> 318.00     </td><td> 6          </td><td>112563.84   </td></tr>
	<tr><td>VA135       </td><td>1           </td><td>1           </td><td>VA          </td><td>multi-county</td><td>rural       </td><td> 140414     </td><td> 1.8672142  </td><td>  52.00     </td><td> 7          </td><td>111574.86   </td></tr>
	<tr><td>OR024       </td><td>1           </td><td>1           </td><td>OR          </td><td>county      </td><td>urban       </td><td> 776712     </td><td> 1.7823409  </td><td>1059.43     </td><td>11          </td><td>110710.58   </td></tr>
	<tr><td>WA025       </td><td>1           </td><td>1           </td><td>WA          </td><td>county      </td><td>urban       </td><td> 451008     </td><td> 2.4640658  </td><td>     NA     </td><td>12          </td><td>109865.21   </td></tr>
	<tr><td>OH160       </td><td>1           </td><td>1           </td><td>OH          </td><td>county      </td><td>urban       </td><td> 542232     </td><td> 0.7501711  </td><td> 210.00     </td><td>13          </td><td>109342.20   </td></tr>
	<tr><td>NJ083       </td><td>1           </td><td>1           </td><td>NJ          </td><td>county      </td><td>urban       </td><td> 508856     </td><td> 2.0588639  </td><td>  27.00     </td><td> 7          </td><td>108846.76   </td></tr>
	<tr><td>TN068       </td><td>1           </td><td>1           </td><td>TN          </td><td>county      </td><td>urban       </td><td> 189961     </td><td> 6.8637919  </td><td>  72.50     </td><td>14          </td><td>108090.93   </td></tr>
	<tr><td>AR004       </td><td>1           </td><td>1           </td><td>AR          </td><td>county      </td><td>urban       </td><td> 242321     </td><td>34.1875420  </td><td>  39.10     </td><td> 3          </td><td> 97483.91   </td></tr>
	<tr><td>KS043       </td><td>1           </td><td>1           </td><td>KS          </td><td>county      </td><td>urban       </td><td> 116585     </td><td> 9.2046547  </td><td>  40.30     </td><td>11          </td><td> 93239.72   </td></tr>
	<tr><td>AR071       </td><td>1           </td><td>0           </td><td>AR          </td><td>county      </td><td>urban       </td><td> 220792     </td><td> 2.6639287  </td><td>  60.00     </td><td> 4          </td><td> 92508.42   </td></tr>
	<tr><td>FL056       </td><td>1           </td><td>1           </td><td>FL          </td><td>county      </td><td>urban       </td><td> 442516     </td><td> 2.9897330  </td><td> 140.00     </td><td> 9          </td><td> 89741.15   </td></tr>
	<tr><td>WA033       </td><td>0           </td><td>0           </td><td>WA          </td><td>county      </td><td>urban       </td><td> 247687     </td><td> 3.8384669  </td><td>     NA     </td><td>11          </td><td> 82579.92   </td></tr>
	<tr><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>WA019      </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>   NA      </td><td>         NA</td><td>   NA      </td><td>2          </td><td>0          </td></tr>
	<tr><td>WA021      </td><td> 0         </td><td>NA         </td><td>WA         </td><td>county     </td><td>rural      </td><td>16015      </td><td> 1.91649556</td><td>25.30      </td><td>2          </td><td>0          </td></tr>
	<tr><td>WI003      </td><td> 1         </td><td> 1         </td><td>WI         </td><td>county     </td><td>rural      </td><td>16103      </td><td> 4.33949327</td><td> 7.00      </td><td>3          </td><td>0          </td></tr>
	<tr><td>WI013      </td><td> 1         </td><td> 1         </td><td>WI         </td><td>county     </td><td>rural      </td><td>34423      </td><td> 6.37097883</td><td> 7.80      </td><td>1          </td><td>0          </td></tr>
	<tr><td>WI015      </td><td> 1         </td><td> 1         </td><td>WI         </td><td>county     </td><td>rural      </td><td>16392      </td><td>22.49691963</td><td> 5.10      </td><td>5          </td><td>0          </td></tr>
	<tr><td>WI016      </td><td> 1         </td><td> 1         </td><td>WI         </td><td>city       </td><td>urban      </td><td>18341      </td><td> 1.48391509</td><td> 4.50      </td><td>2          </td><td>0          </td></tr>
	<tr><td>WI029      </td><td> 1         </td><td> 1         </td><td>WI         </td><td>county     </td><td>rural      </td><td>51829      </td><td>12.23545551</td><td>23.20      </td><td>5          </td><td>0          </td></tr>
	<tr><td>WI045      </td><td> 1         </td><td> 0         </td><td>WI         </td><td>county     </td><td>rural      </td><td>16853      </td><td>         NA</td><td>   NA      </td><td>5          </td><td>0          </td></tr>
	<tr><td>WI066      </td><td> 0         </td><td> 0         </td><td>WI         </td><td>county     </td><td>rural      </td><td> 7335      </td><td>10.25598907</td><td> 3.95      </td><td>3          </td><td>0          </td></tr>
	<tr><td>WI090      </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>   NA      </td><td>         NA</td><td>   NA      </td><td>1          </td><td>0          </td></tr>
	<tr><td>WI101      </td><td> 1         </td><td> 0         </td><td>WI         </td><td>city       </td><td>rural      </td><td>19410      </td><td> 4.24093103</td><td> 4.50      </td><td>1          </td><td>0          </td></tr>
	<tr><td>WI106      </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>   NA      </td><td>         NA</td><td>   NA      </td><td>1          </td><td>0          </td></tr>
	<tr><td>WV004      </td><td> 1         </td><td> 0         </td><td>WV         </td><td>county     </td><td>rural      </td><td>14463      </td><td> 1.45653665</td><td>   NA      </td><td>1          </td><td>0          </td></tr>
	<tr><td>WV007      </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>   NA      </td><td>         NA</td><td>   NA      </td><td>1          </td><td>0          </td></tr>
	<tr><td>WV008      </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>   NA      </td><td>         NA</td><td>   NA      </td><td>1          </td><td>0          </td></tr>
	<tr><td>WV014      </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>   NA      </td><td>         NA</td><td>   NA      </td><td>1          </td><td>0          </td></tr>
	<tr><td>WV031      </td><td> 1         </td><td> 0         </td><td>WV         </td><td>county     </td><td>rural      </td><td>13582      </td><td> 1.83162212</td><td> 3.50      </td><td>2          </td><td>0          </td></tr>
	<tr><td>WV036      </td><td> 1         </td><td> 1         </td><td>WV         </td><td>county     </td><td>rural      </td><td>33788      </td><td>11.96440792</td><td> 7.00      </td><td>3          </td><td>0          </td></tr>
	<tr><td>WV040      </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>   NA      </td><td>         NA</td><td>   NA      </td><td>1          </td><td>0          </td></tr>
	<tr><td>WV041      </td><td> 0         </td><td> 0         </td><td>WV         </td><td>county     </td><td>rural      </td><td>17069      </td><td> 2.49691987</td><td>15.30      </td><td>2          </td><td>0          </td></tr>
	<tr><td>WV045      </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>   NA      </td><td>         NA</td><td>   NA      </td><td>2          </td><td>0          </td></tr>
	<tr><td>WY001      </td><td> 1         </td><td> 1         </td><td>WY         </td><td>county     </td><td>rural      </td><td>11930      </td><td> 0.05201916</td><td> 4.50      </td><td>3          </td><td>0          </td></tr>
	<tr><td>WY006      </td><td> 1         </td><td> 1         </td><td>WY         </td><td>county     </td><td>rural      </td><td>14097      </td><td> 0.08213552</td><td> 7.00      </td><td>2          </td><td>0          </td></tr>
	<tr><td>WY010      </td><td> 1         </td><td> 1         </td><td>WY         </td><td>county     </td><td>rural      </td><td> 4816      </td><td> 3.25804234</td><td> 4.00      </td><td>3          </td><td>0          </td></tr>
	<tr><td>WY011      </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>   NA      </td><td>         NA</td><td>   NA      </td><td>2          </td><td>0          </td></tr>
	<tr><td>WY019      </td><td> 1         </td><td> 0         </td><td>WY         </td><td>county     </td><td>rural      </td><td>45010      </td><td> 2.66392875</td><td>18.50      </td><td>2          </td><td>0          </td></tr>
	<tr><td>WY020      </td><td> 0         </td><td> 0         </td><td>WY         </td><td>county     </td><td>rural      </td><td>22930      </td><td> 2.57084179</td><td>18.00      </td><td>2          </td><td>0          </td></tr>
	<tr><td>WY021      </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>   NA      </td><td>         NA</td><td>   NA      </td><td>2          </td><td>0          </td></tr>
	<tr><td>WY023      </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>NA         </td><td>   NA      </td><td>         NA</td><td>   NA      </td><td>2          </td><td>0          </td></tr>
	<tr><td>WY049      </td><td> 1         </td><td> 0         </td><td>WY         </td><td>county     </td><td>rural      </td><td>37811      </td><td> 0.23819302</td><td> 7.00      </td><td>1          </td><td>0          </td></tr>
</tbody>
</table>

## 5. Connections for regional coordination
<p>Some disasters are more regional than national and would not require all health departments across the country to be involved. For example, in 2017, Hurricane Harvey poured between 10 and 50 inches of rain in a short period of time across parts of southeastern Texas and southwestern Louisiana. This resulted in widespread flooding across the region and tested the emergency preparedness of health departments and others. Let's use network methods to identify key players and gaps in the network across Texas and Louisiana that might suggest new connections to prepare for future events.</p>


```R
# subset the network so it includes TX, LA 
region.net <- igraph::induced_subgraph(graph = health.dep.net, 
                   vids = which(V(health.dep.net)$state %in% c('LA', 'TX')))

# Find the number of vertices (i.e., network size) using vcount()
vcount(region.net)

# Use edge_density() to find the density of region.net
edge_density(region.net)

# plot the network with theme_graph
lhd.net.theme <- ggraph(graph = region.net, layou = "with_kk") +
  geom_edge_link() +
  geom_node_point(aes(color =state)) +
  theme_graph()
lhd.net.theme
```


47

0.0971322849213691

![png](output_13_3.png)

## 6. Which health departments are central in Texas and Louisiana?
<p>While collaboration between the states will be challenging with no existing connections, the health departments in each state are well connected to each other. We can use degree centrality and betweenness centrality to find the key health departments in each state should another disaster occur. </p>


```R
# identify important nodes in each state using degree
region.net$degree <- degree(region.net)

# get the top degree health depts for each state
( top.degree.LA <- head(sort(region.net$degree[V(region.net)$state == "LA"], 
                             decreasing = TRUE)) )

( top.degree.TX <- head(sort(region.net$degree[V(region.net)$state == "TX"], 
                             decreasing = TRUE)) )


# identify important nodes in each state using betweenness
region.net$between <- betweenness(region.net)

# get the top betweenness health depts for each state
( top.bet.LA <- head(sort(region.net$between[V(region.net)$state == "LA"], 
                           decreasing = TRUE)) )
( top.bet.TX <- head(sort(region.net$between[V(region.net)$state == "TX"], 
                           decreasing = TRUE)) )
```


<dl class=dl-horizontal>
	<dt>LA024</dt>
		<dd>4</dd>
	<dt>LA038</dt>
		<dd>3</dd>
	<dt>LA018</dt>
		<dd>2</dd>
	<dt>LA019</dt>
		<dd>2</dd>
	<dt>LA017</dt>
		<dd>1</dd>
</dl>




<dl class=dl-horizontal>
	<dt>TX144</dt>
		<dd>15</dd>
	<dt>TX146</dt>
		<dd>13</dd>
	<dt>TX236</dt>
		<dd>11</dd>
	<dt>TX007</dt>
		<dd>10</dd>
	<dt>TX184</dt>
		<dd>10</dd>
	<dt>TX003</dt>
		<dd>7</dd>
</dl>




<dl class=dl-horizontal>
	<dt>LA024</dt>
		<dd>3.5</dd>
	<dt>LA038</dt>
		<dd>0.5</dd>
	<dt>LA017</dt>
		<dd>0</dd>
	<dt>LA018</dt>
		<dd>0</dd>
	<dt>LA019</dt>
		<dd>0</dd>
</dl>




<dl class=dl-horizontal>
	<dt>TX144</dt>
		<dd>180.568148518149</dd>
	<dt>TX007</dt>
		<dd>137.299281274281</dd>
	<dt>TX146</dt>
		<dd>125.852425352425</dd>
	<dt>TX003</dt>
		<dd>111.813762626263</dd>
	<dt>TX236</dt>
		<dd>75.976486013986</dd>
	<dt>TX184</dt>
		<dd>74.0285714285714</dd>
</dl>

## 7. Visualizing the central health departments
<p>We just found several central health departments that were either highly connected (degree centrality) or were forming bridges between other health departments (betweenness centrality). Visualize these central health departments to get a better idea of their importance and place in the network.</p>


```R
# add degree to the node attributes
V(region.net)$degree <- degree(region.net)

# plot with node size by degree, color by state, theme graph, Kamada Kawai layout
region.plot.degree <- ggraph(graph = region.net, layout = "with_kk") +
  geom_edge_link() +
  geom_node_point(aes(colour = state, size = degree)) +
  geom_node_text(aes(label = name, size = 1), nudge_y = .25) +
  theme_graph()
region.plot.degree

# add betweenness to the node attributes
V(region.net)$between <- betweenness(region.net)

# plot with node size by betweenness, color by state, theme graph, Kamada Kawai layout
region.plot.between <- ggraph(graph = region.net, layout = "with_kk") +
  geom_edge_link() +
  geom_node_point(aes(colour = state, size = between)) +
  geom_node_text(aes(label = name, size = 1), nudge_y = .25) +
  theme_graph()
region.plot.between
```

![png](output_19_2.png)

![png](output_19_3.png)



## 8. What about state-level networks during emergencies?
<p>There are national and regional emergencies like Ebola and Hurricane Harvey. There are also state and local emergencies like the wildfires in California in 2018. We can understand the network and its key players using the same approaches but with a single state network.</p>


```R
# subset the network so it includes only CA
cali.net <- igraph::induced_subgraph(graph = health.dep.net, 
                   vids = which(V(health.dep.net)$state %in% c('CA')))

# Find the number of vertices (i.e., network size) using vcount()
vcount(cali.net)

# Use edge_density() to find the density 
edge_density(cali.net)

# Find and sort degree centrality for each health department
( top.cali.degree <- head(sort(degree(cali.net), decreasing = TRUE)) )

# Find and sort betweenness centrality for each health department
( top.cali.between <- head(sort(betweenness(cali.net), decreasing = TRUE)) )
```


36

0.106349206349206



<dl class=dl-horizontal>
	<dt>CA032</dt>
		<dd>9</dd>
	<dt>CA045</dt>
		<dd>9</dd>
	<dt>CA011</dt>
		<dd>6</dd>
	<dt>CA040</dt>
		<dd>6</dd>
	<dt>CA042</dt>
		<dd>6</dd>
	<dt>CA048</dt>
		<dd>6</dd>
</dl>




<dl class=dl-horizontal>
	<dt>CA013</dt>
		<dd>217.634920634921</dd>
	<dt>CA032</dt>
		<dd>153.554761904762</dd>
	<dt>CA048</dt>
		<dd>147.99126984127</dd>
	<dt>CA045</dt>
		<dd>141.254761904762</dd>
	<dt>CA010</dt>
		<dd>79.9007936507937</dd>
	<dt>CA042</dt>
		<dd>69.6579365079365</dd>
</dl>

## 9. Are central health departments urban?
<p>In addition to the <code>state</code> attribute, the network object includes several other health department characteristics that may be useful in understanding what makes two health departments partner with each other. One of the characteristics is <code>rurality</code>, which classifies each health department as rural or urban. Two other characteristics are <code>fte</code>, or full-time employees, and <code>leader.tenure</code>, which measures the years the leader has been at the health department.</p>
<p>Urban health departments are likely to be in more populated areas and to serve more people. It would make sense that urban health departments are more central to the network since they have more resources to use in forming and maintaining partnerships. However, rural health departments might have more incentive to partner to fill gaps in service provision. Having more full-time employees and stable leadership could also influence the ability of health departments to partner. </p>


```R
# Fill in the `colour` parameter with the rurality attribute 
# and the `size` parameter with degree to visualize rurality in cali.net
cali.net.rural.deg <- ggraph(graph = cali.net, layout = "with_kk") +
  geom_edge_link() +
  geom_node_point(aes(colour = rurality, size = degree(cali.net))) +
  geom_node_text(aes(label = name, size = 3), nudge_y = .2) +
  theme_graph()
cali.net.rural.deg

# Fill in the `colour` parameter with the population attribute 
# and the `size` parameter with degree to visualize population in cali.net
cali.net.pop.deg <- ggraph(graph = cali.net, layout = "with_kk") +
  geom_edge_link() +
  geom_node_point(aes(colour = population, size = degree(cali.net))) +
  geom_node_text(aes(label = name, size = 3), nudge_y = .2) +
  theme_graph()
cali.net.pop.deg

# Fill in the `colour` parameter with the fte attribute and 
# the `size` parameter with degree to visualize fte in cali.net
cali.net.fte.deg <- ggraph(graph = cali.net, layout = "with_kk") +
  geom_edge_link() +
  geom_node_point(aes(colour = fte, size = degree(cali.net))) +
  geom_node_text(aes(label = name, size = 3), nudge_y = .2) +
  theme_graph()
cali.net.fte.deg

```

![png](output_25_2.png)

![png](output_25_4.png)

![png](output_25_5.png)

## 10. Which health departments have high betweenness?
<p>Local health departments nationwide coordinate to provide services needed on a daily basis and to respond to local, regional, and national emergencies. An examination of betweenness and degree centrality identified a Texas health department (TX144) and a Missouri health department (MO049) that had both high degree and high betweenness. These health departments may be very useful in coordinating national public health efforts. </p>
<p>The regional network across Louisiana and Texas was disconnected, suggesting an opportunity to form new ties to improve coordination efforts for the future. Urban health departments in Texas had higher degree and betweenness and would be key players in coordination in Texas. Only urban health departments were in the Louisiana network, which may indicate poor survey response by rural health departments, which often have extremely limited resources.</p>
<p>The most central node by betweenness in the California state network was a rural health department (CA013), while two urban health departments (CA045, CA032) were the most connected. A statewide effort might rely on these three health departments to disseminate information and coordinate efforts across this large state. </p>
<p>By measuring and visualizing the network of health departments, we can get a better idea of strengths, key players, and gaps in governmental public health. Health departments can use this information to purposefully build their networks and to take advantage of the current natural leaders to protect us all from peril. </p>

![jpg](2.jpg)


```R
# compute betweenness for both networks
V(region.net)$between <- betweenness(region.net)
V(cali.net)$between <- betweenness(cali.net)

# cali.net with rurality color nodes sized by betweenness
cali.net.rural.bet <- ggraph(graph = cali.net, layout = "with_kk") +
  geom_edge_link() +
  geom_node_point(aes(colour = rurality, size = between)) +
  geom_node_text(aes(label = name, size = 3), nudge_y = .2) +
  theme_graph()
cali.net.rural.bet

# cali.net with population color nodes sized by betweenness
cali.net.pop.bet <- ggraph(graph = cali.net, layout = "with_kk") +
  geom_edge_link() +
  geom_node_point(aes(colour = population, size = between)) +
  geom_node_text(aes(label = name, size = 3), nudge_y = .2) +
  theme_graph()
cali.net.pop.bet

# cali.net with fte color nodes sized by betweenness
cali.net.fte.bet <- ggraph(graph = cali.net, layout = "with_kk") +
  geom_edge_link() +
  geom_node_point(aes(colour = fte, size = between)) +
  geom_node_text(aes(label = name, size = 3), nudge_y = .2) +
  theme_graph()
cali.net.fte.bet
```

![png](output_28_2.png)

![png](output_28_4.png)

![png](output_28_5.png)
  

