from day04 import Assignments

def test_assignments_init():
  assignments = Assignments('day04-test.csv')
  assert assignments.pairs[0] == [range(2, 5), range(6, 9)]

def test_assignments_has_containment():
  assert Assignments.has_containment(range(4, 9), range(5, 8))
  assert Assignments.has_containment(range(5, 8), range(4, 9))
  assert Assignments.has_containment(range(5, 9), range(4, 9))
  assert not Assignments.has_containment(range(5, 10), range(4, 9))
