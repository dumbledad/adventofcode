from day08  import Trees

def test_trees_init():
  trees = Trees('day08-test.txt')
  assert trees.data.count('\n') == 5
  assert len(trees.grid) == len(trees.grid[0]) == 5

def test_trees_higher():
  trees = Trees('day08-test.txt')
  assert trees._higher(1, 1)
  assert not trees._higher(2, 2)