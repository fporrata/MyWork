
## 1. Which college majors will pay the bills?

<p>Wondering if that Philosophy major will really help you pay the bills? Think you're set with an Engineering degree? Choosing a college major is a complex decision evaluating personal interest, difficulty, and career prospects. Your first paycheck right out of college might say a lot about your salary potential by mid-career. Whether you're in school or navigating the postgrad world, join me as we explore the short and long term financial implications of this <em>major</em> decision.</p>
<p>In this notebook, we'll be using data collected from a year-long survey of 1.2 million people with only a bachelor's degree by PayScale Inc., made available <a href="http://online.wsj.com/public/resources/documents/info-Degrees_that_Pay_you_Back-sort.html?mod=article_inline">here</a> by the Wall Street Journal for their article <a href="https://www.wsj.com/articles/SB121746658635199271">Ivy League's Big Edge: Starting Pay</a>. After doing some data clean up, we'll compare the recommendations from three different methods for determining the optimal number of clusters, apply a k-means clustering analysis, and visualize the results.</p>
<p>To begin, let's prepare by loading the following packages: <code>tidyverse</code>, <code>dplyr</code>, <code>readr</code>, <code>ggplot2</code>, <code>cluster</code>, and <code>factoextra</code>. We'll then import the data from <code>degrees-that-pay-back.csv</code> (which is stored in a folder called <code>datasets</code>), and take a quick look at what we're working with.</p>


```R
# Load relevant packages
library(tidyr)
library(dplyr)
library(readr)
library(ggplot2)
library(cluster)
library(factoextra)

# Read in the dataset
degrees <- read_csv("datasets/degrees-that-pay-back.csv", col_names=c("College.Major", "Starting.Median.Salary", "Mid.Career.Median.Salary", "Career.Percent.Growth", "Percentile.10", "Percentile.25", "Percentile.75", "Percentile.90"), skip=1)

# Display the first few rows and a summary of the data frame
head(degrees)
summary(degrees)
```

<table>
<thead><tr><th scope=col>College.Major</th><th scope=col>Starting.Median.Salary</th><th scope=col>Mid.Career.Median.Salary</th><th scope=col>Career.Percent.Growth</th><th scope=col>Percentile.10</th><th scope=col>Percentile.25</th><th scope=col>Percentile.75</th><th scope=col>Percentile.90</th></tr></thead>
<tbody>
	<tr><td>Accounting           </td><td>$46,000.00           </td><td>$77,100.00           </td><td>67.6                 </td><td>$42,200.00           </td><td>$56,100.00           </td><td>$108,000.00          </td><td>$152,000.00          </td></tr>
	<tr><td>Aerospace Engineering</td><td>$57,700.00           </td><td>$101,000.00          </td><td>75.0                 </td><td>$64,300.00           </td><td>$82,100.00           </td><td>$127,000.00          </td><td>$161,000.00          </td></tr>
	<tr><td>Agriculture          </td><td>$42,600.00           </td><td>$71,900.00           </td><td>68.8                 </td><td>$36,300.00           </td><td>$52,100.00           </td><td>$96,300.00           </td><td>$150,000.00          </td></tr>
	<tr><td>Anthropology         </td><td>$36,800.00           </td><td>$61,500.00           </td><td>67.1                 </td><td>$33,800.00           </td><td>$45,500.00           </td><td>$89,300.00           </td><td>$138,000.00          </td></tr>
	<tr><td>Architecture         </td><td>$41,600.00           </td><td>$76,800.00           </td><td>84.6                 </td><td>$50,600.00           </td><td>$62,200.00           </td><td>$97,000.00           </td><td>$136,000.00          </td></tr>
	<tr><td>Art History          </td><td>$35,800.00           </td><td>$64,900.00           </td><td>81.3                 </td><td>$28,800.00           </td><td>$42,200.00           </td><td>$87,400.00           </td><td>$125,000.00          </td></tr>
