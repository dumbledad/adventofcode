from functools import cached_property, reduce
import operator
import re

class Cave:
  def __init__(self, filename):
    self.start = (500, 0)
    with open(filename) as file:
      self.data = file.read()
    self.grid = []
    for _ in range(self.bounds['max_y'] + 1):
      self.grid.append(['.'] * (self.bounds['max_x'] + 1))
    for line in self.data.splitlines(): # Overlapping regex too hard
      coords = line.split(' -> ')
      for idx in range(len(coords)):
        if idx + 1 < len(coords):
          start_line = tuple([int(num) for num in coords[idx].split(',')])
          end_line = tuple([int(num) for num in coords[idx + 1].split(',')])
          if start_line[0] <= end_line[0]:
            x_range = range(start_line[0], end_line[0] + 1)
          else:
            x_range = range(end_line[0], start_line[0] + 1)
          for x in x_range:
            if start_line[1] <= end_line[1]:
              y_range = range(start_line[1], end_line[1] + 1)
            else:
              y_range = range(end_line[1], start_line[1] + 1)
            for y in y_range:
              self.grid[y][x] = '#'
    self.grid[self.start[1]][self.start[0]] = '+'
    self.grains = []

  @cached_property
  def bounds(self):
    bounds = { 
      'min_x': self.start[0],
      'max_x': self.start[0],
      'min_y': self.start[1],
      'max_y': self.start[1]
    }
    for line in self.data.splitlines():
      for match in re.finditer(r'(\d+),(\d+)', self.data):
        if int(match.group(1)) < bounds['min_x']:
          bounds['min_x'] = int(match.group(1))
        elif int(match.group(1)) > bounds['max_x']:
          bounds['max_x'] = int(match.group(1))
        if int(match.group(2)) < bounds['min_y']:
          bounds['min_y'] = int(match.group(2))
        elif int(match.group(2)) > bounds['max_y']:
          bounds['max_y'] = int(match.group(2))
    return bounds

  def draw(self, row_numbers=False, with_floor=False):
    bonkers_min_x = self.start[0] - ((self.bounds['max_x'] + self.bounds['max_y']) - self.start[0])
    min_x = bonkers_min_x if with_floor else self.bounds['min_x']
    for i, row in enumerate(self.grid):
      row_number_str = f'{i} ' if row_numbers else ''
      print(f"{row_number_str}{''.join(row[min_x:])}")

  def drop_grain(self, with_floor=True):
    grain_coords = self.start
    while (grain_coords[1] < self.bounds['max_y']) or with_floor:
      if self.grid[self.start[1]][self.start[0]] == 'o': # There's sand blocking the start
        return False
      elif self.grid[grain_coords[1] + 1][grain_coords[0]] == '.':
        grain_coords = (grain_coords[0], grain_coords[1] + 1)
      elif self.grid[grain_coords[1] + 1][grain_coords[0] - 1] == '.':
        grain_coords = (grain_coords[0] - 1, grain_coords[1] + 1)
      elif self.grid[grain_coords[1] + 1][grain_coords[0] + 1] == '.':
        grain_coords = (grain_coords[0] + 1, grain_coords[1] + 1)
      else:
        self.grid[grain_coords[1]][grain_coords[0]] = 'o'
        self.grains.append(grain_coords)
        return True
    return False

  def keep_pouring(self, with_floor=True):
    if with_floor:
      self._add_floor()
    while(self.drop_grain(with_floor)):
      continue
    return len(self.grains)

  def _add_floor(self):
    max_x = self.bounds['max_x'] + self.bounds['max_y']
    for i, row in enumerate(self.grid):
      row.extend(['.'] * self.bounds['max_y'])
    self.grid.append(['.'] * max_x)
    self.grid.append(['#'] * max_x) 

def main():
  filename = 'inputs/2022/day14.txt'
  cave = Cave(filename)
  print(f'Part 1: {cave.keep_pouring(False)}')
  cave = Cave(filename)
  print(f'Part 1: {cave.keep_pouring(True)}')

if __name__ == '__main__':
  main()
