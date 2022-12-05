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

  def move_crates(self, crane_model=9_000):
    for move in self.moves:
      self._do_move(move, crane_model)
  
  def print_stacks(self):
    for stack_name in self.stack_names:
      print(f'{stack_name}: {CargoShip.stack_to_str(self.stacks[stack_name])}')

  def _do_move(self, move, crane_model=9_000):
    if crane_model == 9_000:
      for _ in range(0, move['moves']):
        self._move_crate(move['from'], move['to'])
    elif crane_model == 9_001:
      self._move_crate(move['from'], move['to'], count=move['moves'])
      

  def _move_crate(self, from_stack, to_stack, count=1):
    crates = self.stacks[from_stack][-1 * count:]
    self.stacks[from_stack] = self.stacks[from_stack][0: -1 * count]
    self.stacks[to_stack] += crates

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
          self.stacks[str(i + 1)] = [crate.strip()] + self.stacks[str(i + 1)]
        else:
          self.stacks[str(i + 1)] = self.stacks[str(i + 1)] # Create the stack
    

def main():
  ship = CargoShip('day05.txt')
  ship.move_crates(crane_model=9_000)
  print(f'Part 1: {ship.stack_tops}')
  ship = CargoShip('day05.txt')
  ship.move_crates(crane_model=9_001)
  print(f'Part 2: {ship.stack_tops}')

if __name__ == "__main__":
  main()