</tbody>
</table>




     College.Major      Starting.Median.Salary Mid.Career.Median.Salary
     Length:50          Length:50              Length:50               
     Class :character   Class :character       Class :character        
     Mode  :character   Mode  :character       Mode  :character        
                                                                       
                                                                       
                                                                       
     Career.Percent.Growth Percentile.10      Percentile.25      Percentile.75     
     Min.   : 23.40        Length:50          Length:50          Length:50         
     1st Qu.: 59.12        Class :character   Class :character   Class :character  
     Median : 67.80        Mode  :character   Mode  :character   Mode  :character  
     Mean   : 69.27                                                                
     3rd Qu.: 82.42                                                                
     Max.   :103.50                                                                
     Percentile.90     
     Length:50         
     Class :character  
     Mode  :character  
                       
## 2. Currency and strings and percents, oh my!
<p>Notice that our salary data is in currency format, which R considers a string. Let's strip those special characters using the <code>gsub</code> function and convert all of our columns <em>except</em> <code>College.Major</code> to numeric. </p>
<p>While we're at it, we can also convert the <code>Career.Percent.Growth</code> column to a decimal value. </p>


```R
# Clean up the data
degrees_clean <- degrees %>% 
    mutate_at(vars(-College.Major), function(x) as.numeric(gsub('[\\$,]',"",x))) %>%
   mutate(Career.Percent.Growth = Career.Percent.Growth/100)
```
## 3. The elbow method
<p>Great! Now that we have a more manageable dataset, let's begin our clustering analysis by determining how many clusters we should be modeling. The best number of clusters for an unlabeled dataset is not always a clear-cut answer, but fortunately there are several techniques to help us optimize. We'll work with three different methods to compare recommendations: </p>
<ul>
<li>Elbow Method</li>
<li>Silhouette Method</li>
<li>Gap Statistic Method</li>
</ul>
<p>First up will be the <strong>Elbow Method</strong>. This method plots the percent variance against the number of clusters. The "elbow" bend of the curve indicates the optimal point at which adding more clusters will no longer explain a significant amount of the variance. To begin, let's select and scale the following features to base our clusters on: <code>Starting.Median.Salary</code>, <code>Mid.Career.Median.Salary</code>, <code>Perc.10</code>, and <code>Perc.90</code>. Then we'll use the fancy <code>fviz_nbclust</code> function from the <em>factoextra</em> library to determine and visualize the optimal number of clusters. </p>


```R
# Select and scale the relevant features and store as k_means_data
k_means_data <- degrees_clean %>%
    select(Starting.Median.Salary, Mid.Career.Median.Salary, Percentile.10,Percentile.90) %>% scale()

# Run the fviz_nbclust function with our selected data and method "wss"
elbow_method <- fviz_nbclust(k_means_data, kmeans, method = "wss")

# View the plot
elbow_method 
```
![png](output_7_1.png)


## 4. The silhouette method
<p>Wow, that <code>fviz_nbclust</code> function was pretty nifty. Instead of needing to "manually" apply the elbow method by running multiple k_means models and plotting the calculated the total within cluster sum of squares for each potential value of k, <code>fviz_nbclust</code> handled all of this for us behind the scenes. Can we use it for the <strong>Silhouette Method</strong> as well? The Silhouette Method will evaluate the quality of clusters by how well each point fits within a cluster, maximizing average "silhouette" width.</p>


```R
# Run the fviz_nbclust function with the method "silhouette" 
silhouette_method <- fviz_nbclust(k_means_data, kmeans, method = "silhouette")

# View the plot
silhouette_method
```
!png](output_10_1.png)



## 5. The gap statistic method
<p>Marvelous! But hmm, it seems that our two methods so far disagree on the optimal number of clusters... Time to pull out the tie breaker.</p>
<p>For our final method, let's see what the <strong>Gap Statistic Method</strong> has to say about this. The Gap Statistic Method will compare the total variation within clusters for different values of <em>k</em> to the null hypothesis, maximizing the "gap." The "null hypothesis" refers to a uniformly distributed <em>simulated reference</em> dataset with no observable clusters, generated by aligning with the principle components of our original dataset. In other words, how much more variance is explained by <em>k</em> clusters in our dataset than in a fake dataset where all majors have equal salary potential? </p>
<p>Fortunately, we have the <code>clusGap</code> function to calculate this behind the scenes and the <code>fviz_gap_stat</code> function to visualize the results.</p>


