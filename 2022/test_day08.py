from day08  import Trees

def test_trees_init():
  trees = Trees('day08-test.txt')
  assert trees.data.count('\n') == 5
  assert len(trees.grid) == len(trees.grid[0]) == 5

def test_higher_on_a_sight_line():
  trees = Trees('day08-test.txt')
  assert trees._higher_on_a_sight_line(1, 1)
  assert not trees._higher_on_a_sight_line(2, 2)
  assert not trees._higher_on_a_sight_line(3, 3)

def test_visible_tree_count():
  trees = Trees('day08-test.txt')
  assert trees.visible_tree_count == 21

def test_viewing_distances():
  trees = Trees('day08-test.txt')
  assert trees.viewing_distances(1, 2) == [1, 1, 2, 2]
  assert trees.viewing_distances(3, 2) == [2, 2, 2, 1]

def test_viewing_distances():
  trees = Trees('day08-test.txt')
  assert trees.scenic_score(1, 2) == 4
  assert trees.scenic_score(3, 2) == 8

def test_max_scenic_score():
  trees = Trees('day08-test.txt')
  assert trees.max_scenic_score == 8
