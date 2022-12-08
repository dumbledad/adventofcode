class Trees:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
      self.grid = [list(line) for line in self.data.splitlines()]

  @property
  def visible_tree_count(self):
    count = 0
    for i, row in enumerate(self.grid):
      for j, _ in enumerate(row):
        if i == 0 or i == len(self.grid) - 1 or j == 0 or j == len(row) - 1:
          count += 1
          continue
        if self._higher_on_a_sight_line(i, j):
          count += 1
    return count

  def _higher_than_a_neighbour(self, i, j):
    return self.grid[i][j] > self.grid[i - 1][j] or \
           self.grid[i][j] > self.grid[i + 1][j] or \
           self.grid[i][j] > self.grid[i][j - 1] or \
           self.grid[i][j] > self.grid[i][j + 1]

  def _higher_on_a_sight_line(self, i, j):
    direction_count = 0
    for idx_i in range(0, i):
      if self.grid[idx_i][j] >= self.grid[i][j]:
        direction_count += 1
        break
    for idx_i in range(len(self.grid) - 1, i, -1):
      if self.grid[idx_i][j] >= self.grid[i][j]:
        direction_count += 1
        break
    for idx_j in range(0, j):
      if self.grid[i][idx_j] >= self.grid[i][j]:
        direction_count += 1
        break
    for idx_j in range(len(self.grid[i]) - 1, j, -1):
      if self.grid[i][idx_j] >= self.grid[i][j]:
        direction_count += 1
        break
    return direction_count < 4         
        
