
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
    return [sum(x[i:(i+width)]) / width for i in range(n)]

x=[0,10,5,3,1,5]   

print("Averages List:", moving_window_average(x, 1)  )
```

    Expanded list to calculate average:  [0, 0, 10, 5, 3, 1, 5, 5]
    Averages List: [3.3333333333333335, 5.0, 6.0, 3.0, 3.0, 3.6666666666666665]
    

Compute and store R=1000 random values from 0-1 as x.<br><br>

Store x as well as each of these averages as consecutive lists in a list called Y


```python
R=1000

def moving_window_average_no_print(x, n_neighbors=1):
    n = len(x)
    width = n_neighbors*2 + 1
    x = [x[0]]*n_neighbors + x + [x[-1]]*n_neighbors
    #print("Expanded list to calculate average: ", x)
    return [sum(x[i:(i+width)]) / width for i in range(n)]





x = [random.random() for i in range(R)]
Y = [x] + [moving_window_average_no_print(x, i) for i in range(1, 10)]
```

 For each list in Y, calculate and store the range (the maximum minus the minimum) in a new list ranges.


```python
ranges = []
for i in Y:
    ranges.append(max(i) - min(i))

print(ranges)
```

    [0.9981662758264479, 0.8705443729244259, 0.5223266237546554, 0.37309044553903964, 0.2901814576414753, 0.2374211926157525, 0.2008948552902521, 0.17410887458488516, 0.1536254775748987, 0.13745437467227778]
    

The range decreases, because the average smooths a larger number of neighbors. Because the numbers in the original list are just random, we expect the average of many of them to be roughly 1/2, and more averaging means more smoothness in this value.
