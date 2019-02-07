
**Consider the following Python dictionary data and Python list labels:**

data = {'birds': ['Cranes', 'Cranes', 'plovers', 'spoonbills', 'spoonbills', 'Cranes', 'plovers', 'Cranes', 'spoonbills', 'spoonbills'],
        'age': [3.5, 4, 1.5, np.nan, 6, 3, 5.5, np.nan, 8, 4],
        'visits': [2, 4, 3, 4, 3, 4, 2, 2, 3, 2],
        'priority': ['yes', 'yes', 'no', 'yes', 'no', 'no', 'no', 'yes', 'no', 'no']}

labels = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j']


**1. Create a DataFrame birds from this dictionary data which has the index labels.**

NOTE: Will create a dfOriginal Dataframe because there might be more than one version of an answer and I can copy the original dataframe to different versions


```python
import pandas as pd
import numpy as np

data = {'birds': ['Cranes', 'Cranes', 'plovers', 'spoonbills', 'spoonbills', 'Cranes', 'plovers', 'Cranes', 'spoonbills', 'spoonbills'], 'age': [3.5, 4, 1.5, np.nan, 6, 3, 5.5, np.nan, 8, 4], 'visits': [2, 4, 3, 4, 3, 4, 2, 2, 3, 2], 'priority': ['yes', 'yes', 'no', 'yes', 'no', 'no', 'no', 'yes', 'no', 'no']}
labels = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j']
dfOriginal = pd.DataFrame(data, index = labels)



```


```python
birds = dfOriginal
print(birds)
```

            birds  age  visits priority
    a      Cranes  3.5       2      yes
    b      Cranes  4.0       4      yes
    c     plovers  1.5       3       no
    d  spoonbills  NaN       4      yes
    e  spoonbills  6.0       3       no
    f      Cranes  3.0       4       no
    g     plovers  5.5       2       no
    h      Cranes  NaN       2      yes
    i  spoonbills  8.0       3       no
    j  spoonbills  4.0       2       no
    

**2. Display a summary of the basic information about birds DataFrame and its data.**


```python
#info() gives the information about the Dataframe
birds.info()
```

    <class 'pandas.core.frame.DataFrame'>
    Index: 10 entries, a to j
    Data columns (total 4 columns):
    birds       10 non-null object
    age         8 non-null float64
    visits      10 non-null int64
    priority    10 non-null object
    dtypes: float64(1), int64(1), object(2)
    memory usage: 400.0+ bytes
    

Observations: <br>1) There are 10 entries <br> 2) Columns birds and priority are strings <br> 3) Column age is a floating number and is missing 2 values <br> 4) Column visits is an integer <br> 5) The index goes from the value a to j

**3. Print the first 2 rows of the birds dataframe **


```python
birds.head(2)
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>age</th>
      <th>visits</th>
      <th>priority</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>a</th>
      <td>Cranes</td>
      <td>3.5</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>b</th>
      <td>Cranes</td>
      <td>4.0</td>
      <td>4</td>
      <td>yes</td>
    </tr>
  </tbody>
</table>
</div>



**4. Print all the rows with only 'birds' and 'age' columns from the dataframe**


```python
birds[['birds', 'age']]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>age</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>a</th>
      <td>Cranes</td>
      <td>3.5</td>
    </tr>
    <tr>
      <th>b</th>
      <td>Cranes</td>
      <td>4.0</td>
    </tr>
    <tr>
      <th>c</th>
      <td>plovers</td>
      <td>1.5</td>
    </tr>
    <tr>
      <th>d</th>
      <td>spoonbills</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>e</th>
      <td>spoonbills</td>
      <td>6.0</td>
    </tr>
    <tr>
      <th>f</th>
      <td>Cranes</td>
      <td>3.0</td>
    </tr>
    <tr>
      <th>g</th>
      <td>plovers</td>
      <td>5.5</td>
    </tr>
    <tr>
      <th>h</th>
      <td>Cranes</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>i</th>
      <td>spoonbills</td>
      <td>8.0</td>
    </tr>
    <tr>
      <th>j</th>
      <td>spoonbills</td>
      <td>4.0</td>
    </tr>
  </tbody>
</table>
</div>



**5. select [2, 3, 7] rows and in columns ['birds', 'age', 'visits']**


