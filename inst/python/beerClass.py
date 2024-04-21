class Beer:
  def __init__(self, brand = "Feldschlössli", size = 33):
    """Example of a class"""
    self.brand = brand
    self.size = size
    self.remaining = size
    
  def drink(self, sip = 5):
    """Take a sip"""
    if sip > self.remaining:
      print(f"Not enough beer left. Take max {self.remaining} cl of a sip.")
    else:
      self.remaining = self.remaining - sip
      print("Cheers mate!")
      
class Pant:
  def __init__(self, pant = 10):
    """Intended to demonstrate that if return value is a proxy class,
    a corresponding R object is automatically created (instead of a proxy object)
    """
    self.pant = pant
    
  def foo(self):
    print("bar")

