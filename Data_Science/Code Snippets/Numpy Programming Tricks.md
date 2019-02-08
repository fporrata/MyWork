

```python
#1 - #sort descending

import numpy as np
array_1 = np.array([3, 6, -21, -1 ,4])


-np.sort(-array_1)

```




    array([  6,   4,   3,  -1, -21])




```python
#2 - Calculating percent of values in an array.  Very usefult to calculate p values.

array_1 = np.array([1,0,1,3,1,0,1,1,2,1,0,1,2,0,0,0,2,0,2,2,0,1,0,0,0,1,1,1,2,1,0,0,0,0,0,2,0
,0,0,1,2,0,1,2,2,0,0,0,3,0,0,0,2,2,2,1,2,0,2,1,2,2,0,0,0,1,0,0,0,1,1,1,1,0
,0,0,1,2,0,0,2,1,0,1,2,1,2,0,2,1,2,0,0,2,2,0,3,0,0,1,2,0,2,3,2,1,1,3,1,0,1
,0,1,0,1,1,0,0,1,3,2,1,1,0,1,0,1,0,1,0,2,0,3,1,0,0,3,0,1,1,0,1,2,0,0,2,0,3
,0,1,0,0,0,1,1,2,3,1,0,2,1,0,0,1,3,1,2,2,0,1,2,1,1,3,1,2,0,0,1,1,0,0,1,2,0
,1,0,0,1,0,0,0,0,2,1,1,0,0,0,1,1,2,2,1,1,0,3,1,1,0,1,3,1,0,2,2,1,2,2,1,1,0
,0,0,1,0,0,0,0,1,4,1,2,1,1,1,1,1,2,2,2,1,0,1,0,1,1,0,0,0,2,1,1,0,0,0,2,1,1
,2,0,0,1,1,0,0,0,0,1,2,0,2,0,0,1,1,1,1,2,1,3,0,1,0,0,1,1,2,0,0,3,0,4,2,0,1
,2,0,1,1,0,0,3,1,1,2,1,2,1,0,0,2,1,0,2,0,1,2,0,0,1,0,0,4,2,2,0,1,2,0,0,0,2
,1,0,1,1,2,2,3,0,0,2,0,0,2,1,2,0,1,0,3,1,0,2,2,1,1,1,0,1,0,1,0,1,1,0,0,1,0
,1,1,2,0,1,0,0,1,1,0,2,0,3,0,2,2,1,1,1,0,1,1,3,0,2,2,0,0,0,0,2,1,1,1,0,0,4
,1,2,1,3,1,0,0,3,1,2,3,1,2,6,3,3,1,1,2,1,1,0,2,1,1,3,0,1,2,2,1,1,1,0,0,3,1
,0,0,1,0,1,1,1,0,0,0,1,1,1,2,1,2,3,1,1,1,2,1,2,1,1,0,3,2,2,0,1,0,0,0,0,1,1
,1,1,2,0,1,1,0,0,0,3,0,1,1,1,3,3,0,0,2,2,1,1,1,1,1,1,0,0,1,1,2,1,3,2,0,1,0
,2,2,1,1,0,3,1,1,0,1,0,1,1,1,3,0,1,1,2,0,0,2,1,0,0,0,4,0,3,2,1,1,1,0,1,0,0
,0,0,1,0,3,1,0,0,1,0,0,2,0,0,2,0,1,0,1,0,1,0,0,2,0,1,1,2,3,0,3,1,0,1,0,1,2
,0,1,2,0,1,1,1,2,1,3,1,0,0,1,2,0,0,1,1,1,1,1,2,0,2,1,2,2,1,2,2,1,3,1,1,1,1
,1,2,1,0,2,0,0,3,1,1,3,0,1,1,1,3,0,0,2,3,1,1,2,1,1,2,3,0,2,0,2,2,0,1,1,1,2
,0,2,1,0,1,1,1,0,3,0,1,0,0,0,2,2,3,1,3,0,0,0,0,1,1,0,0,2,3,0,2,1,0,2,1,0,1
,0,1,1,0,1,1,0,0,2,1,2,0,1,2,0,1,2,1,0,1,0,0,0,3,0,0,3,2,0,2,3,0,3,0,1,1,1
,1,1,1,4,0,1,1,1,1,0,2,0,1,1,2,0,1,2,1,2,2,2,1,0,0,1,2,0,1,1,0,1,1,1,1,1,0
,1,0,3,3,0,1,2,3,0,0,1,1,3,1,1,1,0,3,2,1,0,1,1,1,0,0,0,2,2,0,2,1,2,2,1,0,0
,0,1,0,0,0,0,2,3,2,2,1,2,2,2,3,1,0,1,3,0,0,2,2,2,0,2,2,1,0,2,1,0,2,1,2,0,1
,0,1,0,0,1,0,1,3,1,2,2,1,0,1,0,0,0,0,2,0,2,0,0,0,1,0,0,1,2,0,0,1,2,2,0,1,1
,1,1,1,1,0,1,3,1,1,2,0,0,3,1,2,0,1,0,1,3,0,1,1,2,2,3,1,1,1,4,2,0,1,1,0,1,0
,2,2,1,2,0,1,0,0,1,0,2,2,1,0,1,1,2,3,0,0,3,1,0,2,1,1,0,2,1,0,1,0,1,2,0,1,0
,3,0,0,0,2,1,0,2,0,0,0,1,2,1,1,1,1,1,1,1,0,2,0,1,1,1,1,1,1,0,1,1,0,1,1,1,0
,1])

#version1
array_sorted = np.sort(array_1)
indx = np.argmax(array_sorted > 2)
p_value = (array_sorted.size - indx)/array_sorted.size
print(p_value)


#version 2
print(np.mean(array_1 > 2))







```

    0.079
    0.079
    


