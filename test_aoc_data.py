from aoc_data import AOCData

def test_aocdata_init():
  day1 = AOCData('day01-test.csv')
  assert int(day1.data.max()) == 10_000
  assert day1.data.count()[0] == 10
