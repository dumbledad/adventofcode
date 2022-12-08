from day08  import Trees

def test_trees_init():
  trees = Trees('day08-test.txt')
  assert trees.data.count('\n') == 5
  assert len(trees.grid) == len(trees.grid[0]) == 5

def test_trees_higher_than_a_neighbour():
  trees = Trees('day08-test.txt')
  assert trees._higher_than_a_neighbour(1, 1)
  assert not trees._higher_than_a_neighbour(2, 2)

def test_higher_on_a_sight_line():
  trees = Trees('day08-test.txt')
  assert trees._higher_on_a_sight_line(1, 1)
  assert not trees._higher_on_a_sight_line(2, 2)
  # The difference:
  assert trees._higher_than_a_neighbour(3, 3)
  assert not trees._higher_on_a_sight_line(3, 3)

def test_visible_tree_count():
  trees = Trees('day08-test.txt')
  assert trees.visible_tree_count == 21
