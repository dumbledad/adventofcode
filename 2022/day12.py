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
    return (self.tentative_distance < other.tentative_distance) or ((self.tentative_distance == other.tentative_distance) and ((self.position[0] + self.position[1]) < (other.position[0] + other.position[1])))


class Dijkstra:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
    self.hills = []
    for i, line in enumerate(self.data.splitlines()):
      for j, hill_char in enumerate(list(line)):
        hill = Hill(hill_char, i, j)
        if hill.start:
          self.start = hill
        if hill.end:
          self.end = hill
        self.hills.append(hill)

  @property
  def visited(self):
    return [hill for hill in self.hills if hill.visited]

  @property
  def unvisited(self):
    return [hill for hill in self.hills if not hill.visited]
  
  def find_path(self, from_hill=None, neighbour_func=None, stop_test=None):
    if not from_hill:
      from_hill = self.start
    if not neighbour_func:
      neighbour_func = self.neighbours_up
    if not stop_test:
      stop_test = lambda x: x.end
    for hill in self.hills:
      hill.tentative_distance = sys.maxsize
      hill.visited = False
    from_hill.tentative_distance = 0
    while len(self.unvisited) > 0:
      current = min(self.unvisited)
      self.visit(current, neighbour_func)
      if stop_test(current):
        return current.tentative_distance
    
  def visit(self, hill, neighbour_func):
    for neighbour in neighbour_func(hill, self.unvisited):
      if neighbour.tentative_distance > hill.tentative_distance + 1:
        neighbour.tentative_distance = hill.tentative_distance + 1
    hill.visited = True

  def neighbours(self, hill, hills):
    return [
      neighbour for neighbour in hills
      if
        abs(neighbour.position[0] - hill.position[0]) + abs(neighbour.position[1] - hill.position[1]) <= 1
        and neighbour.position != hill.position
    ]

  def neighbours_up(self, hill, hills):
    return [neighbour for neighbour in self.neighbours(hill, hills) if neighbour.height - hill.height <= 1]

  def neighbours_down(self, hill, hills):
    return [neighbour for neighbour in self.neighbours(hill, hills) if hill.height - neighbour.height <= 1]


def main():
  dijkstra = Dijkstra('inputs/2022/day12.txt')
  print(f'Part 1: {dijkstra.find_path(dijkstra.start)}')
  print(f"Part 2: {dijkstra.find_path(dijkstra.end, dijkstra.neighbours_down, lambda x: x.height == ord('a'))}")

if __name__ == '__main__':
  main()