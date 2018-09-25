
(c) 2016 Enplus Advisors, Inc.


```python
import numpy as np
import pandas as pd
```


```python
_df = {
    'ticker': ['AAPL', 'AAPL', 'MSFT', 'IBM', 'YHOO'],
    'date': ['2015-12-30', '2015-12-31', '2015-12-30', '2015-12-30', '2015-12-30'],
    'open': [426.23, 427.81, 42.3, 101.65, 35.53]
}
df = pd.DataFrame(_df)
```

**Exercise:**

* Select the `open` column as a `Series` using attribute lookup
* Select the `open` column as a `Series` using `dict`-style lookup
* Select the `date` column as a `DataFrame`


```python
type(df.open)
```




    pandas.core.series.Series




```python
print(df['open'])
type(df['open'])
```

    0    426.23
    1    427.81
    2     42.30
    3    101.65
    4     35.53
    Name: open, dtype: float64
    




    pandas.core.series.Series




```python
print(df[['date']])
type(df[['date']])
```

             date
    0  2015-12-30
    1  2015-12-31
    2  2015-12-30
    3  2015-12-30
    4  2015-12-30
    




    pandas.core.frame.DataFrame



**Exercise:**

* Select all rows with the `AAPL` ticker and the `date` and `open`
  tickers.
* Assign to the variable `df1` a new `DataFrame` with `ticker` as
  the index.
* Assign to the variable `df2` a new `DataFrame` with `date` as
  the index. Create this `DataFrame` from `df1` with a single
  statement.
* Sort `df2` by the index values.


```python
#solution 1
print(df.loc[df.ticker == 'AAPL', ['date', 'open']])

#solution 2
print(df[['date', 'open']].loc[df['ticker'] == 'AAPL'])
```

             date    open
    0  2015-12-30  426.23
    1  2015-12-31  427.81
             date    open
    0  2015-12-30  426.23
    1  2015-12-31  427.81
    


```python
df1 = df.set_index('ticker')
df1
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
      <th>date</th>
      <th>open</th>
    </tr>
    <tr>
      <th>ticker</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>AAPL</th>
      <td>2015-12-30</td>
      <td>426.23</td>
    </tr>
    <tr>
      <th>AAPL</th>
      <td>2015-12-31</td>
      <td>427.81</td>
    </tr>
    <tr>
      <th>MSFT</th>
      <td>2015-12-30</td>
      <td>42.30</td>
    </tr>
    <tr>
      <th>IBM</th>
      <td>2015-12-30</td>
      <td>101.65</td>
    </tr>
    <tr>
      <th>YHOO</th>
      <td>2015-12-30</td>
      <td>35.53</td>
    </tr>
  </tbody>
</table>
</div>




```python
df2 = df1.reset_index().set_index('date')
df2
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
      <th>ticker</th>
      <th>open</th>
    </tr>
    <tr>
      <th>date</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2015-12-30</th>
      <td>AAPL</td>
      <td>426.23</td>
    </tr>
    <tr>
      <th>2015-12-31</th>
      <td>AAPL</td>
      <td>427.81</td>
    </tr>
    <tr>
      <th>2015-12-30</th>
      <td>MSFT</td>
      <td>42.30</td>
    </tr>
    <tr>
      <th>2015-12-30</th>
      <td>IBM</td>
      <td>101.65</td>
    </tr>
    <tr>
      <th>2015-12-30</th>
      <td>YHOO</td>
      <td>35.53</td>
    </tr>
  </tbody>
</table>
</div>




```python
df2.sort_index()
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
      <th>ticker</th>
      <th>open</th>
    </tr>
    <tr>
      <th>date</th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>2015-12-30</th>
      <td>AAPL</td>
      <td>426.23</td>
    </tr>
    <tr>
      <th>2015-12-30</th>
      <td>MSFT</td>
      <td>42.30</td>
    </tr>
    <tr>
      <th>2015-12-30</th>
      <td>IBM</td>
      <td>101.65</td>
    </tr>
    <tr>
      <th>2015-12-30</th>
      <td>YHOO</td>
      <td>35.53</td>
    </tr>
    <tr>
      <th>2015-12-31</th>
      <td>AAPL</td>
      <td>427.81</td>
    </tr>
  </tbody>
</table>
</div>



**Exercise:**

* Create a copy of `df` called `df3`. Add a new column of `NaNs` 
  to `df3` called `close`. Assign `close` the same value as `open`
  for all `open` values greater than 100.
* Sort `df3` by its `close` values.


```python
df3 = df.copy()
df3["close"] = np.nan

#solution 1
#df3["close"] = df3["open"].loc[df3["open"] > 100]
#solution2
df3.close = df3.open[df3.open > 100]

df3.sort_values(by = 'close')



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
      <th>ticker</th>
      <th>date</th>
      <th>open</th>
      <th>close</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>3</th>
      <td>IBM</td>
      <td>2015-12-30</td>
      <td>101.65</td>
      <td>101.65</td>
    </tr>
    <tr>
      <th>0</th>
      <td>AAPL</td>
      <td>2015-12-30</td>
      <td>426.23</td>
      <td>426.23</td>
    </tr>
    <tr>
      <th>1</th>
      <td>AAPL</td>
      <td>2015-12-31</td>
      <td>427.81</td>
      <td>427.81</td>
    </tr>
    <tr>
      <th>2</th>
      <td>MSFT</td>
      <td>2015-12-30</td>
      <td>42.30</td>
      <td>NaN</td>
    </tr>
    <tr>
      <th>4</th>
      <td>YHOO</td>
      <td>2015-12-30</td>
      <td>35.53</td>
      <td>NaN</td>
    </tr>
  </tbody>
</table>
</div>


