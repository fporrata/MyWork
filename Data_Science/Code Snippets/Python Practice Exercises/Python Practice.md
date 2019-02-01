
1. Write a function that inputs a number and prints the multiplication table of that number



```python
def multiplicationtable(num, max = 12):
    """Function to display the multiplication table
       INPUT - num = number to find the multiplication table for.
               max = maximum multiplier.  How big will the multiplication table is going to be.  Default to 12
       OUTPUT - multiplication table        
    """
    multtable = [print(str(num) + '*' + str(i) + '=' + str(num * i)) for i in range(1,max+1)]
    #return multtable

multiplicationtable(2)
print()
multiplicationtable(5,13)
```

    2*1=2
    2*2=4
    2*3=6
    2*4=8
    2*5=10
    2*6=12
    2*7=14
    2*8=16
    2*9=18
    2*10=20
    2*11=22
    2*12=24
    
    5*1=5
    5*2=10
    5*3=15
    5*4=20
    5*5=25
    5*6=30
    5*7=35
    5*8=40
    5*9=45
    5*10=50
    5*11=55
    5*12=60
    5*13=65
    

2. Write a program to print twin primes  less than 1000. If two consecutive odd numbers are both prime then they are known as twin primes



```python
def is_prime(x):
    """Function to determine if a number is prime
       INPUT - x = number to check if it is prime
       OUTPUT - True or False       
    """
    for i in range(2, x-1):
        if x % i == 0:
            return False
    return True

#Determine twin primes
for x in  range(3,1001,2):
    if (is_prime(x) and is_prime(x + 2)):
        print(str(x) + ',' + str(x + 2))
```

    3,5
    5,7
    11,13
    17,19
    29,31
    41,43
    59,61
    71,73
    101,103
    107,109
    137,139
    149,151
    179,181
    191,193
    197,199
    227,229
    239,241
    269,271
    281,283
    311,313
    347,349
    419,421
    431,433
    461,463
    521,523
    569,571
    599,601
    617,619
    641,643
    659,661
    809,811
    821,823
    827,829
    857,859
    881,883
    

3. Write a program to find out the prime factors of a number. Example: prime factors of 56 - 2, 2, 2, 7



```python
import math 
  
# Print all prime factors of a number n 
def primeFactors(x): 
    """Function to print all the prime factors of a number
       INPUT - x = number to find the prime factors for
       OUTPUT - prime factors       
    """      
    # Start by dividing by 2 and finding all the 2s 
    while x % 2 == 0: 
        print(2), 
        x = x / 2
          
    
    # skip by 2 because x must be an odd number now 
    #do not loop until the final number.  Loop to the square root + 1
    for i in range(3,int(math.sqrt(x))+1,2): 
          
        # while i divides n , print i ad divide n 
        while x % i== 0: 
            print(i), 
            x = x / i 
              
    # Condition if x is a prime 
    # number greater than 2 
    if x > 2: 
        print(int(x))
        
primeFactors(56)
```

    2
    2
    2
    7
    

4. Write a program to implement these formulae of permutations and combinations. Number of permutations of n objects taken r at a time: p(n, r) = n! / (n-r)!.  Number of combinations of n objects taken r at a time is: c(n, r) = n! / (r!*(n-r)!) = p(n,r) / r!



```python
#Version 1 - Hard Way - Define your own function
def factorial(x):  
    """Function to find the factorial of a number using recursion
       INPUT - x = number to find the prime factors for
       OUTPUT - factorial       
    """  
    if x == 1:  
       return x  
    else:  
       return x*factorial(x-1) 
    
    
def p(n,r):
    """Function to find the number of permutations of n objects taken r at a time
       INPUT - n = objects to find the permutations for defined by r
               r - times to find the permutations of n objects
       OUTPUT - permutations       
    """ 
    return factorial(n)/factorial(n-r)
    
def c(n,r):
    """Function to find the number of combinations of n objects taken r at a time
       INPUT - n = objects to find the combinations for defined by r
               r - times to find the combinations of n objects
       OUTPUT - combinations       
    """ 
    return p(n,r)/factorial(r)
    
print(p(8,2))    
print()
print(c(8,2))
```

    56.0
    
    28.0
    


```python
#Version 2 - Easy Way - Use predefined function
import math

def p(n,r):
    """Function to find the number of permutations of n objects taken r at a time
       INPUT - n = objects to find the permutations for defined by r
               r - times to find the permutations of n objects
       OUTPUT - permutations       
    """ 
    return math.factorial(n)/math.factorial(n-r)
    
def c(n,r):
    """Function to find the number of combinations of n objects taken r at a time
       INPUT - n = objects to find the combinations for defined by r
               r - times to find the combinations of n objects
       OUTPUT - combinations       
    """
    return p(n,r)/math.factorial(r)

print(p(8,2))    
print()
print(c(8,2))
```

    56.0
    
    28.0
    

