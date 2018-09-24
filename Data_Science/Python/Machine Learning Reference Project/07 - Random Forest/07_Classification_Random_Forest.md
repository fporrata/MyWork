
## 07. Classification with Random Forest 


***

We look at an ensemble method, Random Forest.

#### 1. Import libraries and load data #


```python
import pandas as pd
import numpy as np
import matplotlib.pyplot as plt
%matplotlib inline
from matplotlib.colors import ListedColormap
from sklearn import neighbors
from sklearn.ensemble import RandomForestClassifier
import time

df = pd.read_csv('fruit.csv')
fruitnames = {1: 'Orange', 2: 'Pear', 3: 'Apple'}
colors = {1: '#e09028', 2: '#55aa33', 3: '#cc3333'}
fruitlist = ['Orange', 'Pear', 'Apple']

df.sort('fruit_id', inplace=True) # This is important because the factorizer assigns numbers
    # based on the order the first label is encountered, e.g. if the first instance had
    # fruit = 3, the y value would be 0.

```

#### 2. Train a Random Forest Classifier and show a confusion matrix of the test set #


```python
df['is_train'] = np.random.uniform(0, 1, len(df)) <= .75 # randomly assign training and testing set
train, test = df[df['is_train']==True], df[df['is_train']==False]
features = ['color_id', 'elongatedness', 'weight', 'sweetness', 'acidity']
y, _ = pd.factorize(train['fruit_id'])
clf = RandomForestClassifier(n_jobs=2)
clf = clf.fit(train[features], y)
preds = clf.predict(test[features])
test_result = pd.crosstab(np.array([fruitnames[x] for x in test['fruit_id']]), 
                      np.array([fruitnames[x+1] for x in preds]),
                      rownames=['actual'], colnames=['predicted'])
test_result
```




<div style="max-height:1000px;max-width:1500px;overflow:auto;">
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>predicted</th>
      <th>Apple</th>
      <th>Orange</th>
      <th>Pear</th>
    </tr>
    <tr>
      <th>actual</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Apple</th>
      <td> 15</td>
      <td>  0</td>
      <td>  0</td>
    </tr>
    <tr>
      <th>Orange</th>
      <td>  0</td>
      <td> 11</td>
      <td>  0</td>
    </tr>
    <tr>
      <th>Pear</th>
      <td>  1</td>
      <td>  0</td>
      <td> 18</td>
    </tr>
  </tbody>
</table>
</div>



Show feature importances


```python
for i, score in enumerate(list(clf.feature_importances_)):
    print(round(100*score, 1), features[i])
```

    2.2 color_id
    53.1 elongatedness
    7.0 weight
    24.8 sweetness
    12.9 acidity
    

Show confusion matrix of 100 runs of Random Forest Classifier using all features


```python
reps=100
features=['color_id', 'elongatedness', 'weight', 'sweetness', 'acidity']
title_suffix='with all features'

start = time.time()
for i in range(reps):
    df['is_train'] = np.random.uniform(0, 1, len(df)) <= .75 # randomly assign training and testing set
    train, test = df[df['is_train']==True], df[df['is_train']==False]
    y, _ = pd.factorize(train['fruit_id'])
    clf = RandomForestClassifier(n_jobs=2)
    clf = clf.fit(train[features], y)
    preds = clf.predict(test[features])
    test_result = pd.crosstab(np.array([fruitnames[x] for x in test['fruit_id']]), 
                          np.array([fruitnames[x+1] for x in preds]), rownames=['actual'], colnames=['predicted'])
    if i == 0:
        final_result = test_result[:]
    else:
        final_result += test_result
confmatrix = np.array(final_result)
correct = 0
for i in range(confmatrix.shape[0]):
    correct += confmatrix[i,i]
accuracy = correct/confmatrix.sum()
print('{} runs {}\nFeatures: {}\nAccuracy: {}\ntime: {} sec'.format(reps, title_suffix, features, accuracy, int(time.time()-start)))
final_result
```

    100 runs with all features
    Features: ['color_id', 'elongatedness', 'weight', 'sweetness', 'acidity']
    Accuracy: 0.9856951274027715
    time: 23 sec
    




<div style="max-height:1000px;max-width:1500px;overflow:auto;">
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>predicted</th>
      <th>Apple</th>
      <th>Orange</th>
      <th>Pear</th>
    </tr>
    <tr>
      <th>actual</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Apple</th>
      <td> 1184</td>
      <td>   31</td>
      <td>   21</td>
    </tr>
    <tr>
      <th>Orange</th>
      <td>    4</td>
      <td> 1481</td>
      <td>    1</td>
    </tr>
    <tr>
      <th>Pear</th>
      <td>    2</td>
      <td>    5</td>
      <td> 1745</td>
    </tr>
  </tbody>
