from day04 import Assignments

def test_assignments_init():
  assignments = Assignments('day04-test.csv')
  assert assignments.pairs[0] == [range(2, 5), range(6, 9)]

def test_assignments_has_containment():
  assert Assignments.has_containment(range(4, 9), range(5, 8))
  assert Assignments.has_containment(range(5, 8), range(4, 9))
  assert Assignments.has_containment(range(5, 9), range(4, 9))
  assert not Assignments.has_containment(range(5, 10), range(4, 9))

def test_assignments_containment_count():
  assignments = Assignments('day04-test.csv')
  assert assignments.containment_count == 2

def test_assignments_has_overlap():
  assert Assignments.has_overlap(range(4, 9), range(5, 12))
  assert Assignments.has_overlap(range(5, 12), range(4, 9))
  assert Assignments.has_overlap(range(5, 9), range(4, 9))
  assert not Assignments.has_overlap(range(5, 10), range(11, 19))

def test_assignments_overlap_count():
  assignments = Assignments('day04-test.csv')
  assert assignments.overlap_count == 4