```R
# Use the clusGap function to apply the Gap Statistic Method
gap_stat <- clusGap(k_means_data, FUN = kmeans, nstart = 25, K.max = 10, B = 50)

# Use the fviz_gap_stat function to vizualize the results
gap_stat_method <- fviz_gap_stat(gap_stat)

# View the plot
gap_stat_method
```

![png](output_13_1.png)

## 6. K-means algorithm
<p>Looks like the Gap Statistic Method agreed with the Elbow Method! According to majority rule, let's use 3 for our optimal number of clusters. With this information, we can now run our k-means algorithm on the selected data. We will then add the resulting cluster information to label our original dataframe.</p>


```R
# Set a random seed
set.seed(111)

# Set k equal to the optimal number of clusters
num_clusters <- 3

# Run the k-means algorithm 
k_means <- kmeans(k_means_data, centers = num_clusters, iter.max = 15, nstart = 25)

# Label the clusters of degrees_clean
degrees_labeled <- degrees_clean %>%
    mutate(clusters = k_means$cluster)
```

## 7. Visualizing the clusters
<p>Now for the pretty part: visualizing our results. First let's take a look at how each cluster compares in Starting vs. Mid Career Median Salaries. What do the clusters say about the relationship between Starting and Mid Career salaries?</p>


```R
# Graph the clusters by Starting and Mid Career Median Salaries
career_growth <- ggplot(degrees_labeled, aes(x = Starting.Median.Salary, y = Mid.Career.Median.Salary, color = factor(clusters))) + geom_point(alpha=4/5,size=7) + xlab("Starting Median Salary") + ylab("Mid Career Median Salary") + ggtitle("Clusters by Starting vs. Mid Career Median Salaries") + scale_x_continuous(labels = scales::dollar) + scale_y_continuous(labels = scales::dollar) + scale_color_manual(name="Clusters",values=c("#EC2C73","#29AEC7", 
                    "#FFDD30"))

# View the plot
career_growth
```
![png](output_19_1.png)

## 8. A deeper dive into the clusters
<p>Unsurprisingly, most of the data points are hovering in the top left corner, with a relatively linear relationship. In other words, the higher your starting salary, the higher your mid career salary. The three clusters provide a level of delineation that intuitively supports this. </p>
<p>How might the clusters reflect potential mid career growth? There are also a couple curious outliers from clusters 1 and 3... perhaps this can be explained by investigating the mid career percentiles further, and exploring which majors fall in each cluster.</p>
<p>Right now, we have a column for each percentile salary value. In order to visualize the clusters and majors by mid career percentiles, we'll need to reshape the <code>degrees_labeled</code> data using tidyr's <code>gather</code> function to make a <code>percentile</code> <em>key</em> column and a <code>salary</code> <em>value</em> column to use for the axes of our following graphs. We'll then be able to examine the contents of each cluster to see what stories they might be telling us about the majors.</p>


```R
# Use the gather function to reshape degrees and 
# use mutate() to reorder the new percentile column
degrees_perc <- degrees_labeled %>%
    select(College.Major, Percentile.10, Percentile.25, Mid.Career.Median.Salary, Percentile.75, Percentile.90, clusters) %>%
 gather(key=percentile, value=salary, -c(College.Major, clusters)) %>%
    mutate(percentile=factor(percentile,levels=c('Percentile.10','Percentile.25',
            'Mid.Career.Median.Salary','Percentile.75','Percentile.90')))  
```

## 9. The liberal arts cluster
<p>Let's graph Cluster 1 and examine the results. These Liberal Arts majors may represent the lowest percentiles with limited growth opportunity, but there is hope for those who make it! Music is our riskiest major with the lowest 10th percentile salary, but Drama wins the highest growth potential in the 90th percentile for this cluster (so don't let go of those Hollywood dreams!). Nursing is the outlier culprit of cluster number 1, with a higher safety net in the lowest percentile to the median. Otherwise, this cluster does represent the majors with limited growth opportunity.</p>
<p>An aside: It's worth noting that most of these majors leading to lower-paying jobs are women-dominated, according to this <a href="https://www.glassdoor.com/research/app/uploads/sites/2/2017/04/FULL-STUDY-PDF-Gender-Pay-Gap2FCollege-Major.pdf">Glassdoor study</a>. According to the research:</p>
<blockquote>
  <p>"The single biggest cause of the gender pay gap is occupation and industry sorting of men and women into jobs that pay differently throughout the economy. In the U.S., occupation and industry sorting explains 54 percent of the overall pay gap—by far the largest factor." </p>