```python
#3 - column-standadization and Co-variance of a data matrix
import numpy as np

#version 1
#column Standarization
array_1 = np.array(([-2.1, -1,  4.3],[3,  1.1,  0.12], [4,  6, 10] ))
array_stacked = np.column_stack(array_1)
mean_cols = [np.mean(array_stacked[i,]) for i in range(0,array_stacked.shape[0])]
std_cols = [np.std(array_stacked[i,]) for i in range(0,array_stacked.shape[0])]

#Column standardize the array
col_standardardize_array = np.array([ (array_1[i,j] -  mean_cols[j])/std_cols[j] for i in range(0,array_1.shape[0]) for j in range(0,array_1.shape[1])])                                                 
X = np.reshape(col_standardardize_array, array_1.shape)
print("Version 1 - writing your own code to column-standardize a matrix")
print(X)
print()

#Calculate the Covariance of the data matrix
print("Version 1 - Calculate the covariance of a data matrix")
print(np.matmul(X.T, X)/X.shape[0])



#Version 2
#using scikit learn to column- standardize the matrix and verify the code
from sklearn.preprocessing import StandardScaler
data = [[-2.1, -1,  4.3],[3,  1.1,  0.12], [4,  6, 10]]
scaler = StandardScaler()
print()
print()
print("Version 2 - use scikit learn to column-standardize a matrix")
scaler.fit(data)
print(scaler.transform(data))










```

    Version 1 - writing your own code to column-standardize a matrix
    [[-1.39759994 -1.03422447 -0.12512225]
     [ 0.51162141 -0.31822291 -1.15738081]
     [ 0.88597853  1.35244738  1.28250306]]
    
    Version 1 - Calculate the covariance of a data matrix
    [[1.         0.82695391 0.23966674]
     [0.82695391 1.         0.74407583]
     [0.23966674 0.74407583 1.        ]]
    
    
    Version 2 - use scikit learn to column-standardize a matrix
    [[-1.39759994 -1.03422447 -0.12512225]
     [ 0.51162141 -0.31822291 -1.15738081]
     [ 0.88597853  1.35244738  1.28250306]]
    
