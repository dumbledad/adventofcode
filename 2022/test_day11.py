from day11 import Troupe, Monkey

def test_monkey_get_bored():
  assert Monkey.bored_with(601) == 200
  assert Monkey.bored_with(602) == 201

def test_troupe_init():
  troupe = Troupe('inputs/2022/day11-test.txt')
  assert troupe.data
  assert len(troupe.monkeys) == 4