```python
birds[['birds', 'age', 'visits']].iloc[[2, 3, 7]]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>age</th>
      <th>visits</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>c</th>
      <td>plovers</td>
      <td>1.5</td>
      <td>3</td>
    </tr>
    <tr>
      <th>d</th>
      <td>spoonbills</td>
      <td>NaN</td>
      <td>4</td>
    </tr>
    <tr>
      <th>h</th>
      <td>Cranes</td>
      <td>NaN</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>



**6. select the rows where the number of visits is less than 4**


```python
birds[birds.visits < 4]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>age</th>
      <th>visits</th>
      <th>priority</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>a</th>
      <td>Cranes</td>
      <td>3.5</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>c</th>
      <td>plovers</td>
      <td>1.5</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>e</th>
      <td>spoonbills</td>
      <td>6.0</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>g</th>
      <td>plovers</td>
      <td>5.5</td>
      <td>2</td>
      <td>no</td>
    </tr>
    <tr>
      <th>h</th>
      <td>Cranes</td>
      <td>NaN</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>i</th>
      <td>spoonbills</td>
      <td>8.0</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>j</th>
      <td>spoonbills</td>
      <td>4.0</td>
      <td>2</td>
      <td>no</td>
    </tr>
  </tbody>
</table>
</div>



**7. select the rows with columns ['birds', 'visits'] where the age is missing i.e NaN**


```python
birds [['birds', 'visits']][birds.age.isnull()]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>visits</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>d</th>
      <td>spoonbills</td>
      <td>4</td>
    </tr>
    <tr>
      <th>h</th>
      <td>Cranes</td>
      <td>2</td>
    </tr>
  </tbody>
</table>
</div>



**8. Select the rows where the birds is a Cranes and the age is less than 4**


```python
birds[(birds.birds == 'Cranes') & (birds.age < 4)]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>age</th>
      <th>visits</th>
      <th>priority</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>a</th>
      <td>Cranes</td>
      <td>3.5</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>f</th>
      <td>Cranes</td>
      <td>3.0</td>
      <td>4</td>
      <td>no</td>
    </tr>
  </tbody>
</table>
</div>



**9. Select the rows the age is between 2 and 4(inclusive)**


```python
birds[(birds.age > 2) & (birds.age <= 4)]
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>age</th>
      <th>visits</th>
      <th>priority</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>a</th>
      <td>Cranes</td>
      <td>3.5</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>b</th>
      <td>Cranes</td>
      <td>4.0</td>
      <td>4</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>f</th>
      <td>Cranes</td>
      <td>3.0</td>
      <td>4</td>
      <td>no</td>
    </tr>
    <tr>
      <th>j</th>
      <td>spoonbills</td>
      <td>4.0</td>
      <td>2</td>
      <td>no</td>
    </tr>
  </tbody>
</table>
</div>



**10. Find the total number of visits of the bird Cranes**


```python
birds[(birds.birds == 'Cranes')]['visits'].sum()
```




    12



**11. Calculate the mean age for each different birds in dataframe.**


```python
birds.groupby('birds')['age'].mean()
```




    birds
    Cranes        3.5
    plovers       3.5
    spoonbills    6.0
    Name: age, dtype: float64



**12. Append a new row 'k' to dataframe with your choice of values for each column. Then delete that row to return the original DataFrame.**


```python
rowdata = {'birds': ['Cardinal'], 'age': [4], 'visits': [2], 'priority': ['yes']}
df = pd.DataFrame(rowdata, index = ['k'])

birds = birds.append(df)
birds
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>age</th>
      <th>visits</th>
      <th>priority</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>a</th>
      <td>Cranes</td>
      <td>3.5</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>b</th>
      <td>Cranes</td>
      <td>4.0</td>
      <td>4</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>c</th>
      <td>plovers</td>
      <td>1.5</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>d</th>
      <td>spoonbills</td>
      <td>NaN</td>
      <td>4</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>e</th>
      <td>spoonbills</td>
      <td>6.0</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>f</th>
      <td>Cranes</td>
      <td>3.0</td>
      <td>4</td>
      <td>no</td>
    </tr>
    <tr>
      <th>g</th>
      <td>plovers</td>
      <td>5.5</td>
      <td>2</td>
      <td>no</td>
    </tr>
    <tr>
      <th>h</th>
      <td>Cranes</td>
      <td>NaN</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>i</th>
      <td>spoonbills</td>
      <td>8.0</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>j</th>
      <td>spoonbills</td>
      <td>4.0</td>
      <td>2</td>
      <td>no</td>
    </tr>
    <tr>
      <th>k</th>
      <td>Cardinal</td>
      <td>4.0</td>
      <td>2</td>
      <td>yes</td>
    </tr>
  </tbody>
</table>
</div>




