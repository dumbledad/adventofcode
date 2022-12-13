import json
import logging

class Packets:
  @classmethod
  def compare(cls, left, right, indent=''):
    logging.debug(f'{indent}Compare {left} vs {right}')
    if isinstance(left, list) and isinstance(right, int):
      right = [right]
    elif isinstance(left, int) and isinstance(right, list):
      left = [left]
    if isinstance(left, int) and isinstance(right, int):
      if left < right:
        logging.debug(f'  {indent} Left side is smaller, so inputs are in the right order')
        return True
      elif left > right:
        logging.debug(f'  {indent} Right side is smaller, so inputs are not in the right order')
        return False
    if isinstance(left, list) and isinstance(right, list):
      for i in range(max(len(left), len(right))):
        if i >= len(left):
          logging.debug(f'  {indent} Left side ran out of items, so inputs are in the right order')
          return True
        elif i >= len(right):
          logging.debug(f'  {indent} Right side ran out of items, so inputs are not in the right order')
          return False
        match Packets.compare(left[i], right[i], indent=indent+'  '):
          case True:
            return True
          case False:
            return False
          case None:
            continue # Included for readability
    return None

  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
    self.potentials = []
    for i, pair in enumerate(self.data.split('\n\n')):
      logging.debug(f'== Pair {i + 1} ==')
      self.potentials.append(tuple([json.loads(packet_str) for packet_str in pair.splitlines()]))
      logging.debug('\n')

  @property
  def correct_indexes(self):
    return [i + 1 for i in range(len(self.potentials)) if Packets.compare(self.potentials[i][0], self.potentials[i][1])]

def main():
  packets = Packets('inputs/2022/day13-test.txt')
  print(f'Part 1: {sum(packets.correct_indexes)}')
  # for i in packets.correct_indexes:
  #   print(f'{i - 1}: {packets.potentials[i - 1]}')

if __name__ == '__main__':
  main()
