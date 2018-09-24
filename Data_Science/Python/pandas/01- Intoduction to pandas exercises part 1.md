
```python
import numpy as np
import pandas as pd
```

**Exercise:**

* Create a `Series` from the integers 6, 8, 7, 5
* Create an integer `Series` labeled with letters 'a', 'b', 'c', and 'd' 
  from a `dict`
* Convert the integer `Series` 64-bit floating point values
* Extract only the values from the last `Series` you created


```python
vals = [6, 8, 7, 5]
labels = list('abcd')
```


```python
res = pd.Series([6, 8, 7, 5])
res
```




    0    6
    1    8
    2    7
    3    5
    dtype: int64




```python
res = pd.Series(dict(zip(labels, vals)))
res
```




    a    6
    b    8
    c    7
    d    5
    dtype: int64




```python
res_fp = res.astype(np.float64)
res_fp
```




    a    6.0
    b    8.0
    c    7.0
    d    5.0
    dtype: float64




```python
res_v = res_fp.values
res_v
```




    array([6., 8., 7., 5.])



**Exercise:**

* Select the first element of `s2` using integer indexing.
* Select the first element of the `s2` using label indexing.
* Select all elements greater than 6 in `s2` using boolean indexing.


```python
s2 = pd.Series([6, 8, 7, 5], index=list('abcd'))
s2
```




    a    6
    b    8
    c    7
    d    5
    dtype: int64




```python
# Similar to iloc, in that both provide integer-based lookups. 
# Use iat if you only need to get or set a single value in a DataFrame or Series.
res = s2.iat[0]
res
```




    6




```python
res = s2.iloc[0]
res
```




    6




```python
res = s2.loc['a']
res
```




    6




```python
res = s2[s2 > 6]
res
```




    b    8
    c    7
    dtype: int64



**Exercise**

* Select all non-NaN values in `s3`
* What will the result of adding `s2` and `s3` together be? 
  Figure it out on paper then check in the notebook with `s2 + s3`


```python
s3 = pd.Series([9., 100., np.nan], index=list('ayz'))
```


```python
res = s3[s3.notnull()]
res
```




    a      9.0
    y    100.0
    dtype: float64




```python
s2 + s3
```




    a    15.0
    b     NaN
    c     NaN
    d     NaN
    y     NaN
    z     NaN
    dtype: float64



**Exercise**

* Write a function that compares two `Series` with dtype `float64` for
  approximate equality. Both `Series` must have the same NaN values
  to test equal. Make sure to write a few test cases with NaN values.
* How does your function compare to the builtin `equals` method on
  `Series`?


```python
def all_equal(x, y, tol=1e-8):
    """Compare arguments for approximate equality
    
    Parameters
    ----------
    x : pd.Series[float64]
    y : pd.Series[float64]
    tol : float
        The absolute different between two scalars that will 
        be considered equivalent
    (x-y)>0
    
    
    
    Returns
    -------
    bool
    """
    #convert nan to 0 for easier comparison
    x = x.fillna(0)
    y = y.fillna(0)
    z = abs((x-y)) > 1e-8
    #if there is a True value in z, it means there is a difference between the series so return False.  Use negation (not)
    return not (z == True).any()


s1 = pd.Series([9., 100., np.nan], index=list('abc'))
s2 = pd.Series([9., 100., np.nan], index=list('abc'))
s3 = pd.Series([9., np.nan, np.nan], index=list('abc'))

print("1a) s1 equas s2:", s1.equals(s2))
print("1b  all_equal(s1, s2):", all_equal(s1, s2))
print("2a) s1 equas s3:", s1.equals(s3))
print("2b) all_equal(s1 , s3):", all_equal(s1, s3))


```

    1a) s1 equas s2: True
    1b  all_equal(s1, s2): True
    2a) s1 equas s3: False
    2b) all_equal(s1 , s3): False
    
