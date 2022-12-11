from functools import reduce
import operator

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

  @property
  def max_scenic_score(self):
    return max([self.scenic_score(i, j) for i in range(0, len(self.grid)) for j in range(0, len(self.grid[0]))])

  def viewing_distances(self, i, j):
    traveling = {
      'north': 0,
      'south': 0,
      'east': 0,
      'west': 0
    }
    for idx_i in range(i - 1, -1, -1):
      traveling['north'] += 1
      if self.grid[idx_i][j] >= self.grid[i][j]:
        break
    for idx_i in range(i + 1, len(self.grid[i])):
      traveling['south'] += 1
      if self.grid[idx_i][j] >= self.grid[i][j]:
        break
    for idx_j in range(j + 1, len(self.grid)):
      traveling['east'] += 1
      if self.grid[i][idx_j] >= self.grid[i][j]:
        break
    for idx_j in range(j - 1, -1, -1):
      traveling['west'] += 1
      if self.grid[i][idx_j] >= self.grid[i][j]:
        break
    return [traveling['north'], traveling['west'], traveling['east'], traveling['south']]

  def scenic_score(self, i, j):
    return reduce(operator.mul, self.viewing_distances(i, j), 1)

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


def main():
  tree = Trees('../inputs/2022/day08.txt')
  print(f'Part 1: {tree.visible_tree_count}')
  print(f'Part 2: {tree.max_scenic_score}')

if __name__ == "__main__":
  main()
