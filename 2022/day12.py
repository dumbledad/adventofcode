from functools import total_ordering
import sys

@total_ordering
class Hill:
  def __init__(self, height, i, j):
    self.visited = False
    self.position = (i, j)
    match height:
      case 'S':
        self.height = ord('a')
        self.tentative_distance = 0
        self.start = True
        self.end = False
      case 'E':
        self.height = ord('z')
        self.tentative_distance = sys.maxsize
        self.start = False
        self.end = True
      case _:
        self.height = ord(height)
        self.tentative_distance = sys.maxsize
        self.start = False
        self.end = False

    def __eq__(self, other):
      return self.position == other.position

    def __lt__(self, other):
      return self.tentative_distance < other.tentative_distance or (self.position[0] + self.position[1]) < (other.position[0] + other.position[1])


class Dijkstra:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
    self.hills = []
    for i, line in enumerate(self.data.splitlines()):
      for j, hill_char in enumerate(list(line)):
        hill = Hill(hill_char, i, j)
        if hill.end:
          self.end = hill
        self.hills.append(hill)

  @property
  def visited(self):
    return [hill for hill in self.hills if hill.visited]

  @property
  def unvisited(self):
    return [hill for hill in self.hills if not hill.visited]

  def find_path(self):
    while len(self.unvisited) > 0:
      current = min(self.unvisited)
      self.visit(current)
      if current.end:
        return current.tentative_distance

  def visit(self, hill):
    for neighbour in self.neighbours(hill, self.unvisited):
      if neighbour.tentative_distance > self.tentative_distance + 1:
        neighbour.tentative_distance = self.tentative_distance + 1
    hill.visited == True

  def neighbours(self, hill, hills):
    return [
      neighbour for neighbour in hills
      if
        abs(neighbour.position[0] - hill.position[0]) + abs(neighbour.position[1] - hill.position[1]) <= 1
        and neighbour.position != hill.position
        and neighbour.height - hill.height <= 1
    ]
