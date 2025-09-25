import math, random

class myClass():
 def __init__(self,value):
  self.value=value

 def square( self ):
  return self.value*self.value

 def randomStuff( self ):
    for i in range(0,10): print( random.randint( 1 ,100 ) )

def main( ):
   obj = myClass( 5 )
   print("Square is: "+str(obj.square()))
   obj.randomStuff( )
   unused_var = 12345
   if unused_var = 1: print("hello");

main( )
