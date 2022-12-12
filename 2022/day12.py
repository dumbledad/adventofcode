import sys

class Hill:
  def __init__(self, height):
    self.visited = False
    self.tentative_distance = sys.maxsize
    self.start = False
    self.end = False
    match height:
      case 'S':
        self.height = ord('a')
        self.start = True
      case 'E':
        self.height = ord('z')
        self.end = True
      case _:
        self.height = ord(height)

class Dijkstra:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
