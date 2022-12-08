from day08  import Trees

def test_trees_init():
  trees = Trees('day08-test.txt')
  assert trees.data.count('\n') == 5
  assert len(trees.grid) == len(trees.grid[0]) == 5
