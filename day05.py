import re
from collections import defaultdict
from functools import cached_property

class CargoShip:
  def __init__(self, filename):
    self.stacks = defaultdict(list)
    self.moves = []
    self.stack_names = []
    with open(filename) as f:
      for line in f:
        self._parse_row(line)
  
  @property
  def stack_tops(self):
    return ''.join([''.join(self.stacks[stack]).replace('[', '').replace(']', '').strip()[-1] for stack in self.stacks])

  def _parse_row(self, row):
    move_match = re.match('move (\d+) from (\d+) to (\d+)$', row)
    if move_match:
      self.moves.append({
        'move': int(move_match.group(1)),
        'from': move_match.group(2),
        'to': move_match.group(3)
      })
      return
    stack_name_matches = re.findall(' *\d+ *', row)
    if stack_name_matches:
      self.stack_names = [stack_name.strip() for stack_name in stack_name_matches]
      return
    stacks = re.findall('   |\[[A-Z]\]', row)
    if stacks:
      for i, crate in enumerate(stacks):
        self.stacks[str(i + 1)] = [crate] + self.stacks[str(i + 1)]
    

def main():
  ship = CargoShip('day05.txt')
  print(f'Part 1: {1}')
  print(f'Part 2: {2}')

if __name__ == "__main__":
  main()