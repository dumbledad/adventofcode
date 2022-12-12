import sys

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

class Dijkstra:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
    self.visited = list
    self.unvisited = list
    for i, line in enumerate(self.data.splitlines()):
      for j, hill_char in enumerate(list(line)):
        self.unvisited.append(Hill(hill_char, i, j))

  def visit(self, hill):
    return -1

  def unvisited_neighbours(self, hill):
    return list([
      neighbour for neighbour in self.unvisited
      if
        neighbour.position[0] >= 0
        and neighbour.position[1] >= 0
        and neighbour.height - hill.height <= 1
    ])
