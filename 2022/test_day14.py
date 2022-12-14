from day14 import Cave

filename = 'inputs/2022/day14-test.txt'

def test_cave_init():
  cave = Cave(filename)
  assert cave.data