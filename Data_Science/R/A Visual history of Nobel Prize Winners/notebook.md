
## 1. The most Nobel of Prizes
<p><img style="float: right;margin:5px 20px 5px 1px; max-width:250px" src="https://s3.amazonaws.com/assets.datacamp.com/production/project_309/img/Nobel_Prize.png"></p>
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

    Parsed with column specification:
    cols(
      year = col_integer(),
      category = col_character(),
      prize = col_character(),
      motivation = col_character(),
      prize_share = col_character(),
      laureate_id = col_integer(),
      laureate_type = col_character(),
      full_name = col_character(),
      birth_date = col_date(format = ""),
      birth_city = col_character(),
      birth_country = col_character(),
      sex = col_character(),
      organization_name = col_character(),
      organization_city = col_character(),
      organization_country = col_character(),
      death_date = col_date(format = ""),
      death_city = col_character(),
      death_country = col_character()
    )



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




```R
library(testthat) 
library(IRkernel.testthat)

run_tests({
    test_that("Test that tidyverse is loaded", {
    expect_true( "package:tidyverse" %in% search(), 
        info = "The tidyverse package should be loaded using library().")
    })
    
    test_that("Read in data correctly.", {
        expect_is(nobel, "tbl_df", 
            info = 'You should use read_csv (with an underscore) to read "datasets/nobel.csv" into nobel.')
    })
    
    test_that("Read in data correctly.", {
        nobel_temp <- read_csv('datasets/nobel.csv')
        expect_equivalent(nobel, nobel_temp, 
            info = 'nobel should contain the data in "datasets/nobel.csv".')
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 20.044 0.455 2729.658 0.006 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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




```R
last_value <- .Last.value

correct_value <- nobel %>%
    group_by(birth_country) %>%
    count()  %>% 
    arrange(desc(n))  %>% 
    head(20)