5. Write a function that converts a decimal number to binary number



```python
#Version 1 - Hard way.  Define your own function
def convertToBinary(n):
    """Function to print binary number for the input decimal
       INPUT - n = decimal number to find the binary conversion
       OUTPUT - binary number       
    """
    if n > 1:
        convertToBinary(n//2)
    print(n % 2,end = '')


# decimal number
dec = 35
convertToBinary(dec)
```

    100011


```python
#Version 2 - Easy way.  Use predefined formatting functions
def convertToBinary(n):
    """Function to print binary number for the input decimal
       INPUT - n = decimal number to find the binary conversion
       OUTPUT - binary number       
    """
    print("{0:b}".format(n))

dec = 35
convertToBinary(dec)
```

    100011
    

6. Write a function cubesum() that accepts an integer and returns the sum of the cubes of individual digits of that number. Use this function to make functions PrintArmstrong() and isArmstrong() to print Armstrong numbers and to find whether is an Armstrong number.



```python
def cubesum(x):
    """Function to calculate the sum of the cubes of individual digits in a number
       INPUT - x = input number
       OUTPUT - sum of the cubes of individual digits in a number      
    """
    result = 0
    #convert number to string and conver to a list
    lst = list(str(x))
    #convert each digit to an int
    lst = [int(i) for i in lst]
    for x in lst: 
         result = result + x**3  
    return result 

def isArmstrong(x):
    """Function to determine if a number is an Armstrong number
       INPUT - x = input number
       OUTPUT - True or False      
    """
    return cubesum(x) == x



#Armstrong Number = The sum of its digits raised to the third power is equal to the number itself.
def PrintArmstrong(lst):
    """Function to print the Armstrong numbers in a range
       INPUT - lst = list that has the range where you want to find the Armstrong numbers
       OUTPUT - list of Armstrong numbers in the range     
    """
    return [x for x in lst if isArmstrong(x)]

lst = range(1,1001)
result = PrintArmstrong(lst)
print(result)


```

    [1, 153, 370, 371, 407]
    

7. Write a function prodDigits() that inputs a number and returns the product of digits of that number.



```python
#Version 1
def prodDigits(x):
    """Function that calculates the product of the digits of a number
       INPUT - x = input number
       OUTPUT - product of the digits of a number    
    """
    result = 1
    #convert number to string and conver to a list
    lst = list(str(x))
    #convert each digit to an int
    lst = [int(i) for i in lst]
    for x in lst: 
         result = result * x  
    return result 
    
print(prodDigits(56))
```

    30
    


```python
#Version 2
import numpy as np
def prodDigits(x):
    """Function that calculates the product of the digits of a number
       INPUT - x = input number
       OUTPUT - product of the digits of a number    
    """
    result = 1
    lst = list(str(x))
    lst = [int(i) for i in lst]
    return np.prod(lst)

print(prodDigits(56))
```

    30
    


```python
#Version 3
import functools
def prodDigits(x):
    """Function that calculates the product of the digits of a number
       INPUT - x = input number
       OUTPUT - product of the digits of a number    
    """
    result = 1
    lst = list(str(x))
    lst = [int(i) for i in lst]
    return functools.reduce((lambda x, y: x * y), lst) 

print(prodDigits(56))

```

    30
    

8. If all digits of a number n are multiplied by each other repeating with the product, the one digit number obtained at last is called the multiplicative digital root of n. The number of times digits need to be multiplied to reach one digit is called the multiplicative persistance of n. <br> Example: 86 -> 48 -> 32 -> 6 (MDR 6, MPersistence 3) <br>              341 -> 12->2           (MDR 2, MPersistence 2) <br> Using the function prodDigits() of previous exercise write functions MDR() and MPersistence() that input a number and return its multiplicative digital root and multiplicative persistence respectively



```python
def MDR(x):
    """Function that calculates the multiplicative digital root of a number
       INPUT - x = input number
       OUTPUT - multiplicative digital root of a number    
    """
    while len(str(x)) > 1:
        x = prodDigits(x)
    return(x)

def MPersistence(x):
    """Function that calculates the multiplicative persistance of a number
       INPUT - x = input number
       OUTPUT - multiplicative persistance of a number    
    """
    loops = 0
    while len(str(x)) > 1:
        loops += 1
        x = prodDigits(x)
    return(loops)

print("MDR(86) = " + str(MDR(86)))
print("MPersistence(86) = " + str(MPersistence(86)))

print()

print("MDR(341) = " + str(MDR(341)))
print("MPersistence(341) = " + str(MPersistence(341)))



```

    MDR(86) = 6
    MPersistence(86) = 3
    
    MDR(341) = 2
    MPersistence(341) = 2
    

