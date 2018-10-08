
Write a function moving_window_average(x, n_neighbors) that takes a list x and the number of neighbors n_neighbors on either side of a given member of the list to consider. <br><br>
For each value in x, moving_window_average(x, n_neighbors) computes the average of that value's neighbors, where neighbors includes the value itself. <br><br>
moving_window_average should return a list of averaged values that is the same length as the original list. <br><br>
If there are not enough neighbors (for cases near the edge), substitute the original value as many times as there are missing neighbors. <br><br>
Use your function to find the moving window sum of x=[0,10,5,3,1,5] and n_neighbors=1


```python
import random

random.seed(1)

def moving_window_average(x, n_neighbors=1):
    n = len(x)
    width = n_neighbors*2 + 1
    x = [x[0]]*n_neighbors + x + [x[-1]]*n_neighbors
    print("Expanded list to calculate average: ", x)

    l = []
    # To complete the function,
    # return a list of the mean of values from i to i+width for all values i from 0 to n-1.
    for i in range(n):
        l.append((x[i] + x[i+1] + x[i+2])/width)
    return l

x=[0,10,5,3,1,5]   

print("Averages List:", moving_window_average(x, 1)  )
```

    Expanded list to calculate average:  [0, 0, 10, 5, 3, 1, 5, 5]
    Averages List: [3.3333333333333335, 5.0, 6.0, 3.0, 3.0, 3.6666666666666665]
    
