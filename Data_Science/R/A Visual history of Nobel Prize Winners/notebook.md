
## 1. The most Nobel of Prizes
![png](output_0_0.PNG)
<p>The Nobel Prize is perhaps the worlds most well known scientific award. Except for the honor, prestige and substantial prize money the recipient also gets a gold medal showing Alfred Nobel (1833 - 1896) who established the prize. Every year it's given to scientists and scholars in the categories chemistry, literature, physics, physiology or medicine, economics, and peace. The first Nobel Prize was handed out in 1901, and at that time the Prize was very Eurocentric and male-focused, but nowadays it's not biased in any way whatsoever. Surely. Right?</p>
<p>Well, we're going to find out! The Nobel Foundation has made a dataset available of all prize winners from the start of the prize, in 1901, to 2016. Let's load it in and take a look.</p>


```R
# Loading in required libraries
library(tidyverse)

# Reading in the Nobel Prize data
nobel <- read_csv("datasets/nobel.csv")

# Taking a look at the first couple of winners
head(nobel)
```



<table>
<thead><tr><th scope=col>year</th><th scope=col>category</th><th scope=col>prize</th><th scope=col>motivation</th><th scope=col>prize_share</th><th scope=col>laureate_id</th><th scope=col>laureate_type</th><th scope=col>full_name</th><th scope=col>birth_date</th><th scope=col>birth_city</th><th scope=col>birth_country</th><th scope=col>sex</th><th scope=col>organization_name</th><th scope=col>organization_city</th><th scope=col>organization_country</th><th scope=col>death_date</th><th scope=col>death_city</th><th scope=col>death_country</th></tr></thead>
<tbody>
	<tr><td>1901                                                                                                                                                                                                                                              </td><td>Chemistry                                                                                                                                                                                                                                         </td><td>The Nobel Prize in Chemistry 1901                                                                                                                                                                                                                 </td><td>"in recognition of the extraordinary services he has rendered by the discovery of the laws of chemical dynamics and osmotic pressure in solutions"                                                                                                </td><td>1/1                                                                                                                                                                                                                                               </td><td>160                                                                                                                                                                                                                                               </td><td>Individual                                                                                                                                                                                                                                        </td><td>Jacobus Henricus van 't Hoff                                                                                                                                                                                                                      </td><td>1852-08-30                                                                                                                                                                                                                                        </td><td>Rotterdam                                                                                                                                                                                                                                         </td><td>Netherlands                                                                                                                                                                                                                                       </td><td>Male                                                                                                                                                                                                                                              </td><td>Berlin University                                                                                                                                                                                                                                 </td><td>Berlin                                                                                                                                                                                                                                            </td><td>Germany                                                                                                                                                                                                                                           </td><td>1911-03-01                                                                                                                                                                                                                                        </td><td>Berlin                                                                                                                                                                                                                                            </td><td>Germany                                                                                                                                                                                                                                           </td></tr>
	<tr><td>1901                                                                                                                                                                                                                                                                                      </td><td>Literature                                                                                                                                                                                                                                                                                </td><td><span style=white-space:pre-wrap>The Nobel Prize in Literature 1901            </span>                                                                                                                                                                                                    </td><td><span style=white-space:pre-wrap>"in special recognition of his poetic composition, which gives evidence of lofty idealism, artistic perfection and a rare combination of the qualities of both heart and intellect"                                                               </span></td><td>1/1                                                                                                                                                                                                                                                                                       </td><td>569                                                                                                                                                                                                                                                                                       </td><td>Individual                                                                                                                                                                                                                                                                                </td><td><span style=white-space:pre-wrap>Sully Prudhomme              </span>                                                                                                                                                                                                                     </td><td>1839-03-16                                                                                                                                                                                                                                                                                </td><td><span style=white-space:pre-wrap>Paris             </span>                                                                                                                                                                                                                                </td><td><span style=white-space:pre-wrap>France           </span>                                                                                                                                                                                                                                 </td><td>Male                                                                                                                                                                                                                                                                                      </td><td><span style=white-space:pre-wrap>NA                </span>                                                                                                                                                                                                                                </td><td><span style=white-space:pre-wrap>NA     </span>                                                                                                                                                                                                                                           </td><td><span style=white-space:pre-wrap>NA     </span>                                                                                                                                                                                                                                           </td><td>1907-09-07                                                                                                                                                                                                                                                                                </td><td>Ch&lt;U+00E2&gt;tenay                                                                                                                                                                                                                                                                     </td><td><span style=white-space:pre-wrap>France     </span>                                                                                                                                                                                                                                       </td></tr>
	<tr><td>1901                                                                                                                                                                                                                                              </td><td>Medicine                                                                                                                                                                                                                                          </td><td>The Nobel Prize in Physiology or Medicine 1901                                                                                                                                                                                                    </td><td>"for his work on serum therapy, especially its application against diphtheria, by which he has opened a new road in the domain of medical science and thereby placed in the hands of the physician a victorious weapon against illness and deaths"</td><td>1/1                                                                                                                                                                                                                                               </td><td>293                                                                                                                                                                                                                                               </td><td>Individual                                                                                                                                                                                                                                        </td><td>Emil Adolf von Behring                                                                                                                                                                                                                            </td><td>1854-03-15                                                                                                                                                                                                                                        </td><td>Hansdorf (Lawice)                                                                                                                                                                                                                                 </td><td>Prussia (Poland)                                                                                                                                                                                                                                  </td><td>Male                                                                                                                                                                                                                                              </td><td>Marburg University                                                                                                                                                                                                                                </td><td>Marburg                                                                                                                                                                                                                                           </td><td>Germany                                                                                                                                                                                                                                           </td><td>1917-03-31                                                                                                                                                                                                                                        </td><td>Marburg                                                                                                                                                                                                                                           </td><td>Germany                                                                                                                                                                                                                                           </td></tr>
	<tr><td>1901                                                                                                                                                                                                                                              </td><td>Peace                                                                                                                                                                                                                                             </td><td>The Nobel Peace Prize 1901                                                                                                                                                                                                                        </td><td>NA                                                                                                                                                                                                                                                </td><td>1/2                                                                                                                                                                                                                                               </td><td>462                                                                                                                                                                                                                                               </td><td>Individual                                                                                                                                                                                                                                        </td><td>Jean Henry Dunant                                                                                                                                                                                                                                 </td><td>1828-05-08                                                                                                                                                                                                                                        </td><td>Geneva                                                                                                                                                                                                                                            </td><td>Switzerland                                                                                                                                                                                                                                       </td><td>Male                                                                                                                                                                                                                                              </td><td>NA                                                                                                                                                                                                                                                </td><td>NA                                                                                                                                                                                                                                                </td><td>NA                                                                                                                                                                                                                                                </td><td>1910-10-30                                                                                                                                                                                                                                        </td><td>Heiden                                                                                                                                                                                                                                            </td><td>Switzerland                                                                                                                                                                                                                                       </td></tr>
	<tr><td>1901                                                                                                                                                                                                                                                                                      </td><td><span style=white-space:pre-wrap>Peace     </span>                                                                                                                                                                                                                                        </td><td><span style=white-space:pre-wrap>The Nobel Peace Prize 1901                    </span>                                                                                                                                                                                                    </td><td><span style=white-space:pre-wrap>NA                                                                                                                                                                                                                                                </span></td><td>1/2                                                                                                                                                                                                                                                                                       </td><td>463                                                                                                                                                                                                                                                                                       </td><td>Individual                                                                                                                                                                                                                                                                                </td><td>Fr&lt;U+00E9&gt;d&lt;U+00E9&gt;ric Passy                                                                                                                                                                                                                                                  </td><td>1822-05-20                                                                                                                                                                                                                                                                                </td><td><span style=white-space:pre-wrap>Paris             </span>                                                                                                                                                                                                                                </td><td><span style=white-space:pre-wrap>France           </span>                                                                                                                                                                                                                                 </td><td>Male                                                                                                                                                                                                                                                                                      </td><td><span style=white-space:pre-wrap>NA                </span>                                                                                                                                                                                                                                </td><td><span style=white-space:pre-wrap>NA     </span>                                                                                                                                                                                                                                           </td><td><span style=white-space:pre-wrap>NA     </span>                                                                                                                                                                                                                                           </td><td>1912-06-12                                                                                                                                                                                                                                                                                </td><td><span style=white-space:pre-wrap>Paris          </span>                                                                                                                                                                                                                                   </td><td><span style=white-space:pre-wrap>France     </span>                                                                                                                                                                                                                                       </td></tr>
	<tr><td>1901                                                                                                                                                                                                                                                                                      </td><td><span style=white-space:pre-wrap>Physics   </span>                                                                                                                                                                                                                                        </td><td><span style=white-space:pre-wrap>The Nobel Prize in Physics 1901               </span>                                                                                                                                                                                                    </td><td><span style=white-space:pre-wrap>"in recognition of the extraordinary services he has rendered by the discovery of the remarkable rays subsequently named after him"                                                                                                               </span></td><td>1/1                                                                                                                                                                                                                                                                                       </td><td><span style=white-space:pre-wrap>  1</span>                                                                                                                                                                                                                                               </td><td>Individual                                                                                                                                                                                                                                                                                </td><td>Wilhelm Conrad R&lt;U+00F6&gt;ntgen                                                                                                                                                                                                                                                       </td><td>1845-03-27                                                                                                                                                                                                                                                                                </td><td>Lennep (Remscheid)                                                                                                                                                                                                                                                                        </td><td>Prussia (Germany)                                                                                                                                                                                                                                                                         </td><td>Male                                                                                                                                                                                                                                                                                      </td><td>Munich University                                                                                                                                                                                                                                                                         </td><td>Munich                                                                                                                                                                                                                                                                                    </td><td>Germany                                                                                                                                                                                                                                                                                   </td><td>1923-02-10                                                                                                                                                                                                                                                                                </td><td><span style=white-space:pre-wrap>Munich         </span>                                                                                                                                                                                                                                   </td><td><span style=white-space:pre-wrap>Germany    </span>                                                                                                                                                                                                                                       </td></tr>
