class Trees:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
      self.grid = [list(line) for line in self.data.splitlines()]

  @property
  def visible_tree_count(self):
    count == 0
    for i, row in self.grid:
      for j, height in row:
        if i == 0 or i == len(self.grid) - 1 or j == 0 or j == len(row) - 1:
          count += 1
          continue

  def _higher(self, i, j):
    return self.grid[i][j] > self.grid[i - 1][j] and \
           self.grid[i][j] > self.grid[i + 1][j] and \
           self.grid[i][j] > self.grid[i][j - 1] and \
           self.grid[i][j] > self.grid[i][j + 1]                         
        
