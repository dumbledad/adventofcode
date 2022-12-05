import re
from collections import defaultdict
from functools import cached_property

class CargoShip:
  @classmethod
  def stack_to_str(cls, stack):
    if len(stack) > 0:
      return ''.join(stack).replace('[', '').replace(']', '').strip()
    return ''
    
  def __init__(self, filename):
    self.stacks = defaultdict(list)
    self.moves = []
    self.stack_names = []
    with open(filename) as f:
      for line in f:
        self._parse_row(line)
  
  @property
  def stack_tops(self):
    return ''.join([CargoShip.stack_to_str(self.stacks[stack])[-1] for stack in self.stacks if len(stack) > 0])

  def move_crates(self):
    for move in self.moves:
      self._do_move(move)
  
  def print_stacks(self):
    for stack_name in self.stack_names:
      print(f'{stack_name}: {CargoShip.stack_to_str(self.stacks[stack_name])}')

  def _do_move(self, move):
    for _ in range(0, move['moves']):
      self._move_crate(move['from'], move['to'])

  def _move_crate(self, from_stack, to_stack):
    crate = self.stacks[from_stack].pop()
    self.stacks[to_stack].append(crate)

  def _parse_row(self, row):
    move_match = re.match('move (\d+) from (\d+) to (\d+)$', row)
    if move_match:
      self.moves.append({
        'moves': int(move_match.group(1)),
        'from': move_match.group(2),
        'to': move_match.group(3)
      })
      return
    stack_name_matches = re.findall(' *\d+ *', row)
    if stack_name_matches:
      self.stack_names = [stack_name.strip() for stack_name in stack_name_matches]
      return
    stacks = re.findall('    ?|\[[A-Z]\] ?', row)
    if stacks:
      for i, crate in enumerate(stacks):
        if len(crate.strip()) > 0:
          self.stacks[str(i + 1)] = [crate] + self.stacks[str(i + 1)]
        else:
          self.stacks[str(i + 1)] = self.stacks[str(i + 1)] # Create the stack
    

def main():
  ship = CargoShip('day05.txt')
  ship.move_crates()
  print(f'Part 1: {ship.stack_tops}')

if __name__ == "__main__":
  main()