</table>
</div>



Show confusion matrix of 100 runs of Random Forest Classifier using only two most important features


```python
reps=100
features=['elongatedness','sweetness',]
title_suffix='with only 2 most important features'

import time
start = time.time()
for i in range(reps):
    df['is_train'] = np.random.uniform(0, 1, len(df)) <= .75 # randomly assign training and testing set
    train, test = df[df['is_train']==True], df[df['is_train']==False]
    y, _ = pd.factorize(train['fruit_id'])
    clf = RandomForestClassifier(n_jobs=2)
    clf = clf.fit(train[features], y)
    preds = clf.predict(test[features])
    test_result = pd.crosstab(np.array([fruitnames[x] for x in test['fruit_id']]), 
                          np.array([fruitnames[x+1] for x in preds]), rownames=['actual'], colnames=['predicted'])
    if i == 0:
        final_result = test_result[:]
    else:
        final_result += test_result
confmatrix = np.array(final_result)
correct = 0
for i in range(confmatrix.shape[0]):
    correct += confmatrix[i,i]
accuracy = correct/confmatrix.sum()
print('{} runs {}\nFeatures: {}\nAccuracy: {}\ntime: {} sec'.format(reps, title_suffix, features, accuracy, int(time.time()-start)))
final_result
```

    100 runs with only 2 most important features
    Features: ['elongatedness', 'sweetness']
    Accuracy: 0.9867831541218638
    time: 23 sec
    




<div style="max-height:1000px;max-width:1500px;overflow:auto;">
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>predicted</th>
      <th>Apple</th>
      <th>Orange</th>
      <th>Pear</th>
    </tr>
    <tr>
      <th>actual</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Apple</th>
      <td> 1221</td>
      <td>   18</td>
      <td>   31</td>
    </tr>
    <tr>
      <th>Orange</th>
      <td>    8</td>
      <td> 1481</td>
      <td>    0</td>
    </tr>
    <tr>
      <th>Pear</th>
      <td>    1</td>
      <td>    1</td>
      <td> 1703</td>
    </tr>
  </tbody>
</table>
</div>



Show confusion matrix of 100 runs of Random Forest Classifier using only two least important features


```python
reps=100
features=['color_id','acidity',]
title_suffix='with only 2 least important features'

import time
start = time.time()
for i in range(reps):
    df['is_train'] = np.random.uniform(0, 1, len(df)) <= .75 # randomly assign training and testing set
    train, test = df[df['is_train']==True], df[df['is_train']==False]
    y, _ = pd.factorize(train['fruit_id'])
    clf = RandomForestClassifier(n_jobs=2)
    clf = clf.fit(train[features], y)
    preds = clf.predict(test[features])
    test_result = pd.crosstab(np.array([fruitnames[x] for x in test['fruit_id']]), 
                          np.array([fruitnames[x+1] for x in preds]), rownames=['actual'], colnames=['predicted'])
    if i == 0:
        final_result = test_result[:]
    else:
        final_result += test_result
confmatrix = np.array(final_result)
correct = 0
for i in range(confmatrix.shape[0]):
    correct += confmatrix[i,i]
accuracy = correct/confmatrix.sum()
print('{} runs {}\nFeatures: {}\nAccuracy: {}\ntime: {} sec'.format(reps, title_suffix, features, accuracy, int(time.time()-start)))
final_result
```

    100 runs with only 2 least important features
    Features: ['color_id', 'acidity']
    Accuracy: 0.7456040191824618
    time: 23 sec
    




<div style="max-height:1000px;max-width:1500px;overflow:auto;">
<table border="1" class="dataframe">
  <thead>
    <tr style="text-align: right;">
      <th>predicted</th>
      <th>Apple</th>
      <th>Orange</th>
      <th>Pear</th>
    </tr>
    <tr>
      <th>actual</th>
      <th></th>
      <th></th>
      <th></th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th>Apple</th>
      <td> 647</td>
      <td>  104</td>
      <td>  483</td>
    </tr>
    <tr>
      <th>Orange</th>
      <td>  79</td>
      <td> 1359</td>
      <td>   25</td>
    </tr>
    <tr>
      <th>Pear</th>
      <td> 353</td>
      <td>   70</td>
      <td> 1259</td>
    </tr>
  </tbody>
</table>
</div>


