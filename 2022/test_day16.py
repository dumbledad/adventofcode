from day16 import Cave

filename = 'inputs/2022/day16-test.txt'

def test_init():
  cave = Cave(filename)
  assert cave.data
  assert cave.valves[0].name == 'AA'
  assert cave.valves[1].flow == 13
  assert cave.valves[2].to_names == ['DD', 'BB']

def test_do():
  cave = Cave(filename)
  assert cave.do() == 1_651