</tbody>
</table>



## 2. So, who gets the Nobel Prize?
<p>Just looking at the first couple of prize winners, or Nobel laureates as they are also called, we already see a celebrity: Wilhelm Conrad Röntgen, the guy who discovered X-rays. And actually, we see that all of the winners in 1901 were guys that came from Europe. But that was back in 1901, looking at all winners in the dataset, from 1901 to 2016, which sex and which country is the most commonly represented? </p>
<p>(For <em>country</em>, we will use the <code>birth_country</code> of the winner, as the <code>organization_country</code> is <code>NA</code> for all shared Nobel Prizes.)</p>


```R
# Counting the number of (possibly shared) Nobel Prizes handed
# out between 1901 and 2016
nobel %>% count(sex, birth_country)

# Counting the number of prizes won by male and female recipients.
nobel %>%
    group_by(sex) %>% count()

# Counting the number of prizes won by different nationalities.
nobel %>%
    group_by(birth_country) %>% count() %>% arrange(desc(n)) %>% head(20)
```


<table>
<thead><tr><th scope=col>sex</th><th scope=col>birth_country</th><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>Female                                </td><td>Australia                             </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Austria                               </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Austria-Hungary (Czech Republic)      </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Austrian Empire (Czech Republic)      </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>British Mandate of Palestine (Israel) </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Burma (Myanmar)                       </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Canada                                </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Chile                                 </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>China                                 </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Denmark                               </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Egypt                                 </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>France                                </td><td>2                                     </td></tr>
	<tr><td>Female                                </td><td>Germany                               </td><td>2                                     </td></tr>
	<tr><td>Female                                </td><td>Germany (Poland)                      </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Guatemala                             </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Iran                                  </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Italy                                 </td><td>2                                     </td></tr>
	<tr><td>Female                                </td><td>Kenya                                 </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Liberia                               </td><td>2                                     </td></tr>
	<tr><td>Female                                </td><td>Northern Ireland                      </td><td>2                                     </td></tr>
	<tr><td>Female                                </td><td>Norway                                </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Ottoman Empire (Republic of Macedonia)</td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Pakistan                              </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Persia (Iran)                         </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Poland                                </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Romania                               </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Russian Empire (Poland)               </td><td>2                                     </td></tr>
	<tr><td>Female                                </td><td>South Africa                          </td><td>1                                     </td></tr>
	<tr><td>Female                                </td><td>Sweden                                </td><td>2                                     </td></tr>
	<tr><td>Female                                </td><td>Ukraine                               </td><td>1                                     </td></tr>
	<tr><td>...</td><td>...</td><td>...</td></tr>
	<tr><td>Male                                         </td><td>Russian Empire (Azerbaijan)                  </td><td>  1                                          </td></tr>
	<tr><td>Male                                         </td><td>Russian Empire (Belarus)                     </td><td>  2                                          </td></tr>
	<tr><td>Male                                         </td><td>Russian Empire (Finland)                     </td><td>  3                                          </td></tr>
	<tr><td>Male                                         </td><td>Russian Empire (Latvia)                      </td><td>  1                                          </td></tr>
	<tr><td>Male                                         </td><td>Russian Empire (Lithuania)                   </td><td>  1                                          </td></tr>
	<tr><td>Male                                         </td><td>Russian Empire (Poland)                      </td><td>  3                                          </td></tr>
	<tr><td>Male                                         </td><td>Russian Empire (Russia)                      </td><td>  2                                          </td></tr>
	<tr><td>Male                                         </td><td>Russian Empire (Ukraine)                     </td><td>  2                                          </td></tr>
	<tr><td>Male                                         </td><td>Saint Lucia                                  </td><td>  1                                          </td></tr>
	<tr><td>Male                                         </td><td>Schleswig (Germany)                          </td><td>  2                                          </td></tr>
	<tr><td>Male                                         </td><td>Scotland                                     </td><td>  9                                          </td></tr>
	<tr><td>Male                                         </td><td>South Africa                                 </td><td>  8                                          </td></tr>
	<tr><td>Male                                         </td><td>Southern Rhodesia (Zimbabwe)                 </td><td>  1                                          </td></tr>
	<tr><td>Male                                         </td><td>Spain                                        </td><td>  7                                          </td></tr>
	<tr><td>Male                                         </td><td>Sweden                                       </td><td> 27                                          </td></tr>
	<tr><td>Male                                         </td><td>Switzerland                                  </td><td> 16                                          </td></tr>
	<tr><td>Male                                         </td><td>Taiwan                                       </td><td>  1                                          </td></tr>
	<tr><td>Male                                         </td><td>Tibet (People's Republic of China)           </td><td>  1                                          </td></tr>
	<tr><td>Male                                         </td><td>Trinidad                                     </td><td>  1                                          </td></tr>
	<tr><td>Male                                         </td><td>Turkey                                       </td><td>  2                                          </td></tr>
	<tr><td>Male                                         </td><td>Tuscany (Italy)                              </td><td>  1                                          </td></tr>
	<tr><td>Male                                         </td><td>Union of Soviet Socialist Republics (Belarus)</td><td>  1                                          </td></tr>
	<tr><td>Male                                         </td><td>Union of Soviet Socialist Republics (Russia) </td><td>  4                                          </td></tr>
	<tr><td>Male                                         </td><td>United Kingdom                               </td><td> 85                                          </td></tr>
	<tr><td>Male                                         </td><td>United States of America                     </td><td>248                                          </td></tr>
	<tr><td>Male                                         </td><td>Venezuela                                    </td><td>  1                                          </td></tr>
	<tr><td>Male                                         </td><td>Vietnam                                      </td><td>  1                                          </td></tr>
	<tr><td>Male                                                                                     </td><td><span style=white-space:pre-wrap>W&amp;uuml;rttemberg (Germany)                   </span></td><td><span style=white-space:pre-wrap>  1</span>                                              </td></tr>
	<tr><td>Male                                         </td><td>West Germany (Germany)                       </td><td>  5                                          </td></tr>
	<tr><td>NA                                           </td><td>NA                                           </td><td> 26                                          </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>sex</th><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>Female</td><td> 49   </td></tr>
	<tr><td>Male  </td><td>836   </td></tr>
	<tr><td>NA    </td><td> 26   </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>birth_country</th><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>United States of America</td><td>259                     </td></tr>
	<tr><td>United Kingdom          </td><td> 85                     </td></tr>
	<tr><td>Germany                 </td><td> 61                     </td></tr>
	<tr><td>France                  </td><td> 51                     </td></tr>
	<tr><td>Sweden                  </td><td> 29                     </td></tr>
	<tr><td>NA                      </td><td> 26                     </td></tr>
	<tr><td>Japan                   </td><td> 24                     </td></tr>
	<tr><td>Canada                  </td><td> 18                     </td></tr>
	<tr><td>Netherlands             </td><td> 18                     </td></tr>
	<tr><td>Italy                   </td><td> 17                     </td></tr>
	<tr><td>Russia                  </td><td> 17                     </td></tr>
	<tr><td>Switzerland             </td><td> 16                     </td></tr>
	<tr><td>Austria                 </td><td> 14                     </td></tr>
	<tr><td>Norway                  </td><td> 12                     </td></tr>
	<tr><td>China                   </td><td> 11                     </td></tr>
	<tr><td>Denmark                 </td><td> 11                     </td></tr>
	<tr><td>Australia               </td><td> 10                     </td></tr>
	<tr><td>Belgium                 </td><td>  9                     </td></tr>
	<tr><td>Scotland                </td><td>  9                     </td></tr>
	<tr><td>South Africa            </td><td>  9                     </td></tr>
</tbody>
</table>




## 3. USA dominance
<p>Not so surprising perhaps: the most common Nobel laureate between 1901 and 2016 was a man born in the United States of America. But in 1901 all the laureates were European. When did the USA start to dominate the Nobel Prize charts?</p>


```R
# Calculating the proportion of USA born winners per decade
nobel <- nobel %>% 
    mutate(usa_born_winner = ifelse(birth_country == "United States of America", TRUE, FALSE), decade = year - year %% 10)

prop_usa_winners <- nobel %>% 
    group_by(decade) %>% summarize(proportion = mean(usa_born_winner, na.rm=TRUE))

# Display the proportions of USA born winners per decade
prop_usa_winners
```


<table>
<thead><tr><th scope=col>decade</th><th scope=col>proportion</th></tr></thead>
<tbody>
	<tr><td>1900      </td><td>0.01785714</td></tr>
	<tr><td>1910      </td><td>0.07894737</td></tr>
	<tr><td>1920      </td><td>0.07407407</td></tr>
	<tr><td>1930      </td><td>0.25454545</td></tr>
	<tr><td>1940      </td><td>0.32500000</td></tr>
	<tr><td>1950      </td><td>0.29577465</td></tr>
	<tr><td>1960      </td><td>0.28000000</td></tr>
	<tr><td>1970      </td><td>0.32038835</td></tr>
	<tr><td>1980      </td><td>0.32978723</td></tr>
	<tr><td>1990      </td><td>0.41584158</td></tr>
	<tr><td>2000      </td><td>0.43697479</td></tr>
	<tr><td>2010      </td><td>0.30379747</td></tr>
</tbody>
</table>





## 4. USA dominance, visualized
<p>A table is OK, but to <em>see</em> when the USA started to dominate the Nobel charts we need a plot!</p>


```R
# Setting the size of plots in this notebook
options(repr.plot.width=7, repr.plot.height=4)

# Plotting USA born winners
ggplot(prop_usa_winners, aes(x = decade, y = proportion)) + geom_line() + geom_point() + scale_y_continuous(labels = scales::percent, limits = c(0.0, 1.0), expand = c(0.05, 0.05))
```




![png](output_10_1.png)


## 5. What is the gender of a typical Nobel Prize winner?
<p>So the USA became the dominating winner of the Nobel Prize first in the 1930s and has kept the leading position ever since. But one group that was in the lead from the start, and never seems to let go, are <em>men</em>. Maybe it shouldn't come as a shock that there is some imbalance between how many male and female prize winners there are, but how significant is this imbalance? And is it better or worse within specific prize categories like physics, medicine, literature, etc.?</p>


```R
# Calculating the proportion of female laureates per decade
nobel <- nobel %>% 
    mutate(female_winner = ifelse(sex == "Female", TRUE, FALSE))

prop_female_winners <- nobel %>%
    group_by(decade, category) %>%
   summarize(proportion = mean(female_winner, na.rm=TRUE))

# Plotting the proportion of female laureates per decade
# Plotting USA born winners
ggplot(prop_female_winners, aes(x = decade, y = proportion, color = category)) + geom_line() + geom_point() + scale_y_continuous(labels = scales::percent, limits = c(0.0, 1.0), expand = c(0.05, 0.05))
```




![png](output_13_1.png)


## 6. The first woman to win the Nobel Prize
<p>The plot above is a bit messy as the lines are overplotting. But it does show some interesting trends and patterns. Overall the imbalance is pretty large with physics, economics, and chemistry having the largest imbalance. Medicine has a somewhat positive trend, and since the 1990s the literature prize is also now more balanced. The big outlier is the peace prize during the 2010s, but keep in mind that this just covers the years 2010 to 2016.</p>
<p>Given this imbalance, who was the first woman to receive a Nobel Prize? And in what category?</p>


```R
# Picking out the first woman to win a Nobel Prize
nobel %>%
    filter(sex == "Female") %>% top_n(1, desc(year))
```


<table>
<thead><tr><th scope=col>year</th><th scope=col>category</th><th scope=col>prize</th><th scope=col>motivation</th><th scope=col>prize_share</th><th scope=col>laureate_id</th><th scope=col>laureate_type</th><th scope=col>full_name</th><th scope=col>birth_date</th><th scope=col>birth_city</th><th scope=col>...</th><th scope=col>sex</th><th scope=col>organization_name</th><th scope=col>organization_city</th><th scope=col>organization_country</th><th scope=col>death_date</th><th scope=col>death_city</th><th scope=col>death_country</th><th scope=col>usa_born_winner</th><th scope=col>decade</th><th scope=col>female_winner</th></tr></thead>
<tbody>
	<tr><td>1903                                                                                                                                                          </td><td>Physics                                                                                                                                                       </td><td>The Nobel Prize in Physics 1903                                                                                                                               </td><td>"in recognition of the extraordinary services they have rendered by their joint researches on the radiation phenomena discovered by Professor Henri Becquerel"</td><td>1/4                                                                                                                                                           </td><td>6                                                                                                                                                             </td><td>Individual                                                                                                                                                    </td><td>Marie Curie, n&lt;U+00E9&gt;e Sklodowska                                                                                                                      </td><td>1867-11-07                                                                                                                                                    </td><td>Warsaw                                                                                                                                                        </td><td>...                                                                                                                                                           </td><td>Female                                                                                                                                                        </td><td>NA                                                                                                                                                            </td><td>NA                                                                                                                                                            </td><td>NA                                                                                                                                                            </td><td>1934-07-04                                                                                                                                                    </td><td>Sallanches                                                                                                                                                    </td><td>France                                                                                                                                                        </td><td>FALSE                                                                                                                                                         </td><td>1900                                                                                                                                                          </td><td>TRUE                                                                                                                                                          </td></tr>
</tbody>
</table>


## 7. Repeat laureates
<p>For most scientists/writers/activists a Nobel Prize would be the crowning achievement of a long career. But for some people, one is just not enough, and there are few that have gotten it more than once. Who are these lucky few? (Having won no Nobel Prize myself, I'll assume it's just about luck.)</p>


```R
# Selecting the laureates that have received 2 or more prizes.
nobel %>%
    group_by(full_name) %>% count() %>% filter(n > 1)
```


<table>
<thead><tr><th scope=col>full_name</th><th scope=col>n</th></tr></thead>
<tbody>
	<tr><td>Comit&lt;U+00E9&gt; international de la Croix Rouge (International Committee of the Red Cross)</td><td>3                                                                                             </td></tr>
	<tr><td>Frederick Sanger                                                                        </td><td>2                                                                                       </td></tr>
	<tr><td>John Bardeen                                                                            </td><td>2                                                                                       </td></tr>
	<tr><td>Linus Carl Pauling                                                                      </td><td>2                                                                                       </td></tr>
	<tr><td><span style=white-space:pre-wrap>Marie Curie, n&lt;U+00E9&gt;e Sklodowska                                                      </span></td><td>2                                                                                                                                     </td></tr>
	<tr><td>Office of the United Nations High Commissioner for Refugees (UNHCR)                     </td><td>2                                                                                       </td></tr>
</tbody>
</table>

## 8. How old are you when you get the prize?
<p>The list of repeat winners contains some illustrious names! We again meet Marie Curie, who got the prize in physics for discovering radiation and in chemistry for isolating radium and polonium. John Bardeen got it twice in physics for transistors and superconductivity, Frederick Sanger got it twice in chemistry, and Linus Carl Pauling got it first in chemistry and later in peace for his work in promoting nuclear disarmament. We also learn that organizations also get the prize as both the Red Cross and the UNHCR have gotten it twice.</p>
<p>But how old are you generally when you get the prize?</p>


```R
# Loading the lubridate package
library(lubridate)

# Calculating the age of Nobel Prize winners
nobel_age <- nobel %>%
    mutate(age = year - year(birth_date))

# Plotting the age of Nobel Prize winners
ggplot(nobel_age, aes(x = year, y = age))  + geom_point() + geom_smooth()
```

    `geom_smooth()` using method = 'loess' and formula 'y ~ x'
    Warning message:
    "Removed 28 rows containing non-finite values (stat_smooth)."Warning message:
    "Removed 28 rows containing missing values (geom_point)."




![png](output_22_2.png)


## 9. Age differences between prize categories
<p>The plot above shows us a lot! We see that people use to be around 55 when they received the price, but nowadays the average is closer to 65. But there is a large spread in the laureates' ages, and while most are 50+, some are very young.</p>
<p>We also see that the density of points is much high nowadays than in the early 1900s -- nowadays many more of the prizes are shared, and so there are many more winners. We also see that there was a disruption in awarded prizes around the Second World War (1939 - 1945). </p>
<p>Let's look at age trends within different prize categories.</p>


```R
# Same plot as above, but faceted by the category of the Nobel Prize
ggplot(nobel_age, aes(x = year, y = age))  + geom_point() + geom_smooth(se = FALSE) + facet_wrap(~category)
```

    `geom_smooth()` using method = 'loess' and formula 'y ~ x'
    Warning message:
    "Removed 28 rows containing non-finite values (stat_smooth)."Warning message:
    "Removed 28 rows containing missing values (geom_point)."




![png](output_25_2.png)



## 10. Oldest and youngest winners
<p>Another plot with lots of exciting stuff going on! We see that both winners of the chemistry, medicine, and physics prize have gotten older over time. The trend is strongest for physics: the average age used to be below 50, and now it's almost 70. Literature and economics are more stable, and we also see that economics is a newer category. But peace shows an opposite trend where winners are getting younger! </p>
<p>In the peace category we also a winner around 2010 that seems exceptionally young. This begs the questions, who are the oldest and youngest people ever to have won a Nobel Prize?</p>


```R
# The oldest winner of a Nobel Prize as of 2016
nobel_age %>% top_n(1,age)

# The youngest winner of a Nobel Prize as of 2016
nobel_age %>% top_n(1,desc(age))
```


<table>
<thead><tr><th scope=col>year</th><th scope=col>category</th><th scope=col>prize</th><th scope=col>motivation</th><th scope=col>prize_share</th><th scope=col>laureate_id</th><th scope=col>laureate_type</th><th scope=col>full_name</th><th scope=col>birth_date</th><th scope=col>birth_city</th><th scope=col>...</th><th scope=col>organization_name</th><th scope=col>organization_city</th><th scope=col>organization_country</th><th scope=col>death_date</th><th scope=col>death_city</th><th scope=col>death_country</th><th scope=col>usa_born_winner</th><th scope=col>decade</th><th scope=col>female_winner</th><th scope=col>age</th></tr></thead>
<tbody>
	<tr><td>2007                                                        </td><td>Economics                                                   </td><td>The Sveriges Riksbank Prize in Economic Sciences 2007       </td><td>"for having laid the foundations of mechanism design theory"</td><td>1/3                                                         </td><td>820                                                         </td><td>Individual                                                  </td><td>Leonid Hurwicz                                              </td><td>1917-08-21                                                  </td><td>Moscow                                                      </td><td>...                                                         </td><td>University of Minnesota                                     </td><td>Minneapolis, MN                                             </td><td>United States of America                                    </td><td>2008-06-24                                                  </td><td>Minneapolis, MN                                             </td><td>United States of America                                    </td><td>FALSE                                                       </td><td>2000                                                        </td><td>FALSE                                                       </td><td>90                                                          </td></tr>
</tbody>
</table>




<table>
<thead><tr><th scope=col>year</th><th scope=col>category</th><th scope=col>prize</th><th scope=col>motivation</th><th scope=col>prize_share</th><th scope=col>laureate_id</th><th scope=col>laureate_type</th><th scope=col>full_name</th><th scope=col>birth_date</th><th scope=col>birth_city</th><th scope=col>...</th><th scope=col>organization_name</th><th scope=col>organization_city</th><th scope=col>organization_country</th><th scope=col>death_date</th><th scope=col>death_city</th><th scope=col>death_country</th><th scope=col>usa_born_winner</th><th scope=col>decade</th><th scope=col>female_winner</th><th scope=col>age</th></tr></thead>
<tbody>
	<tr><td>2014                                                                                                                    </td><td>Peace                                                                                                                   </td><td>The Nobel Peace Prize 2014                                                                                              </td><td>"for their struggle against the suppression of children and young people and for the right of all children to education"</td><td>1/2                                                                                                                     </td><td>914                                                                                                                     </td><td>Individual                                                                                                              </td><td>Malala Yousafzai                                                                                                        </td><td>1997-07-12                                                                                                              </td><td>Mingora                                                                                                                 </td><td>...                                                                                                                     </td><td>NA                                                                                                                      </td><td>NA                                                                                                                      </td><td>NA                                                                                                                      </td><td>NA                                                                                                                      </td><td>NA                                                                                                                      </td><td>NA                                                                                                                      </td><td>FALSE                                                                                                                   </td><td>2010                                                                                                                    </td><td>TRUE                                                                                                                    </td><td>17                                                                                                                      </td></tr>
</tbody>
</table>



## 11. Youngest Winner
<p>The name of the youngest winner ever who in 2014 got the prize for "[her] struggle against the suppression of children and young people and for the right of all children to education"?</p>


```R
# The name of the youngest winner of the Nobel Prize as of 2016
youngest_winner <- "Malala Yousafzai"
```


