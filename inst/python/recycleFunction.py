from beerClass import Beer, Pant

def recycle(beer):
  """Recycle your beer can and collect the pant!"""
  if beer.remaining != 0:
    print(f"There is still {beer.remaining} cl of beer left... Drink it first!")
    return None
  else:
    print("Thanks for recycling. Here is your pant!")
    return Pant(10)