</blockquote>
<p>Does this imply that women are statistically choosing majors with lower pay potential, or do certain jobs pay less because women choose them...?</p>


```R
# Graph the majors of Cluster 1 by percentile
cluster_1 <- degrees_perc %>% filter(clusters == 1) %>% ggplot(aes(x = percentile, y = salary, group = College.Major, color = College.Major)) + geom_point() + geom_line() + ggtitle("Cluster 1: The Liberal Arts") + theme(axis.text.x = element_text(size = 7, angle = 25))

# View the plot
cluster_1
```

![png](output_25_1.png)


## 10. The goldilocks cluster
<p>On to Cluster 2, right in the middle! Accountants are known for having stable job security, but once you're in the big leagues you may be surprised to find that Marketing or Philosophy can ultimately result in higher salaries. The majors of this cluster are fairly middle of the road in our dataset, starting off not too low and not too high in the lowest percentile. However, this cluster also represents the majors with the greatest differential between the lowest and highest percentiles.</p>


```R
# Modify the previous plot to display Cluster 2
cluster_2 <- degrees_perc %>% filter(clusters == 2) %>% ggplot(aes(x = percentile, y = salary, group = College.Major, color = College.Major)) + geom_point() + geom_line() + ggtitle("Cluster 2: The Goldilocks") + theme(axis.text.x = element_text(size = 7, angle = 25))

# View the plot
cluster_2
```

![png](output_28_1.png)

## 11. The over achiever cluster
<p>Finally, let's visualize Cluster 3. If you want financial security, these are the majors to choose from. Besides our one previously observed outlier now identifiable as Physician Assistant lagging in the highest percentiles, these heavy hitters and solid engineers represent the highest growth potential in the 90th percentile, as well as the best security in the 10th percentile rankings. Maybe those Freakonomics guys are on to something...</p>


```R
# Modify the previous plot to display Cluster 3
cluster_3 <- degrees_perc %>% filter(clusters == 3) %>% ggplot(aes(x = percentile, y = salary, group = College.Major, color = College.Major)) + geom_point() + geom_line() + ggtitle("Cluster 3: The Over Achievers") + theme(axis.text.x = element_text(size = 7, angle = 25))

# View the plot
cluster_3
```

![png](output_31_1.png)


## 12. Every major's wonderful
<p>Thus concludes our journey exploring salary projections by college major via a k-means clustering analysis! Dealing with unsupervized data always requires a bit of creativity, such as our usage of three popular methods to determine the optimal number of clusters. We also used visualizations to interpret the patterns revealed by our three clusters and tell a story. </p>
<p>Which two careers tied for the highest career percent growth? While it's tempting to focus on starting career salaries when choosing a major, it's important to also consider the growth potential down the road. Keep in mind that whether a major falls into the Liberal Arts, Goldilocks, or Over Achievers cluster, one's financial destiny will certainly be influenced by numerous other factors including the school attended, location, passion or talent for the subject, and of course the actual career(s) pursued. </p>
<p>A similar analysis to evaluate these factors may be conducted on the additional data provided by the Wall Street Journal article, comparing salary potential by type and region of college attended. But in the meantime, here's some inspiration from <a href="https://xkcd.com/1052/">xkcd</a> for any students out there still struggling to choose a major.</p>


```R
# Sort degrees by Career.Percent.Growth
degrees_labeled %>% arrange(desc(Career.Percent.Growth))

# Identify the two majors tied for highest career growth potential
highest_career_growth <- c('Math','Philosophy')
```