9. Write a function sumPdivisors() that finds the sum of proper divisors of a number. Proper divisors of a number are those numbers by which the number is divisible, except the number itself.  For example proper divisors of 36 are 1, 2, 3, 4, 6, 9, 12, 18



```python
import numpy as np
def sumPdivisors(x):
    """Function that calculates the sum of proper divisors of a number
       INPUT - x = input number
       OUTPUT - sum of proper divisors of a number    
    """    
    # the code below is inefficient because it goes all the way to the number
    return np.sum([i for i in range(1,x) if (x % i == 0)])

sumPdivisors(36)
```




    55



10.A number is called perfect if the sum of proper divisors of that number is equal to the number. For example 28 is perfect number, since 1+2+4+7+14=28. Write a program to print all the perfect numbers in a given range



```python
def PerfectNumbers(lst):
    """Function that finds the perfect numbers in a list
       INPUT - lst = list to check for perfect numbers
       OUTPUT - list of perfect numbers    
    """
    return [x for x in lst if x == sumPdivisors(x)]

lst = range(1,1001)

print(PerfectNumbers(lst))
```

    [6, 28, 496]
    

11.Two different numbers are called amicable numbers if the sum of the proper divisors of each is equal to the other number. For example 220 and 284 are amicable numbers.
Sum of proper divisors of 220 = 1+2+4+5+10+11+20+22+44+55+110 = 284 Sum of proper divisors of 284 = 1+2+4+71+142 = 220 Write a function to print pairs of amicable numbers in a range



```python
import numpy as np
#Version 1 - This code is VERY SLOW
lst = range(1,1001)
def AmicableNumber(lst):
    """Function that finds the amicable numbers in a list
       INPUT - lst = list to check for amicable numbers
       OUTPUT - set of amicable numbers    
    """
    result = [sorted([x, y]) for x  in lst for y in lst if (y == sumPdivisors(x) and x == sumPdivisors(y) and x != y) ]
    #remove duplicates.  for example (220, 284) and (284, 220)
    return set(tuple(i) for i in result)
                                           
print(AmicableNumber(lst))
                                           
```

    {(220, 284)}
    


```python
#Version 2 is MUCH MUCH faster. 
def AmicableNumber(lst):
    """Function that finds the amicable numbers in a list
       INPUT - lst = list to check for amicable numbers
       OUTPUT - set of amicable numbers    
    """
    dict_SumPdivisors = {}
    dict_SumPdivisors = {x: sumPdivisors(x) for x in lst }
    #remove entries where value equals to 1 to make search faster
    myDict = {key:val for key, val in dict_SumPdivisors.items() if val != 1}
    #find amicable numbers
    myDict = {key1:val1 for key1, val1 in myDict.items()  for key2, val2 in dict_SumPdivisors.items() if (key1 == val2 and key2 == val1)}
    
    #cleanup of values
    myDict = {key:val for key, val in myDict.items() if key != val}
    lst = myDict.items()
    lst = [sorted(list(i)) for i in lst]
    return set(tuple(i) for i in lst)

print(AmicableNumber(range(1,1001)))
```

    {(220, 284)}
    

12.Write a program which can filter odd numbers in a list by using filter function



```python
lst = [1,2,3,4,5,6,7,8,9,10]

even_list = list(filter(lambda x: x%2==0, lst))
print(even_list)

odd_list = list(filter(lambda x: x%2!=0, lst))
print(odd_list)

```

    [2, 4, 6, 8, 10]
    [1, 3, 5, 7, 9]
    

13.Write a program which can map() to make a list whose elements are cube of elements in a given list



```python
def cube(x):
    """Function that finds the cube of a number
       INPUT - x = input number
       OUTPUT - cube of input x    
    """
    return x**3

lst = list(map(cube, [1,2,3]))
print(lst)
```

    [1, 8, 27]
    

14.Write a program which can map() and filter() to make a list whose elements are cube of even number in a given list 


```python
def cube(x):
    """Function that finds the cube of a number
       INPUT - x = input number
       OUTPUT - cube of input x    
    """
    return x**3

lst = [1,2,3,4,5,6,7,8,9,10]
result = list(map(cube, list(filter(lambda x: x%2==0, lst))))
print(result)
```

    [8, 64, 216, 512, 1000]
    