run_tests({
    test_that("That the by country count is correct", {
    expect_equivalent(last_value$birth_country[1], last_value$birth_country[1], 
        info = "The countries should be arranged by n, arrange(desc(n)), and the top country should be United States of America")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 20.146 0.459 2729.762 0.006 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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




```R
correct_prop_usa_winners <- nobel %>% 
    mutate(usa_born_winner = birth_country == "United States of America",
           decade = floor(year / 10) * 10 ) %>% 
    group_by(decade) %>%
    summarize(proportion = mean(usa_born_winner, na.rm = TRUE))

run_tests({
    test_that("prop_usa_winners is calculated correctly", {
    expect_true("proportion" %in% names(prop_usa_winners) &
                all(prop_usa_winners$proportion %in% correct_prop_usa_winners$proportion), 
        info = "The column proportion in prop_usa_winners should contain the proportion of usa_born_winner by decade.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 20.189 0.463 2729.809 0.006 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


## 4. USA dominance, visualized
<p>A table is OK, but to <em>see</em> when the USA started to dominate the Nobel charts we need a plot!</p>


```R
# Setting the size of plots in this notebook
options(repr.plot.width=7, repr.plot.height=4)

# Plotting USA born winners
ggplot(prop_usa_winners, aes(x = decade, y = proportion)) + geom_line() + geom_point() + scale_y_continuous(labels = scales::percent, limits = c(0.0, 1.0), expand = c(0.05, 0.05))
```




![png](output_10_1.png)



```R
p <- last_plot()

correct_p <- ggplot(prop_usa_winners, aes(decade, proportion)) +
    geom_line() + geom_point() +
    scale_y_continuous(labels = scales::percent, limits = 0:1, expand = c(0,0))

run_tests({
    test_that("The plot uses the correct dataset", {
    expect_equivalent(p$data, correct_p$data, 
        info = "The plot should show the data in prop_usa_winners.")
    })
    
    test_that("correct columns are plotted", {
        mappings <- str_replace(as.character(p$mapping), "~", "")
        expect_true(all(c("decade", "proportion") %in% mappings), 
            info = "You should plot decade on the x-axis, prop_female on the y-axis, and category should be mapped to color.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 20.404 0.463 2730.023 0.006 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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



```R
p <- last_plot()

correct_prop_female_winners <- nobel %>%
    mutate(female_winner = sex == "Female",
           decade = floor(year / 10) * 10)  %>% 
    group_by(decade, category)  %>% 
    summarize(proportion = mean(female_winner, na.rm = TRUE))

run_tests({
    test_that("prop_female_winners$prop_female is correct", {
    expect_true(all(prop_female_winners$proportion %in% correct_prop_female_winners$proportion), 
        info = "prop_female_winners$prop_female need to have the proportion of female winners per decade.")
    })
    
    test_that("correct columns are plotted", {
    mappings <- str_replace(as.character(p$mapping), "~", "")
    expect_true(all(c("decade", "proportion", "category") %in% mappings), 
        info = "You should plot decade on the x-axis, prop_female on the y-axis, and category should be mapped to color.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 20.968 0.463 2730.587 0.006 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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




```R
last_value <- .Last.value

correct_last_value <- nobel %>%
    filter(sex == "Female")  %>% 
    top_n(1, desc(year))

run_tests({
    test_that("Marie Curie is picked out.", {
    expect_equivalent(last_value$full_name, correct_last_value$full_name,
        info = "You should pick out the first woman to win a Nobel Prize. Hint: Her first name was Marie.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 21.02 0.463 2730.638 0.006 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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




```R
last_value <- .Last.value

correct_last_value <- nobel %>%
    group_by(full_name)  %>% 
    count()  %>% 
    filter(n >= 2)

run_tests({
    test_that("The right winners were selected", {
    expect_equivalent(sort(last_value$full_name), sort(correct_last_value$full_name),
        info = "You should filter away everybody that didn't win the prize at least twice.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 21.109 0.463 2730.726 0.006 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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



```R
p <- last_plot()

correct_nobel_age <- nobel %>%
    mutate(age = year - year(birth_date))

run_tests({
    test_that("nobel_age$age is correct", {
    expect_true(all(nobel_age$age %in% correct_nobel_age$age), 
        info = "nobel_age$age need to have the age of the winner when they received the prize.")
    })
    
    test_that("correct columns are plotted", {
    mappings <- str_replace(as.character(p$mapping), "~", "")
    expect_true(all(c("year", "age") %in% mappings), 
        info = "You should plot year on the x-axis and age on the y-axis.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 21.409 0.467 2731.03 0.006 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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



```R
facet_class <- class(last_plot()$facet)

run_tests({
    test_that("The plot is faceted", {
    expect_true(! "FacetNull" %in% facet_class, 
        info = "The plot needs to be faceted by category. Try using facet_wrap().")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 22.065 0.467 2731.685 0.006 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


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




```R
last_value <- .Last.value
correct_last_value <- nobel_age %>% top_n(1, desc(age))

run_tests({
    test_that("The youngest winner is correct", {
    expect_equivalent(last_value$full_name, correct_last_value$full_name,
        info = "The last row you extract in the code cell should be the youngest Nobel Prize winner.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 22.118 0.467 2731.738 0.006 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 


## 11. You get a prize!
<p><img style="float: right;margin:20px 20px 20px 20px; max-width:200px" src="https://s3.amazonaws.com/assets.datacamp.com/production/project_309/img/paint_nobel_prize.png"></p>
<p>Hey! You get a prize for making it to the very end of this notebook! It might not be a Nobel Prize, but I made it myself in paint so it should count for something. But don't despair, Leonid Hurwicz was 90 years old when he got his prize, so it might not be too late for you. Who knows.</p>
<p>Before you leave, what was again the name of the youngest winner ever who in 2014 got the prize for "[her] struggle against the suppression of children and young people and for the right of all children to education"?</p>


```R
# The name of the youngest winner of the Nobel Prize as of 2016
youngest_winner <- "Malala Yousafzai"
```


```R
run_tests({
    test_that("youngest_winner is correct", {
    expect_true(any(str_detect(tolower(youngest_winner), c("malala", "yousafzai"))), 
        info = "youngest_winner should be a string. Try writing only the first / given name.")
    })
})
```




    <ProjectReporter>
      Inherits from: <ListReporter>
      Public:
        .context: NULL
        .end_context: function (context) 
        .start_context: function (context) 
        add_result: function (context, test, result) 
        all_tests: environment
        cat_line: function (...) 
        cat_tight: function (...) 
        clone: function (deep = FALSE) 
        current_expectations: environment
        current_file: some name
        current_start_time: 22.149 0.467 2731.768 0.006 0
        dump_test: function (test) 
        end_context: function (context) 
        end_reporter: function () 
        end_test: function (context, test) 
        get_results: function () 
        initialize: function (...) 
        is_full: function () 
        out: 3
        results: environment
        rule: function (...) 
        start_context: function (context) 
        start_file: function (name) 
        start_reporter: function () 
        start_test: function (context, test) 

