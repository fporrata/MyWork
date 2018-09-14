
## 1. Welcome to the world of data science
<p>Throughout the world of data science, there are many languages and tools that can be used to complete a given task. While you are often able to use whichever tool you prefer, it is often important for analysts to work with similar platforms so that they can share their code with one another. Learning what professionals in the data science industry use while at work can help you gain a better understanding of things that you may be asked to do in the future. </p>
<p>In this project, we are going to find out what tools and languages professionals use in their day-to-day work. Our data comes from the <a href="https://www.kaggle.com/kaggle/kaggle-survey-2017?utm_medium=partner&utm_source=datacamp.com&utm_campaign=ml+survey+case+study">Kaggle Data Science Survey</a> which includes responses from over 10,000 people that write code to analyze data in their daily work. </p>


```R
# Loading necessary packages
library(tidyverse)

# Loading the data
responses <- read_csv("datasets/kagglesurvey.csv")

# Printing the first 10 rows
head(responses, n = 10)
```

    Parsed with column specification:
    cols(
      Respondent = col_integer(),
      WorkToolsSelect = col_character(),
      LanguageRecommendationSelect = col_character(),
      EmployerIndustry = col_character(),
      WorkAlgorithmsSelect = col_character()
    )



<table>
<thead><tr><th scope=col>Respondent</th><th scope=col>WorkToolsSelect</th><th scope=col>LanguageRecommendationSelect</th><th scope=col>EmployerIndustry</th><th scope=col>WorkAlgorithmsSelect</th></tr></thead>
<tbody>
	<tr><td> 1                                                                                                                                                                                                                 </td><td>Amazon Web services,Oracle Data Mining/ Oracle R Enterprise,Perl                                                                                                                                                   </td><td>F#                                                                                                                                                                                                                 </td><td>Internet-based                                                                                                                                                                                                     </td><td>Neural Networks,Random Forests,RNNs                                                                                                                                                                                </td></tr>
	<tr><td> 2                                                                                                                                                                                                                 </td><td>Amazon Machine Learning,Amazon Web services,Cloudera,Hadoop/Hive/Pig,Impala,Java,Mathematica,MATLAB/Octave,Microsoft Excel Data Mining,Microsoft SQL Server Data Mining,NoSQL,Python,R,SAS Base,SAS JMP,SQL,Tableau</td><td>Python                                                                                                                                                                                                             </td><td>Mix of fields                                                                                                                                                                                                      </td><td>Bayesian Techniques,Decision Trees,Random Forests,Regression/Logistic Regression                                                                                                                                   </td></tr>
	<tr><td> 3                                                                                                                                                                                                                 </td><td>C/C++,Jupyter notebooks,MATLAB/Octave,Python,R,TensorFlow                                                                                                                                                          </td><td>Python                                                                                                                                                                                                             </td><td>Technology                                                                                                                                                                                                         </td><td>Bayesian Techniques,CNNs,Ensemble Methods,Neural Networks,Regression/Logistic Regression,SVMs                                                                                                                      </td></tr>
	<tr><td> 4                                                                                                                                                                                                                 </td><td>Jupyter notebooks,Python,SQL,TensorFlow                                                                                                                                                                            </td><td>Python                                                                                                                                                                                                             </td><td>Academic                                                                                                                                                                                                           </td><td>Bayesian Techniques,CNNs,Decision Trees,Gradient Boosted Machines,Neural Networks,Random Forests,Regression/Logistic Regression                                                                                    </td></tr>
	<tr><td> 5                                                                                                                                                                                                                 </td><td>C/C++,Cloudera,Hadoop/Hive/Pig,Java,NoSQL,R,Unix shell / awk                                                                                                                                                       </td><td>R                                                                                                                                                                                                                  </td><td>Government                                                                                                                                                                                                         </td><td>NA                                                                                                                                                                                                                 </td></tr>
	<tr><td> 6                                                                                                                                                                                                                 </td><td>SQL                                                                                                                                                                                                                </td><td>Python                                                                                                                                                                                                             </td><td>Non-profit                                                                                                                                                                                                         </td><td>NA                                                                                                                                                                                                                 </td></tr>
	<tr><td> 7                                                                                                                                                                                                                 </td><td>Jupyter notebooks,NoSQL,Python,R,SQL,Unix shell / awk                                                                                                                                                              </td><td>Python                                                                                                                                                                                                             </td><td>Internet-based                                                                                                                                                                                                     </td><td>CNNs,Decision Trees,Gradient Boosted Machines,Random Forests,Regression/Logistic Regression,SVMs                                                                                                                   </td></tr>
	<tr><td> 8                                                                                                                                                                                                                 </td><td>Python,Spark / MLlib,Tableau,TensorFlow,Other                                                                                                                                                                      </td><td>Python                                                                                                                                                                                                             </td><td>Mix of fields                                                                                                                                                                                                      </td><td>Bayesian Techniques,CNNs,HMMs,Neural Networks,Random Forests,Regression/Logistic Regression,SVMs                                                                                                                   </td></tr>
	<tr><td> 9                                                                                                                                                                                                                 </td><td>Jupyter notebooks,MATLAB/Octave,Python,SAS Base,SQL                                                                                                                                                                </td><td>Python                                                                                                                                                                                                             </td><td>Financial                                                                                                                                                                                                          </td><td>Ensemble Methods,Gradient Boosted Machines                                                                                                                                                                         </td></tr>
	<tr><td>10                                                                                                                                                                                                                 </td><td>C/C++,IBM Cognos,MATLAB/Octave,Microsoft Excel Data Mining,Microsoft R Server (Formerly Revolution Analytics),Microsoft SQL Server Data Mining,Perl,Python,R,SQL,Unix shell / awk                                  </td><td>R                                                                                                                                                                                                                  </td><td>Technology                                                                                                                                                                                                         </td><td>Bayesian Techniques,Regression/Logistic Regression                                                                                                                                                                 </td></tr>
