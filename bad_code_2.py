import math

def BADfunc(x,y):return x +  y +1 

def anotherFunc():
  a =  1
  b =2
  c=3
  result = a+b+c 
  print( "The Result is:",result )

def unused_function( ):
    foo = 42
    bar = "hello"

def VeryLongFunctionNameThatShouldProbablyBeShorterJustToAnnoyLinters(   ):
    x=1
    if x==1:print('x is one')    
    else:
            print(  "x is not one" )

class badClass(  ):
 def __init__(self):
      self.VALUE=123

 def badMethod( self ) :
        print("value:", self.VALUE )

if __name__=="__main__":
    BADfunc(1,2)
    anotherFunc( )
    VeryLongFunctionNameThatShouldProbablyBeShorterJustToAnnoyLinters(  )
    bc=badClass();bc.badMethod()
