from functools import cached_property
import sys
import re

class Cave:
  def __init__(self, filename):
    self.start = (500, 0)
    with open(filename) as file:
      self.data = file.read()
    # for line in self.data.splitlines():

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
