Q1:

Linear Regression Equation

class =
     -0.1084 * CRIM +
      0.0458 * ZN +
      2.7187 * CHAS=1 +
    -17.376  * NOX +
      3.8016 * RM +
     -1.4927 * DIS +
      0.2996 * RAD +
     -0.0118 * TAX +
     -0.9465 * PTRATIO +
      0.0093 * B +
     -0.5226 * LSTAT +
     36.3411

, where class variable is MEDV

Root mean squared error = 4.6797

Explanation:
The equation has 12 terms with 11 features and y-intercept (constant). For unit increase in per capita crime, MEDV gets reduced by a factor of 0.1084, for every proportion of residential land zoned for lots the price increases by a factor of 0.0458, if property is surrounded by Charles river its price would increase by 2.7187 times, for every unit increase in nitric oxides concentration the price reduces by a factor of 17.376 and so on. Therefore we can see that the features which are positive and have potential of increasing prices are actually having positive coefficient and the ones which may be harmful for a property's price are having negative coefficient and causing reduction in price.

WHY these 11 features are selected:
To fit a linear regression model those features are selected which have a high correlation with our target variable MEDV. It can be high positive correlation coefficient value or a high negative correlation coefficient value. Correlation coefficient ranges from -1 to 1. If the value is close to 1, it means that there is a strong positive correlation between the two variables. When it is close to -1, the variables have a strong negative correlation.
Out of 13 features we leave out INDUS and AGE features because they have correlation coeff of nearly 0 wrt MEDV and hence would give us very less information on the prediction for MEDV.


________________________________________________________________________________________________________________________________

Q2:

Lowest RMSE: 2.5097
Learning rate = 0.22
Momentum = 0.16


I tried following combinations:

Learning rate,Momentum,RMSE
0.3,0.3,2.9406
0.3,0.2,2.9317
0.3,0.1,2.7177
0.2,0.3,2.6275
0.2,0.2,2.6048
0.2,0.1,2.5856
0.1,0.3,2.704 
0.1,0.2,2.5966
0.1,0.1,2.7066
0.29,0.2,2.7267
0.25,0.2,2.5928
0.22,0.2,2.5136
0.20,0.2,2.6048
0.22,0.19,2.5121
0.22,0.18,2.5109
0.22,0.17,2.5099
0.22,0.16,2.5097 ****
0.22,0.15,2.5105
0.22,0.14,2.5126




(I went upto two decimal places after following this post https://piazza.com/class/k53tdrrr6sp62z?cid=1054)
________________________________________________________________________________________________________________________________

Q3:

Linear Regression Equation

class = 
    -0.825 * sex=I + 0.058 * sex=M - 0.458 * length + 11.075 * diameter + 10.762 * height + 8.975 * whole_weight - 19.787 * shucked_weight - 10.582 * viscera_weight + 8.742 * shell_weight + 3.895
, where class variable is num_rings


________________________________________________________________________________________________________________________________

Q5:

The data gets split into 6 clusters with each cluster having following number of data points:

Cluster Model

Cluster 0: 1388 items
Cluster 1: 499 items
Cluster 2: 448 items
Cluster 3: 22 items
Cluster 4: 172 items
Cluster 5: 1648 items
Total number of items: 4177



________________________________________________________________________________________________________________________________


Q6:

Linear Regression Equation

num_rings = - 11.933 * length + 25.766 * diameter + 20.358 * height + 2.836

where num_rings is the class/label variable
________________________________________________________________________________________________________________________________





