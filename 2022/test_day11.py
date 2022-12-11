from day11 import Troupe, Monkey

def test_monkey_get_bored():
  assert Monkey.bored_with(601) == 200
  assert Monkey.bored_with(602) == 201