```python
#version 1
birds = birds.drop(['k'])
birds
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>age</th>
      <th>visits</th>
      <th>priority</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>a</th>
      <td>Cranes</td>
      <td>3.5</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>b</th>
      <td>Cranes</td>
      <td>4.0</td>
      <td>4</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>c</th>
      <td>plovers</td>
      <td>1.5</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>d</th>
      <td>spoonbills</td>
      <td>NaN</td>
      <td>4</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>e</th>
      <td>spoonbills</td>
      <td>6.0</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>f</th>
      <td>Cranes</td>
      <td>3.0</td>
      <td>4</td>
      <td>no</td>
    </tr>
    <tr>
      <th>g</th>
      <td>plovers</td>
      <td>5.5</td>
      <td>2</td>
      <td>no</td>
    </tr>
    <tr>
      <th>h</th>
      <td>Cranes</td>
      <td>NaN</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>i</th>
      <td>spoonbills</td>
      <td>8.0</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>j</th>
      <td>spoonbills</td>
      <td>4.0</td>
      <td>2</td>
      <td>no</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Version 2
#birds = birds[birds.index != 'k']
#birds
```

**13. Find the number of each type of birds in dataframe (Counts)**


```python
birds['birds'].value_counts()
```




    Cranes        4
    spoonbills    4
    plovers       2
    Name: birds, dtype: int64



**14. Sort dataframe (birds) first by the values in the 'age' in decending order, then by the value in the 'visits' column in ascending order.**


```python
birds.sort_values(['age', 'visits'], ascending=[False, True])
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>age</th>
      <th>visits</th>
      <th>priority</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>i</th>
      <td>spoonbills</td>
      <td>8.0</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>e</th>
      <td>spoonbills</td>
      <td>6.0</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>g</th>
      <td>plovers</td>
      <td>5.5</td>
      <td>2</td>
      <td>no</td>
    </tr>
    <tr>
      <th>j</th>
      <td>spoonbills</td>
      <td>4.0</td>
      <td>2</td>
      <td>no</td>
    </tr>
    <tr>
      <th>b</th>
      <td>Cranes</td>
      <td>4.0</td>
      <td>4</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>a</th>
      <td>Cranes</td>
      <td>3.5</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>f</th>
      <td>Cranes</td>
      <td>3.0</td>
      <td>4</td>
      <td>no</td>
    </tr>
    <tr>
      <th>c</th>
      <td>plovers</td>
      <td>1.5</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>h</th>
      <td>Cranes</td>
      <td>NaN</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>d</th>
      <td>spoonbills</td>
      <td>NaN</td>
      <td>4</td>
      <td>yes</td>
    </tr>
  </tbody>
</table>
</div>



**15. Replace the priority column values with'yes' should be 1 and 'no' should be 0**


```python
birds['priority'] = birds['priority'].map({'yes': 1, 'no': 0})
birds
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>age</th>
      <th>visits</th>
      <th>priority</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>a</th>
      <td>Cranes</td>
      <td>3.5</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <th>b</th>
      <td>Cranes</td>
      <td>4.0</td>
      <td>4</td>
      <td>1</td>
    </tr>
    <tr>
      <th>c</th>
      <td>plovers</td>
      <td>1.5</td>
      <td>3</td>
      <td>0</td>
    </tr>
    <tr>
      <th>d</th>
      <td>spoonbills</td>
      <td>NaN</td>
      <td>4</td>
      <td>1</td>
    </tr>
    <tr>
      <th>e</th>
      <td>spoonbills</td>
      <td>6.0</td>
      <td>3</td>
      <td>0</td>
    </tr>
    <tr>
      <th>f</th>
      <td>Cranes</td>
      <td>3.0</td>
      <td>4</td>
      <td>0</td>
    </tr>
    <tr>
      <th>g</th>
      <td>plovers</td>
      <td>5.5</td>
      <td>2</td>
      <td>0</td>
    </tr>
    <tr>
      <th>h</th>
      <td>Cranes</td>
      <td>NaN</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <th>i</th>
      <td>spoonbills</td>
      <td>8.0</td>
      <td>3</td>
      <td>0</td>
    </tr>
    <tr>
      <th>j</th>
      <td>spoonbills</td>
      <td>4.0</td>
      <td>2</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>



**16. In the 'birds' column, change the 'Cranes' entries to 'trumpeters'.**


