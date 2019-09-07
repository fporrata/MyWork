import pandas as pd
from sklearn.linear_model import ElasticNet, Lasso, LinearRegression, Ridge
import matplotlib.pyplot as plt
 
data = pd.read_csv('AAPL.csv')  # load data set
data = data[['Date','Close']]
X = data.index.values.reshape(-1, 1)  # values converts it into a numpy array
Y = data.iloc[:, 1].values.reshape(-1, 1)  # -1 means that calculate the dimension of rows, but have 1 column

fig=plt.figure(figsize=(4,1))

#Linear Regression
linear_regressor = LinearRegression()  # create object for the class
linear_regressor.fit(X, Y)  # perform linear regression
Y_pred = linear_regressor.predict(X)  # make predictions
f1 = plt.figure(1)
plt.scatter(X, Y)
plt.plot(X, Y_pred, color='red')
plt.suptitle("Apple Share from 1/1/2019 until 9/6/2019")
plt.title("Linear Regression")
plt.xlabel("Days from 1/1/2019")
plt.ylabel("Price")



#Lasso Regression
linear_regressor = Lasso()  # create object for the class
linear_regressor.fit(X, Y)  # perform linear regression
Y_pred = linear_regressor.predict(X)  # make predictions
f2 = plt.figure(2)
plt.scatter(X, Y)
plt.plot(X, Y_pred, color='green')
plt.suptitle("Apple Share from 1/1/2019 until 9/6/2019")
plt.title("Lasso Regression")
plt.xlabel("Days from 1/1/2019")
plt.ylabel("Price")



#Ridge Regression
linear_regressor = Ridge()  # create object for the class
linear_regressor.fit(X, Y)  # perform linear regression
Y_pred = linear_regressor.predict(X)  # make predictions
f3 = plt.figure(3)
plt.scatter(X, Y)
plt.plot(X, Y_pred, color='black')
plt.suptitle("Apple Share from 1/1/2019 until 9/6/2019")
plt.title("Ridge Regression")
plt.xlabel("Days from 1/1/2019")
plt.ylabel("Price")




#ElasticNet Regression
linear_regressor = ElasticNet()  # create object for the class
linear_regressor.fit(X, Y)  # perform linear regression
Y_pred = linear_regressor.predict(X)  # make predictions
f4 = plt.figure(4)
plt.scatter(X, Y)
plt.plot(X, Y_pred, color='yellow')
plt.suptitle("Apple Share from 1/1/2019 until 9/6/2019")
plt.title("ElasticNet Regression")
plt.xlabel("Days from 1/1/2019")
plt.ylabel("Price")

plt.show()