</tbody>
</table>




```R
library("testthat")
library('IRkernel.testthat')

run_tests({
    test_that("Read in data correctly.", {
        expect_is(responses, "tbl_df", 
            info = 'You should use read_csv (with an underscore) to read "datasets/kagglesurvey.csv" into responses')
    })
    
    test_that("Read in data correctly.", {
        responses_test <- read_csv('datasets/kagglesurvey.csv')
        expect_equivalent(responses, responses_test, 
            info = 'responses should contain the data in "datasets/kagglesurvey.csv"')
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
        current_start_time: 25.732 0.448 7478.173 0.003 0.002
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


## 2. Using multiple tools
<p>Now that we've loaded in the survey results, we want to focus on the tools and languages that the survey respondents use at work. </p>


```R
# Printing the first respondents' tools and languages
#responses[1,"WorkToolsSelect"]
#strsplit(responses[1,"WorkToolsSelect"], split = ",")
# Creating a new data frame called tools
tools <- responses

# Adding a new column to tools which splits the WorkToolsSelect column at the commas and unnests the new column
tools <- tools  %>% 
    mutate(work_tools = strsplit(WorkToolsSelect, split =",")) %>% unnest(work_tools)

# Viewing the first 6 rows of tools
head(tools)
```


<table>
<thead><tr><th scope=col>Respondent</th><th scope=col>WorkToolsSelect</th><th scope=col>LanguageRecommendationSelect</th><th scope=col>EmployerIndustry</th><th scope=col>WorkAlgorithmsSelect</th><th scope=col>work_tools</th></tr></thead>
<tbody>
	<tr><td>1                                                                                                                                                                                                                  </td><td>Amazon Web services,Oracle Data Mining/ Oracle R Enterprise,Perl                                                                                                                                                   </td><td>F#                                                                                                                                                                                                                 </td><td>Internet-based                                                                                                                                                                                                     </td><td>Neural Networks,Random Forests,RNNs                                                                                                                                                                                </td><td>Amazon Web services                                                                                                                                                                                                </td></tr>
	<tr><td>1                                                                                                                                                                                                                  </td><td>Amazon Web services,Oracle Data Mining/ Oracle R Enterprise,Perl                                                                                                                                                   </td><td>F#                                                                                                                                                                                                                 </td><td>Internet-based                                                                                                                                                                                                     </td><td>Neural Networks,Random Forests,RNNs                                                                                                                                                                                </td><td>Oracle Data Mining/ Oracle R Enterprise                                                                                                                                                                            </td></tr>
	<tr><td>1                                                                                                                                                                                                                  </td><td>Amazon Web services,Oracle Data Mining/ Oracle R Enterprise,Perl                                                                                                                                                   </td><td>F#                                                                                                                                                                                                                 </td><td>Internet-based                                                                                                                                                                                                     </td><td>Neural Networks,Random Forests,RNNs                                                                                                                                                                                </td><td>Perl                                                                                                                                                                                                               </td></tr>
	<tr><td>2                                                                                                                                                                                                                  </td><td>Amazon Machine Learning,Amazon Web services,Cloudera,Hadoop/Hive/Pig,Impala,Java,Mathematica,MATLAB/Octave,Microsoft Excel Data Mining,Microsoft SQL Server Data Mining,NoSQL,Python,R,SAS Base,SAS JMP,SQL,Tableau</td><td>Python                                                                                                                                                                                                             </td><td>Mix of fields                                                                                                                                                                                                      </td><td>Bayesian Techniques,Decision Trees,Random Forests,Regression/Logistic Regression                                                                                                                                   </td><td>Amazon Machine Learning                                                                                                                                                                                            </td></tr>
	<tr><td>2                                                                                                                                                                                                                  </td><td>Amazon Machine Learning,Amazon Web services,Cloudera,Hadoop/Hive/Pig,Impala,Java,Mathematica,MATLAB/Octave,Microsoft Excel Data Mining,Microsoft SQL Server Data Mining,NoSQL,Python,R,SAS Base,SAS JMP,SQL,Tableau</td><td>Python                                                                                                                                                                                                             </td><td>Mix of fields                                                                                                                                                                                                      </td><td>Bayesian Techniques,Decision Trees,Random Forests,Regression/Logistic Regression                                                                                                                                   </td><td>Amazon Web services                                                                                                                                                                                                </td></tr>
	<tr><td>2                                                                                                                                                                                                                  </td><td>Amazon Machine Learning,Amazon Web services,Cloudera,Hadoop/Hive/Pig,Impala,Java,Mathematica,MATLAB/Octave,Microsoft Excel Data Mining,Microsoft SQL Server Data Mining,NoSQL,Python,R,SAS Base,SAS JMP,SQL,Tableau</td><td>Python                                                                                                                                                                                                             </td><td>Mix of fields                                                                                                                                                                                                      </td><td>Bayesian Techniques,Decision Trees,Random Forests,Regression/Logistic Regression                                                                                                                                   </td><td>Cloudera                                                                                                                                                                                                           </td></tr>
</tbody>
</table>




```R
run_tests({
    test_that("Tools and Languages were Split and Unnested", {
        expect_true(nrow(tools) == 47409, 
            info = 'Make sure that you split the tools at the commas and unnested them')
    })
    
    test_that("Tools and Languages were Unnested", {
        expect_is(tools$work_tools, "character", 
            info = 'The work_tools column should be of class "character". Make sure that you unnested the results of strsplit()')
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
        current_start_time: 25.86 0.448 7478.301 0.003 0.002
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


## 3. Counting users of each tool
<p>Now that we've split apart all of the tools used by each respondent, we can figure out which tools are the most popular.</p>


```R
# Creating a new data frame
tool_count <- tools

# Grouping the data by work_tools, calculate the number of responses in each group
tool_count <- tool_count  %>% 
    group_by(work_tools)  %>% 
    summarise(number_responses = n())

# Sorting tool_count so that the most popular tools are at the top
tool_count <- tool_count %>% arrange(desc(number_responses))

# Printing the first 6 results
head(tool_count)
```


<table>
<thead><tr><th scope=col>work_tools</th><th scope=col>number_responses</th></tr></thead>
<tbody>
	<tr><td>Python           </td><td>6073             </td></tr>
	<tr><td>R                </td><td>4708             </td></tr>
	<tr><td>SQL              </td><td>4261             </td></tr>
	<tr><td>Jupyter notebooks</td><td>3206             </td></tr>
	<tr><td>TensorFlow       </td><td>2256             </td></tr>
	<tr><td>NA               </td><td>2198             </td></tr>
</tbody>
</table>




```R
run_tests({
    test_that("Tools were Grouped and Summarised", {
        expect_true(nrow(tool_count) == 50, 
            info = 'Make sure that you grouped by tools and then summarised')
    })
    
    test_that("Values were sorted correctly", {
        expect_true(tool_count[1, 2] == 6073, 
            info = 'Do not forget to sort your tool counts from largest to smallest')
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
        current_start_time: 25.897 0.455 7478.344 0.003 0.002
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


## 4. Plotting the most popular tools
<p>Let's see how your favorite tools stack up against the rest. </p>


```R
# Creating a bar chart of the work_tools column. 
# Arranging the bars so that the tallest are on the far right
tool_count %>% filter(!is.na(work_tools)) %>%  ggplot(aes(x = reorder(work_tools, number_responses), y = number_responses)) + 
    geom_bar(stat = "identity") +

# Rotating the bar labels 90 degrees
    theme(axis.text.x = element_text(angle = 90, hjust = 1))
```




![png](output_10_1.png)



```R
run_tests({
   test_that("Plot is a bar chart",{
      p <- last_plot()
      q <- p$layers[[1]]
      expect_is(q$geom, "GeomBar", 
                info = "You should plot a bar chart with ggplot")
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
        current_start_time: 26.167 0.455 7478.614 0.003 0.002
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


## 5. The R vs Python debate
<p>Within the field of data science, there is a lot of debate among professionals about whether R or Python should reign supreme. You can see from our last figure that R and Python are the two most commonly used languages, but it's possible that many respondents use both R and Python. Let's take a look at how many people use R, Python, and both tools.</p>


```R
# Creating a new data frame called debate_tools
debate_tools <- responses

# Creating a new column called language preference, based on the conditions specified in the Instructions
debate_tools <- debate_tools  %>% 
   mutate(language_preference = case_when(grepl("R", WorkToolsSelect, fixed = TRUE) & !grepl("Python", WorkToolsSelect, fixed = TRUE) ~ "R",
         !grepl("R", WorkToolsSelect, fixed = TRUE) & grepl("Python", WorkToolsSelect, fixed = TRUE) ~ "Python",
         grepl("R", WorkToolsSelect, fixed = TRUE) & grepl("Python", WorkToolsSelect, fixed = TRUE) ~ "both", 
         !grepl("R", WorkToolsSelect, fixed = TRUE) & !grepl("Python", WorkToolsSelect, fixed = TRUE) ~ "neither" 
         ))

# Printing the first 6 rows
head(debate_tools)
```


<table>
<thead><tr><th scope=col>Respondent</th><th scope=col>WorkToolsSelect</th><th scope=col>LanguageRecommendationSelect</th><th scope=col>EmployerIndustry</th><th scope=col>WorkAlgorithmsSelect</th><th scope=col>language_preference</th></tr></thead>
<tbody>
	<tr><td>1                                                                                                                                                                                                                  </td><td>Amazon Web services,Oracle Data Mining/ Oracle R Enterprise,Perl                                                                                                                                                   </td><td>F#                                                                                                                                                                                                                 </td><td>Internet-based                                                                                                                                                                                                     </td><td>Neural Networks,Random Forests,RNNs                                                                                                                                                                                </td><td>R                                                                                                                                                                                                                  </td></tr>
	<tr><td>2                                                                                                                                                                                                                  </td><td>Amazon Machine Learning,Amazon Web services,Cloudera,Hadoop/Hive/Pig,Impala,Java,Mathematica,MATLAB/Octave,Microsoft Excel Data Mining,Microsoft SQL Server Data Mining,NoSQL,Python,R,SAS Base,SAS JMP,SQL,Tableau</td><td>Python                                                                                                                                                                                                             </td><td>Mix of fields                                                                                                                                                                                                      </td><td>Bayesian Techniques,Decision Trees,Random Forests,Regression/Logistic Regression                                                                                                                                   </td><td>both                                                                                                                                                                                                               </td></tr>
	<tr><td>3                                                                                                                                                                                                                  </td><td>C/C++,Jupyter notebooks,MATLAB/Octave,Python,R,TensorFlow                                                                                                                                                          </td><td>Python                                                                                                                                                                                                             </td><td>Technology                                                                                                                                                                                                         </td><td>Bayesian Techniques,CNNs,Ensemble Methods,Neural Networks,Regression/Logistic Regression,SVMs                                                                                                                      </td><td>both                                                                                                                                                                                                               </td></tr>
	<tr><td>4                                                                                                                                                                                                                  </td><td>Jupyter notebooks,Python,SQL,TensorFlow                                                                                                                                                                            </td><td>Python                                                                                                                                                                                                             </td><td>Academic                                                                                                                                                                                                           </td><td>Bayesian Techniques,CNNs,Decision Trees,Gradient Boosted Machines,Neural Networks,Random Forests,Regression/Logistic Regression                                                                                    </td><td>Python                                                                                                                                                                                                             </td></tr>
	<tr><td>5                                                                                                                                                                                                                  </td><td>C/C++,Cloudera,Hadoop/Hive/Pig,Java,NoSQL,R,Unix shell / awk                                                                                                                                                       </td><td>R                                                                                                                                                                                                                  </td><td>Government                                                                                                                                                                                                         </td><td>NA                                                                                                                                                                                                                 </td><td>R                                                                                                                                                                                                                  </td></tr>
	<tr><td>6                                                                                                                                                                                                                  </td><td>SQL                                                                                                                                                                                                                </td><td>Python                                                                                                                                                                                                             </td><td>Non-profit                                                                                                                                                                                                         </td><td>NA                                                                                                                                                                                                                 </td><td>neither                                                                                                                                                                                                            </td></tr>
</tbody>
</table>




```R
run_tests({
    test_that("New column was created", {
        expect_is(debate_tools$language_preference, "character", 
            info = 'The language_preference column should be of class "character". Make sure that you filled this new column correctly')
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
        current_start_time: 26.223 0.455 7478.669 0.003 0.002
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


## 6. Plotting R vs Python users
<p>Now we just need to take a closer look at how many respondents use R, Python, and both!</p>


```R
# Creating a new data frame
debate_plot <-debate_tools

# Grouping by language preference and calculate number of responses
debate_plot <- debate_plot  %>% 
   group_by(language_preference)  %>% 
    summarise(number_responses = n())  %>% 

# Removing the row for users of "neither"
  filter(language_preference != "neither")

# Creating a bar chart
debate_plot %>% ggplot(aes(x = language_preference, y = number_responses)) + 
    geom_bar(stat = "identity")
```




![png](output_16_1.png)



```R
run_tests({
   test_that("Plot is a bar chart",{
      p <- last_plot()
      q <- p$layers[[1]]
      expect_is(q$geom, "GeomBar",
               info = "You should plot a bar chart with ggplot")
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
        current_start_time: 26.523 0.456 7478.969 0.003 0.002
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


## 7. Language recommendations
<p>It looks like the largest group of professionals program in both Python and R. But what happens when they are asked which language they recommend to new learners? Do R lovers always recommend R? </p>


```R
# Creating a new data frame
recommendations <- debate_tools

# Grouping by language_preference and then LanguageRecommendationSelect
recommendations <- recommendations  %>% 
    group_by(language_preference,LanguageRecommendationSelect)  %>% 
    summarise(number_responses = n()) 



# Removing empty responses and include the top recommendations
recommendations <- recommendations %>% filter(!is.na(LanguageRecommendationSelect)) %>% top_n(4)
recommendations
```

    Selecting by number_responses



<table>
<thead><tr><th scope=col>language_preference</th><th scope=col>LanguageRecommendationSelect</th><th scope=col>number_responses</th></tr></thead>
<tbody>
	<tr><td>Python  </td><td>C/C++/C#</td><td>  48    </td></tr>
	<tr><td>Python  </td><td>Matlab  </td><td>  43    </td></tr>
	<tr><td>Python  </td><td>Python  </td><td>1742    </td></tr>
	<tr><td>Python  </td><td>SQL     </td><td>  36    </td></tr>
	<tr><td>R       </td><td>C/C++/C#</td><td>  27    </td></tr>
	<tr><td>R       </td><td>Python  </td><td> 194    </td></tr>
	<tr><td>R       </td><td>R       </td><td> 632    </td></tr>
	<tr><td>R       </td><td>SQL     </td><td>  75    </td></tr>
	<tr><td>both    </td><td>Python  </td><td>1917    </td></tr>
	<tr><td>both    </td><td>R       </td><td> 912    </td></tr>
	<tr><td>both    </td><td>SQL     </td><td> 108    </td></tr>
	<tr><td>both    </td><td>Scala   </td><td>  28    </td></tr>
	<tr><td>neither </td><td>Matlab  </td><td>  47    </td></tr>
	<tr><td>neither </td><td>Python  </td><td> 196    </td></tr>
	<tr><td>neither </td><td>R       </td><td>  94    </td></tr>
	<tr><td>neither </td><td>SQL     </td><td>  53    </td></tr>
</tbody>
</table>




```R
run_tests({
    test_that("Tools have been summarised", {
        expect_true(nrow(recommendations) == 16, 
            info = 'Make sure that you are only keeping the top 4 responses for each language used')
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
        current_start_time: 26.572 0.456 7479.019 0.003 0.002
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


## 8. The most recommended language by the language used
<p>Just one thing left. Let's graphically determine which languages are most recommended based on the language that a person uses.</p>


```R
# Creating a faceted bar plot
ggplot(recommendations, aes(x = LanguageRecommendationSelect, y = number_responses)) + geom_bar(stat = "identity") + facet_wrap(~language_preference) +  theme(axis.text.x = element_text(angle = 90, hjust = 1))
```




![png](output_22_1.png)



```R
run_tests({
   test_that("Plot is a bar chart",{
      p <- last_plot()
      q <- p$layers[[1]]
      expect_is(q$geom, "GeomBar")
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
        current_start_time: 27.1 0.46 7479.552 0.003 0.002
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


## 9. The moral of the story
<p>So we've made it to the end. We've found that Python is the most popular language used among Kaggle data scientists, but R users aren't far behind. And while Python users may highly recommend that new learners learn Python, would R users find the following statement <code>TRUE</code> or <code>FALSE</code>? </p>


```R
# Would R users find this statement TRUE or FALSE?
R_is_number_one = TRUE
```


```R
run_tests({
    test_that("The question has been answered", {
        expect_true(R_is_number_one, 
            info = 'Try again! Should R_is_number_one be set to TRUE or FALSE?')
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
        current_start_time: 27.142 0.46 7479.594 0.003 0.002
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