```python
#Version 1 gives a warning
birds['birds'].loc[birds['birds'] == 'Cranes'] = 'trumpeters'
birds

```

    F:\anaconda3\lib\site-packages\pandas\core\indexing.py:189: SettingWithCopyWarning: 
    A value is trying to be set on a copy of a slice from a DataFrame
    
    See the caveats in the documentation: http://pandas.pydata.org/pandas-docs/stable/indexing.html#indexing-view-versus-copy
      self._setitem_with_indexer(indexer, value)
    




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>age</th>
      <th>visits</th>
      <th>priority</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>a</th>
      <td>trumpeters</td>
      <td>3.5</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <th>b</th>
      <td>trumpeters</td>
      <td>4.0</td>
      <td>4</td>
      <td>1</td>
    </tr>
    <tr>
      <th>c</th>
      <td>plovers</td>
      <td>1.5</td>
      <td>3</td>
      <td>0</td>
    </tr>
    <tr>
      <th>d</th>
      <td>spoonbills</td>
      <td>NaN</td>
      <td>4</td>
      <td>1</td>
    </tr>
    <tr>
      <th>e</th>
      <td>spoonbills</td>
      <td>6.0</td>
      <td>3</td>
      <td>0</td>
    </tr>
    <tr>
      <th>f</th>
      <td>trumpeters</td>
      <td>3.0</td>
      <td>4</td>
      <td>0</td>
    </tr>
    <tr>
      <th>g</th>
      <td>plovers</td>
      <td>5.5</td>
      <td>2</td>
      <td>0</td>
    </tr>
    <tr>
      <th>h</th>
      <td>trumpeters</td>
      <td>NaN</td>
      <td>2</td>
      <td>1</td>
    </tr>
    <tr>
      <th>i</th>
      <td>spoonbills</td>
      <td>8.0</td>
      <td>3</td>
      <td>0</td>
    </tr>
    <tr>
      <th>j</th>
      <td>spoonbills</td>
      <td>4.0</td>
      <td>2</td>
      <td>0</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Version 2
birds2 = dfOriginal
birds2['birds'] = np.where((birds2.birds=='Cranes'), 'trumpeters',birds2['birds'])
birds2

```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>age</th>
      <th>visits</th>
      <th>priority</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>a</th>
      <td>trumpeters</td>
      <td>3.5</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>b</th>
      <td>trumpeters</td>
      <td>4.0</td>
      <td>4</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>c</th>
      <td>plovers</td>
      <td>1.5</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>d</th>
      <td>spoonbills</td>
      <td>NaN</td>
      <td>4</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>e</th>
      <td>spoonbills</td>
      <td>6.0</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>f</th>
      <td>trumpeters</td>
      <td>3.0</td>
      <td>4</td>
      <td>no</td>
    </tr>
    <tr>
      <th>g</th>
      <td>plovers</td>
      <td>5.5</td>
      <td>2</td>
      <td>no</td>
    </tr>
    <tr>
      <th>h</th>
      <td>trumpeters</td>
      <td>NaN</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>i</th>
      <td>spoonbills</td>
      <td>8.0</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>j</th>
      <td>spoonbills</td>
      <td>4.0</td>
      <td>2</td>
      <td>no</td>
    </tr>
  </tbody>
</table>
</div>




```python
#Version 3
birds3 = dfOriginal
birds3.loc[birds3['birds'] == 'Cranes','birds'] = 'trumpeters'
birds3
```




<div>
<style scoped>
    .dataframe tbody tr th:only-of-type {
        vertical-align: middle;
    }

    .dataframe tbody tr th {
        vertical-align: top;
    }

    .dataframe thead th {
        text-align: right;
    }
</style>
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th></th>
      <th>birds</th>
      <th>age</th>
      <th>visits</th>
      <th>priority</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>a</th>
      <td>trumpeters</td>
      <td>3.5</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>b</th>
      <td>trumpeters</td>
      <td>4.0</td>
      <td>4</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>c</th>
      <td>plovers</td>
      <td>1.5</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>d</th>
      <td>spoonbills</td>
      <td>NaN</td>
      <td>4</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>e</th>
      <td>spoonbills</td>
      <td>6.0</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>f</th>
      <td>trumpeters</td>
      <td>3.0</td>
      <td>4</td>
      <td>no</td>
    </tr>
    <tr>
      <th>g</th>
      <td>plovers</td>
      <td>5.5</td>
      <td>2</td>
      <td>no</td>
    </tr>
    <tr>
      <th>h</th>
      <td>trumpeters</td>
      <td>NaN</td>
      <td>2</td>
      <td>yes</td>
    </tr>
    <tr>
      <th>i</th>
      <td>spoonbills</td>
      <td>8.0</td>
      <td>3</td>
      <td>no</td>
    </tr>
    <tr>
      <th>j</th>
      <td>spoonbills</td>
      <td>4.0</td>
      <td>2</td>
      <td>no</td>
    </tr>
  </tbody>
</table>
</div>