<table>
<thead><tr><th scope=col>College.Major</th><th scope=col>Starting.Median.Salary</th><th scope=col>Mid.Career.Median.Salary</th><th scope=col>Career.Percent.Growth</th><th scope=col>Percentile.10</th><th scope=col>Percentile.25</th><th scope=col>Percentile.75</th><th scope=col>Percentile.90</th><th scope=col>clusters</th></tr></thead>
<tbody>
	<tr><td>Math                                </td><td>45400                               </td><td> 92400                              </td><td>1.035                               </td><td>45200                               </td><td>64200                               </td><td>128000                              </td><td>183000                              </td><td>2                                   </td></tr>
	<tr><td>Philosophy                          </td><td>39900                               </td><td> 81200                              </td><td>1.035                               </td><td>35500                               </td><td>52800                               </td><td>127000                              </td><td>168000                              </td><td>2                                   </td></tr>
	<tr><td>International Relations             </td><td>40900                               </td><td> 80900                              </td><td>0.978                               </td><td>38200                               </td><td>56000                               </td><td>111000                              </td><td>157000                              </td><td>2                                   </td></tr>
	<tr><td>Economics                           </td><td>50100                               </td><td> 98600                              </td><td>0.968                               </td><td>50600                               </td><td>70600                               </td><td>145000                              </td><td>210000                              </td><td>3                                   </td></tr>
	<tr><td>Marketing                           </td><td>40800                               </td><td> 79600                              </td><td>0.951                               </td><td>42100                               </td><td>55600                               </td><td>119000                              </td><td>175000                              </td><td>2                                   </td></tr>
	<tr><td>Physics                             </td><td>50300                               </td><td> 97300                              </td><td>0.934                               </td><td>56000                               </td><td>74200                               </td><td>132000                              </td><td>178000                              </td><td>3                                   </td></tr>
	<tr><td>Political Science                   </td><td>40800                               </td><td> 78200                              </td><td>0.917                               </td><td>41200                               </td><td>55300                               </td><td>114000                              </td><td>168000                              </td><td>2                                   </td></tr>
	<tr><td>Chemistry                           </td><td>42600                               </td><td> 79900                              </td><td>0.876                               </td><td>45300                               </td><td>60700                               </td><td>108000                              </td><td>148000                              </td><td>2                                   </td></tr>
	<tr><td>Journalism                          </td><td>35600                               </td><td> 66700                              </td><td>0.874                               </td><td>38400                               </td><td>48300                               </td><td> 97700                              </td><td>145000                              </td><td>1                                   </td></tr>
	<tr><td>Architecture                        </td><td>41600                               </td><td> 76800                              </td><td>0.846                               </td><td>50600                               </td><td>62200                               </td><td> 97000                              </td><td>136000                              </td><td>2                                   </td></tr>
	<tr><td>Finance                             </td><td>47900                               </td><td> 88300                              </td><td>0.843                               </td><td>47200                               </td><td>62100                               </td><td>128000                              </td><td>195000                              </td><td>2                                   </td></tr>
	<tr><td>Communications                      </td><td>38100                               </td><td> 70000                              </td><td>0.837                               </td><td>37500                               </td><td>49700                               </td><td> 98800                              </td><td>143000                              </td><td>2                                   </td></tr>
	<tr><td>Geology                             </td><td>43500                               </td><td> 79500                              </td><td>0.828                               </td><td>45000                               </td><td>59600                               </td><td>101000                              </td><td>156000                              </td><td>2                                   </td></tr>
	<tr><td>Art History                         </td><td>35800                               </td><td> 64900                              </td><td>0.813                               </td><td>28800                               </td><td>42200                               </td><td> 87400                              </td><td>125000                              </td><td>1                                   </td></tr>
	<tr><td>History                             </td><td>39200                               </td><td> 71000                              </td><td>0.811                               </td><td>37000                               </td><td>49200                               </td><td>103000                              </td><td>149000                              </td><td>2                                   </td></tr>
	<tr><td>Film                                </td><td>37900                               </td><td> 68500                              </td><td>0.807                               </td><td>33900                               </td><td>45500                               </td><td>100000                              </td><td>136000                              </td><td>1                                   </td></tr>
	<tr><td>Aerospace Engineering               </td><td>57700                               </td><td>101000                              </td><td>0.750                               </td><td>64300                               </td><td>82100                               </td><td>127000                              </td><td>161000                              </td><td>3                                   </td></tr>
	<tr><td>Computer Engineering                </td><td>61400                               </td><td>105000                              </td><td>0.710                               </td><td>66100                               </td><td>84100                               </td><td>135000                              </td><td>162000                              </td><td>3                                   </td></tr>
	<tr><td>Computer Science                    </td><td>55900                               </td><td> 95500                              </td><td>0.708                               </td><td>56000                               </td><td>74900                               </td><td>122000                              </td><td>154000                              </td><td>3                                   </td></tr>
	<tr><td>English                             </td><td>38000                               </td><td> 64700                              </td><td>0.703                               </td><td>33400                               </td><td>44800                               </td><td> 93200                              </td><td>133000                              </td><td>1                                   </td></tr>
	<tr><td>Chemical Engineering                </td><td>63200                               </td><td>107000                              </td><td>0.693                               </td><td>71900                               </td><td>87300                               </td><td>143000                              </td><td>194000                              </td><td>3                                   </td></tr>
	<tr><td>Electrical Engineering              </td><td>60900                               </td><td>103000                              </td><td>0.691                               </td><td>69300                               </td><td>83800                               </td><td>130000                              </td><td>168000                              </td><td>3                                   </td></tr>
	<tr><td>Agriculture                         </td><td>42600                               </td><td> 71900                              </td><td>0.688                               </td><td>36300                               </td><td>52100                               </td><td> 96300                              </td><td>150000                              </td><td>2                                   </td></tr>
	<tr><td>Psychology                          </td><td>35900                               </td><td> 60400                              </td><td>0.682                               </td><td>31600                               </td><td>42100                               </td><td> 87500                              </td><td>127000                              </td><td>1                                   </td></tr>
	<tr><td>Civil Engineering                   </td><td>53900                               </td><td> 90500                              </td><td>0.679                               </td><td>63400                               </td><td>75100                               </td><td>115000                              </td><td>148000                              </td><td>3                                   </td></tr>
	<tr><td>Business Management                 </td><td>43000                               </td><td> 72100                              </td><td>0.677                               </td><td>38800                               </td><td>51500                               </td><td>102000                              </td><td>147000                              </td><td>2                                   </td></tr>
	<tr><td>Accounting                          </td><td>46000                               </td><td> 77100                              </td><td>0.676                               </td><td>42200                               </td><td>56100                               </td><td>108000                              </td><td>152000                              </td><td>2                                   </td></tr>
	<tr><td>Graphic Design                      </td><td>35700                               </td><td> 59800                              </td><td>0.675                               </td><td>36000                               </td><td>45500                               </td><td> 80800                              </td><td>112000                              </td><td>1                                   </td></tr>
	<tr><td>Management Information Systems (MIS)</td><td>49200                               </td><td> 82300                              </td><td>0.673                               </td><td>45300                               </td><td>60500                               </td><td>108000                              </td><td>146000                              </td><td>2                                   </td></tr>
	<tr><td>Anthropology                        </td><td>36800                               </td><td> 61500                              </td><td>0.671                               </td><td>33800                               </td><td>45500                               </td><td> 89300                              </td><td>138000                              </td><td>1                                   </td></tr>
	<tr><td>Biology                             </td><td>38800                               </td><td> 64800                              </td><td>0.670                               </td><td>36900                               </td><td>47400                               </td><td> 94500                              </td><td>135000                              </td><td>1                                   </td></tr>
	<tr><td>Construction                        </td><td>53700                               </td><td> 88900                              </td><td>0.655                               </td><td>56300                               </td><td>68100                               </td><td>118000                              </td><td>171000                              </td><td>3                                   </td></tr>
	<tr><td>Industrial Engineering              </td><td>57700                               </td><td> 94700                              </td><td>0.641                               </td><td>57100                               </td><td>72300                               </td><td>132000                              </td><td>173000                              </td><td>3                                   </td></tr>
	<tr><td>Mechanical Engineering              </td><td>57900                               </td><td> 93600                              </td><td>0.617                               </td><td>63700                               </td><td>76200                               </td><td>120000                              </td><td>163000                              </td><td>3                                   </td></tr>
	<tr><td>Criminal Justice                    </td><td>35000                               </td><td> 56300                              </td><td>0.609                               </td><td>32200                               </td><td>41600                               </td><td> 80700                              </td><td>107000                              </td><td>1                                   </td></tr>
	<tr><td>Forestry                            </td><td>39100                               </td><td> 62600                              </td><td>0.601                               </td><td>41000                               </td><td>49300                               </td><td> 78200                              </td><td>111000                              </td><td>1                                   </td></tr>
	<tr><td>Sociology                           </td><td>36500                               </td><td> 58200                              </td><td>0.595                               </td><td>30700                               </td><td>40400                               </td><td> 81200                              </td><td>118000                              </td><td>1                                   </td></tr>
	<tr><td>Geography                           </td><td>41200                               </td><td> 65500                              </td><td>0.590                               </td><td>40000                               </td><td>50000                               </td><td> 90800                              </td><td>132000                              </td><td>1                                   </td></tr>
	<tr><td>Drama                               </td><td>35900                               </td><td> 56900                              </td><td>0.585                               </td><td>36700                               </td><td>41300                               </td><td> 79100                              </td><td>153000                              </td><td>1                                   </td></tr>
	<tr><td>Health Care Administration          </td><td>38800                               </td><td> 60600                              </td><td>0.562                               </td><td>34600                               </td><td>45600                               </td><td> 78800                              </td><td>101000                              </td><td>1                                   </td></tr>
	<tr><td>Spanish                             </td><td>34000                               </td><td> 53100                              </td><td>0.562                               </td><td>31000                               </td><td>40000                               </td><td> 76800                              </td><td> 96400                              </td><td>1                                   </td></tr>
	<tr><td>Music                               </td><td>35900                               </td><td> 55000                              </td><td>0.532                               </td><td>26700                               </td><td>40200                               </td><td> 88000                              </td><td>134000                              </td><td>1                                   </td></tr>
	<tr><td>Religion                            </td><td>34100                               </td><td> 52000                              </td><td>0.525                               </td><td>29700                               </td><td>36500                               </td><td> 70900                              </td><td> 96400                              </td><td>1                                   </td></tr>
	<tr><td>Information Technology (IT)         </td><td>49100                               </td><td> 74800                              </td><td>0.523                               </td><td>44500                               </td><td>56700                               </td><td> 96700                              </td><td>129000                              </td><td>2                                   </td></tr>
	<tr><td><span style=white-space:pre-wrap>Hospitality &amp; Tourism               </span></td><td>37800                                                                           </td><td> 57500                                                                          </td><td>0.521                                                                           </td><td>35500                                                                           </td><td>43600                                                                           </td><td> 81900                                                                          </td><td>124000                                                                          </td><td>1                                                                               </td></tr>
	<tr><td>Education                           </td><td>34900                               </td><td> 52000                              </td><td>0.490                               </td><td>29300                               </td><td>37900                               </td><td> 73400                              </td><td>102000                              </td><td>1                                   </td></tr>
	<tr><td>Interior Design                     </td><td>36100                               </td><td> 53200                              </td><td>0.474                               </td><td>35700                               </td><td>42600                               </td><td> 72500                              </td><td>107000                              </td><td>1                                   </td></tr>
	<tr><td>Nutrition                           </td><td>39900                               </td><td> 55300                              </td><td>0.386                               </td><td>33900                               </td><td>44500                               </td><td> 70500                              </td><td> 99200                              </td><td>1                                   </td></tr>
	<tr><td>Nursing                             </td><td>54200                               </td><td> 67000                              </td><td>0.236                               </td><td>47600                               </td><td>56400                               </td><td> 80900                              </td><td> 98300                              </td><td>1                                   </td></tr>
	<tr><td>Physician Assistant                 </td><td>74300                               </td><td> 91700                              </td><td>0.234                               </td><td>66400                               </td><td>75200                               </td><td>108000                              </td><td>124000                              </td><td>3                                   </td></tr>
</tbody>
</table>

