
# Study:

1. Download Haberman Cancer Survival dataset from Kaggle. You may have to create a Kaggle account to donwload data. (https://www.kaggle.com/gilsousa/habermans-survival-data-set)
2. Perform a similar alanlaysis as above on this dataset with the following sections:
* High level statistics of the dataset: number of points, numer of   features, number of classes, data-points per class.
* Explain our objective. 
* Perform Univaraite analysis(PDF, CDF, Boxplot, Voilin plots) to understand which features are useful towards classification.
* Perform Bi-variate analysis (scatter plots, pair-plots) to see if combinations of features are useful in classfication.
* Write your observations in english as crisply and unambigously as possible. Always quantify your results.

# Domain description

The dataset contains cases from a study that was conducted between 1958 and 1970 at the University of Chicago's Billings Hospital on the survival of patients who had undergone surgery for breast cancer.
<br/>
https://archive.ics.uci.edu/ml/datasets/Haberman's+Survival
<br/>    
Data Set Characteristics: Multivariate<br/>
Number of Instances: 306<br/>
Area: Life<br/>
Attribute Characteristics: Integer<br/>
Number of Attributes: 3<br/>
Date Donated: 1999-03-04<br/>
Associated Tasks: Classification<br/>
Missing Values? No<br/>

** Attribute Information: **<br/>
1. Age of patient at time of operation (numerical) <br/>
2. Patient's year of operation (year - 1900, numerical) <br/>
3. Number of positive axillary nodes detected (numerical) <br/>
4. Survival status (class attribute) <br/>
-- 1 = the patient survived 5 years or longer <br/>
-- 2 = the patient died within 5 year<br/>

# Objective of EDA
Understand the data to help determine if a patient will survive after 5 years after undergoing surgery for breast cancer.

# Some hypothesis:
1. Is age a factor in determining the survival of the patient after 5 years?  Do younger patients tend to survive more than older patients?
2. Do the survival rate increase by year.  Could there be better treatments later that increase survival rate.  We only have the year to determine this so this would be a speculation.
3. Do the number of nodes determine the survival rate?


```python
#View raw file before using pandas to check for row columns, skipping lines, etc.
linenum = 1
with open("haberman.csv") as f:
    for _ in range(10):
        print(linenum, ' ',  f.readline())
        linenum += 1
```

#### Observation about raw file
1. The file contains a header row.
2. No skipping lines.
3. All values are numeric.
4. Features are age, year and nodes
5. Target is status


```python
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
%matplotlib inline
import numpy as np
import warnings
warnings.filterwarnings('ignore')
print ('Seaborn version: ',sns.__version__)
'''downlaod haberman.csv from Kaggle link'''
#Load haberman.csv into a pandas dataFrame.
haberman = pd.read_csv("haberman.csv")

```

    Seaborn version:  0.9.0
    


```python
# (Q) how many data-points and features?
print (haberman.shape)
```

    (306, 4)
    


```python
#(Q) What are the column names in our dataset?
print (haberman.columns)
```

    Index(['age', 'year', 'nodes', 'status'], dtype='object')
    


```python
#dtypes
haberman.dtypes

```




    age       int64
    year      int64
    nodes     int64
    status    int64
    dtype: object




```python
haberman.hist()
plt.show()
```


![png](output_9_0.png)



```python
#Check for missing values
haberman.isnull().sum()
```




    age       0
    year      0
    nodes     0
    status    0
    dtype: int64




```python
haberman['nodes'].value_counts()
```




    0     136
    1      41
    2      20
    3      20
    4      13
    6       7
    7       7
    8       7
    5       6
    9       6
    13      5
    14      4
    11      4
    10      3
    15      3
    19      3
    22      3
    23      3
    12      2
    20      2
    46      1
    16      1
    17      1
    18      1
    21      1
    24      1
    25      1
    28      1
    30      1
    35      1
    52      1
    Name: nodes, dtype: int64




```python
haberman['year'].value_counts()
```




    58    36
    64    31
    63    30
    66    28
    65    28
    60    28
    59    27
    61    26
    67    25
    62    23
    68    13
    69    11
    Name: year, dtype: int64




```python
haberman['age'].value_counts()
```




    52    14
    54    13
    50    12
    47    11
    53    11
    43    11
    57    11
    55    10
    65    10
    49    10
    38    10
    41    10
    61     9
    45     9
    42     9
    63     8
    59     8
    62     7
    44     7
    58     7
    56     7
    46     7
    70     7
    34     7
    48     7
    37     6
    67     6
    60     6
    51     6
    39     6
    66     5
    64     5
    72     4
    69     4
    40     3
    30     3
    68     2
    73     2
    74     2
    36     2
    35     2
    33     2
    31     2
    78     1
    71     1
    75     1
    76     1
    77     1
    83     1
    Name: age, dtype: int64



#### Observation  <br/>
1. The dataset has 3 features and 1 classification target (Status) and 306 records.
2. There are no missing values.
3. age seems to follow a normal distribution.  <br/>
4. nodes distribution is skewed right.  There are a lot of observations with a small number of nodes (<=4 nodes, 75.16%) and very few with a large number of nodes.  
5. Year seems to follow a uniform distribution.  Only the years 68 and 69 has much less observations than other years
6. Patient's age range between 30-83 years and had undergone breast cancer surgery between the years 1958-1969.


# Describe method,  Median, Percentile, Quantile, IQR, MAD


```python
haberman.describe()
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>age</th>
      <th>year</th>
      <th>nodes</th>
      <th>status</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>count</th>
      <td>306.000000</td>
      <td>306.000000</td>
      <td>306.000000</td>
      <td>306.000000</td>
    </tr>
    <tr>
      <th>mean</th>
      <td>52.457516</td>
      <td>62.852941</td>
      <td>4.026144</td>
      <td>1.264706</td>
    </tr>
    <tr>
      <th>std</th>
      <td>10.803452</td>
      <td>3.249405</td>
      <td>7.189654</td>
      <td>0.441899</td>
    </tr>
    <tr>
      <th>min</th>
      <td>30.000000</td>
      <td>58.000000</td>
      <td>0.000000</td>
      <td>1.000000</td>
    </tr>
    <tr>
      <th>25%</th>
      <td>44.000000</td>
      <td>60.000000</td>
      <td>0.000000</td>
      <td>1.000000</td>
    </tr>
    <tr>
      <th>50%</th>
      <td>52.000000</td>
      <td>63.000000</td>
      <td>1.000000</td>
      <td>1.000000</td>
    </tr>
    <tr>
      <th>75%</th>
      <td>60.750000</td>
      <td>65.750000</td>
      <td>4.000000</td>
      <td>2.000000</td>
    </tr>
    <tr>
      <th>max</th>
      <td>83.000000</td>
      <td>69.000000</td>
      <td>52.000000</td>
      <td>2.000000</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Median, Quantiles, Percentiles, IQR.
print("\nMedians:")
print("age" , " ",  str(np.median(haberman["age"])))
print("nodes" , " " , str(np.median(haberman["nodes"])))


print("\nQuantiles:")
print("age" , " ",  str(np.percentile(haberman["age"],np.arange(0, 100, 25))))
print("nodes" , " " , str(np.percentile(haberman["nodes"],np.arange(0, 100, 25))))

print("\n90th Percentiles:")
print("age" , " ",  str(np.percentile(haberman["age"],90)))
print("nodes" , " " , str(np.percentile(haberman["nodes"],90)))


from statsmodels import robust
print ("\nMedian Absolute Deviation")
print("age" , " ",  str(robust.mad(haberman["age"])))
print("nodes" , " " , str(robust.mad(haberman["nodes"])))


```

    
    Medians:
    age   52.0
    nodes   1.0
    
    Quantiles:
    age   [30.   44.   52.   60.75]
    nodes   [0. 0. 1. 4.]
    
    90th Percentiles:
    age   67.0
    nodes   13.0
    
    Median Absolute Deviation
    age   11.860817748044816
    nodes   1.482602218505602
    


```python
#(Q) How many data points for each class are present? 
haberman["status"].value_counts()

```




    1    225
    2     81
    Name: status, dtype: int64



#### Observations: 
1. The dataset has 225 records labeled as 1 (the patient survived 5 years or longer) and 81 records labeled as 2 (the patient died within 5 year)
2. This is an imbalanced dataset with almost a 3:1 ratio of patients who survived against patient who died.
3. About 25% of people have no axilary nodes detected.
4. Mean and median ages are close at about 52
5. Median node was 1
6. 90th percentile for age is 67, so there were very few people in the study older than 67
7. 90th percentile for nodes is 13, so there were very few people that showed more than 13 nodes.
 

# Multi variate Analysis:


```python
# pairwise scatter plot: Pair-Plot
plt.close();
sns.set_style("whitegrid");
sns.pairplot(haberman, hue="status", size=3);
plt.show()
# NOTE: the diagnol elements are PDFs for each feature. PDFs are expalined below.
```


![png](output_21_0.png)


#### Observation 
1. Data is overlapping.  No concrete observations can be made from these plots.  Need more detail and will display them separately

# Correlation


```python
correlations = haberman.corr()
correlations
```




<div>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>age</th>
      <th>year</th>
      <th>nodes</th>
      <th>status</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>age</th>
      <td>1.000000</td>
      <td>0.089529</td>
      <td>-0.063176</td>
      <td>0.067950</td>
    </tr>
    <tr>
      <th>year</th>
      <td>0.089529</td>
      <td>1.000000</td>
      <td>-0.003764</td>
      <td>-0.004768</td>
    </tr>
    <tr>
      <th>nodes</th>
      <td>-0.063176</td>
      <td>-0.003764</td>
      <td>1.000000</td>
      <td>0.286768</td>
    </tr>
    <tr>
      <th>status</th>
      <td>0.067950</td>
      <td>-0.004768</td>
      <td>0.286768</td>
      <td>1.000000</td>
    </tr>
  </tbody>
</table>
</div>




```python

mask = np.zeros_like(correlations, dtype=np.bool)
mask[np.triu_indices_from(mask)] = True
# Make the figsize 9 x 8
plt.figure(figsize=(14, 10))
# Plot heatmap of annotated correlations
sns.heatmap(correlations , annot = True,   mask = mask, cbar = False)
plt.show()
```


![png](output_25_0.png)


#### Observation 
1. All correlations are very weak.  There is a small correlation between status and nodes of 0.286768.

# Bi Variate Analysis


```python
plt.figure(figsize=(20, 20))
sns.catplot(x="age", hue="status", kind="count",
            palette="pastel", edgecolor=".6", height=9,
            data=haberman, legend = False);
plt.title("Status Counts by Age")
plt.legend(title='Status', loc='upper right',labels=['Survived', 'Died'])
plt.show() 
```


    <Figure size 1440x1440 with 0 Axes>



![png](output_28_1.png)


#### Observation 
1. Survival rate of women below 41 years of age is high.  There were few deaths recorded for this group.
2. From 41 to 70 the incidence of death is higher with some ages not showing deaths at all such as 58 and 68.
3. 53 has the highest death count
4. Patients older than 77 did not survive in this study


```python
plt.figure(figsize=(20, 20))
sns.catplot(x="nodes", hue="status", kind="count",
            palette="pastel", edgecolor=".6", height=9,
            data=haberman, legend = False);
plt.title("Status Counts by nodes")
plt.legend(title='Status', loc='upper right',labels=['Survived', 'Died'])
plt.show()

```


    <Figure size 1440x1440 with 0 Axes>



![png](output_30_1.png)


#### Observation 
1. Most of the patients did not have any nodes. (44%)
2. Survival rate was high for patients with 4 or less nodes


```python
plt.figure(figsize=(20, 20))
sns.catplot(x="year", hue="status", kind="count",
            palette="pastel", edgecolor=".6", height=9,
            data=haberman, legend = False);
plt.title("Status Counts by year")
plt.legend(title='Status', loc='upper right',labels=['Survived', 'Died'])
plt.show()
```


    <Figure size 1440x1440 with 0 Axes>



![png](output_32_1.png)


#### Observation 
1. For the years 58 to 61 we see a downward trend of deaths for somewhat similar count of people getting the surgery.
2. From year 62 to 65 there was an upward trend with 65 been the worst year.
3. Year 66 and 67 show a lower trend with good survival rate.


```python
#Nodes by age
sns.catplot("nodes", col="age", col_wrap=2, data=haberman, kind="count", height=7, aspect=.8, sharex=False)
plt.show()
```


![png](output_34_0.png)


** Observation **
1.  There is no clear pattern of number of nodes by age

# Histogram, PDF, CDF


```python
sns.FacetGrid(haberman, hue="status", size=5) \
   .map(sns.distplot, "age") ;
 
plt.title("PDF - Status by age")
plt.legend(title='Status', loc='upper right',labels=['Survived', 'Died'])
plt.show();

```


![png](output_37_0.png)


#### Observations: 
1. The data is overlapping not much information can be extracted from this plot.
2. Patients with age less than 40 yrs. has higher chance to survive and patient with age more than 78 yrs are most likely to died within 5 yrs. of surgery


```python
sns.FacetGrid(haberman, hue="status", size=5) \
   .map(sns.distplot, "year") ;
plt.title("PDF - Status by year")
plt.legend(title='Status', loc='upper right',labels=['Survived', 'Died'])
plt.show();
```


![png](output_39_0.png)


#### Observations: 
1. Data is overlapping so no concrete conclusion can be obtained on the Year of operation. 
2. Patients who had undergone surgery between the year 1960 - 1963 had higher probability of survival.
3. Around year 1965 there was a higher probability of dying.


```python
sns.FacetGrid(haberman, hue="status", size=5) \
   .map(sns.distplot, "nodes") ;
plt.title("PDF - Status by nodes")
plt.legend(title='Status', loc='upper right',labels=['Survived', 'Died'])
plt.show();
```


![png](output_41_0.png)


#### Observations:
1. Around 90% of the patient has axil nodes between 0 to 13.
2. Patient with 0-4 axil node had higher chances of survival.
3. Data is overlapping so it is difficult to determine a cutoff value for survival.


```python
Survived= haberman.loc[haberman["status"]== 1]
Died = haberman.loc[haberman["status"]==2]


plt.figure(figsize=(20,10))
i=1
for column in (list(haberman.columns)[:-1]):
#survived
    plt.subplot(1,3,i)
    Counts , bin_edges = np.histogram(Survived[column],bins=20,density=True)
    pdf=Counts/sum(Counts)
    print('Survived', '-', column)
    print(pdf)
    print(bin_edges)
    print()
    cdf = np.cumsum(Counts)
    plt.plot(bin_edges[1:],cdf,label="CDF - Survived",color="blue")
    plt.plot(bin_edges[1:],pdf,label="PDF - Survived",color="black")

#Death
    Counts , bin_edges = np.histogram(Died[column],bins=20,density=True)
    pdf=Counts/sum(Counts)
    print('Died', '-', column)
    print(pdf)
    print(bin_edges);
    print()
    cdf = np.cumsum(Counts)
    plt.plot(bin_edges[1:],cdf,label="CDF - Died",color="red")
    plt.plot(bin_edges[1:],pdf,label="PDF - Died",color="orange")
    plt.xlabel(column)
    plt.grid()
    plt.legend()
    i+=1
plt.show()
```

    Survived - age
    [0.02222222 0.03111111 0.04444444 0.06222222 0.04444444 0.08
     0.04       0.05333333 0.09777778 0.06666667 0.07555556 0.08888889
     0.04888889 0.04444444 0.08       0.03111111 0.02222222 0.04
     0.01333333 0.01333333]
    [30.   32.35 34.7  37.05 39.4  41.75 44.1  46.45 48.8  51.15 53.5  55.85
     58.2  60.55 62.9  65.25 67.6  69.95 72.3  74.65 77.  ]
    
    Died - age
    [0.02469136 0.01234568 0.04938272 0.07407407 0.12345679 0.07407407
     0.07407407 0.12345679 0.09876543 0.03703704 0.03703704 0.08641975
     0.04938272 0.04938272 0.03703704 0.01234568 0.01234568 0.01234568
     0.         0.01234568]
    [34.   36.45 38.9  41.35 43.8  46.25 48.7  51.15 53.6  56.05 58.5  60.95
     63.4  65.85 68.3  70.75 73.2  75.65 78.1  80.55 83.  ]
    
    Survived - year
    [0.10666667 0.08       0.         0.10666667 0.         0.10222222
     0.         0.07111111 0.         0.09777778 0.10222222 0.
     0.06666667 0.         0.09777778 0.         0.09333333 0.
     0.04444444 0.03111111]
    [58.   58.55 59.1  59.65 60.2  60.75 61.3  61.85 62.4  62.95 63.5  64.05
     64.6  65.15 65.7  66.25 66.8  67.35 67.9  68.45 69.  ]
    
    Died - year
    [0.14814815 0.11111111 0.         0.04938272 0.         0.03703704
     0.         0.08641975 0.         0.09876543 0.09876543 0.
     0.16049383 0.         0.07407407 0.         0.04938272 0.
     0.03703704 0.04938272]
    [58.   58.55 59.1  59.65 60.2  60.75 61.3  61.85 62.4  62.95 63.5  64.05
     64.6  65.15 65.7  66.25 66.8  67.35 67.9  68.45 69.  ]
    
    Survived - nodes
    [0.73333333 0.10222222 0.02666667 0.05333333 0.01333333 0.00888889
     0.02222222 0.00444444 0.00888889 0.00888889 0.00444444 0.
     0.00444444 0.00444444 0.         0.         0.         0.
     0.         0.00444444]
    [ 0.   2.3  4.6  6.9  9.2 11.5 13.8 16.1 18.4 20.7 23.  25.3 27.6 29.9
     32.2 34.5 36.8 39.1 41.4 43.7 46. ]
    
    Died - nodes
    [0.39506173 0.17283951 0.0617284  0.08641975 0.04938272 0.08641975
     0.01234568 0.03703704 0.0617284  0.01234568 0.         0.
     0.         0.01234568 0.         0.         0.         0.
     0.         0.01234568]
    [ 0.   2.6  5.2  7.8 10.4 13.  15.6 18.2 20.8 23.4 26.  28.6 31.2 33.8
     36.4 39.  41.6 44.2 46.8 49.4 52. ]
    
    


![png](output_43_1.png)


#### Observations: 
1. Operations done between 1961 to 1965 had a higher rate of survival.
2. Operations done between 1965 to 1967 had a lower rate of survival
3. Younger patients (age < 34) survived the operation and pataient (age >= 77) died.
4. About 85% of the patients who survived had less than 5 axillary nodes
5. About 62% of the patients who died had 5 or less axillary nodes


```python
#NOTE: IN the plot below, a technique call inter-quartile range is used in plotting the whiskers. 
#Whiskers in the plot below donot correposnd to the min and max values.

sns.boxplot(x='status',y='age', data=haberman)
plt.show()
```


![png](output_45_0.png)



```python
sns.boxplot(x='status',y='year', data=haberman)
plt.show()
```


![png](output_46_0.png)



```python
sns.boxplot(x='status',y='nodes', data=haberman)
plt.show()
```


![png](output_47_0.png)



```python
# A violin plot combines the benefits of the previous two plots 
#and simplifies them

# Denser regions of the data are fatter, and sparser ones thinner 
#in a violin plot

sns.violinplot(x="status", y="age", data=haberman, size=8)
plt.show()
```


![png](output_48_0.png)



```python
sns.violinplot(x="status", y="year", data=haberman, size=8)
plt.show()
```


![png](output_49_0.png)



```python
sns.violinplot(x="status", y="nodes", data=haberman, size=8)
plt.show()
```


![png](output_50_0.png)



```python
#2D Density plot, contors-plot
sns.jointplot(x="status", y="age", data=haberman, kind="kde");
plt.show();

```


![png](output_51_0.png)



```python
#2D Density plot, contors-plot
sns.jointplot(x="status", y="nodes", data=haberman, kind="kde");
plt.show();

```


![png](output_52_0.png)



```python
#2D Density plot, contors-plot
sns.jointplot(x="status", y="year", data=haberman, kind="kde");
plt.show();

```


![png](output_53_0.png)


#### Observations: 
1. No major conclusion can be determined from these plots (boxplot, violin and kde) as the data for survived and died are  overlapping.


# Final Observations: 
1. Patients 41 years or less have a high probability of survival.
2. Patients 77 years or older did not survive.
3. Patients having  4 or less auxillary nodes have slightly high rate of survival.
4. There are no clear cutoff criteria in which we can based "if - else" decisions.

Note: We are making observations with an imbalanced dataset
