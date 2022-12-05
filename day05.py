import re
from functools import cached_property

class CargoShip:
  def __init__(self, filename):
    self.stacks = {}
    self.moves = []
    with open(filename) as f:
      for line in f:
        self._parse_row(line)

  def _parse_row(self, row): 
    move_match = re.match('move (\d+) from (\d+) to (\d+)$', row)
    if move_match:
      self.moves.append({
        'move': int(move_match.group(1)),
        'from': move_match.group(2),
        'to': move_match.group(3)
      })
    

def main():
  ship = CargoShip('day05.txt')
  print(f'Part 1: {1}')
  print(f'Part 2: {2}')

if __name__ == "__main__":
  main()