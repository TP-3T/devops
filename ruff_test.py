import os, sys;

def BADfunctionName():
     a =  1
     b=2
     c =3;d=4;
     e=5;
     result =a+b+c+d
     print(   "The result is: "+str(result))
     if(result>5):print("Greater than 5")
     else:print('Less or equal to 5')

def unused_function():
    x = 42
    y = x * 2

BADfunctionName()
