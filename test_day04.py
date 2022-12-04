from day04 import Assignments

def test_assignments_init():
  assignments = Assignments('day04-test.csv')
  assert assignments.pairs[0] == [range(2, 5), range(6, 9)]
