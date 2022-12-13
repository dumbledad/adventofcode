from functools import cmp_to_key
import json
import logging

class Packets:
  @classmethod
  def compare(cls, left, right, indent=''):
    logging.info(f'{indent}- Compare {left} vs {right}')
    if isinstance(left, list) and isinstance(right, int):
      right = [right]
    elif isinstance(left, int) and isinstance(right, list):
      left = [left]
    if isinstance(left, int) and isinstance(right, int):
      if left < right:
        logging.info(f'  {indent}- Left side is smaller, so inputs are in the right order')
        return True
      elif left > right:
        logging.info(f'  {indent}- Right side is smaller, so inputs are not in the right order')
        return False
    if isinstance(left, list) and isinstance(right, list):
      for i in range(max(len(left), len(right))):
        if i >= len(left):
          logging.info(f'  {indent}- Left side ran out of items, so inputs are in the right order')
          return True
        elif i >= len(right):
          logging.info(f'  {indent}- Right side ran out of items, so inputs are not in the right order')
          return False
        match Packets.compare(left[i], right[i], indent=indent+'  '):
          case True:
            return True
          case False:
            return False
          case None:
            continue # Included for readability
    return None

  @classmethod
  def cmp(cls, left, right):
    if Packets.compare(left, right):
      return -1
    elif Packets.compare(right, left):
      return 1
    return 0
      
  def __init__(self, filename):
    self.divider_packets = [[[2]], [[6]]]
    with open(filename) as file:
      self.data = file.read()
    self.potentials = []
    for i, pair in enumerate(self.data.split('\n\n')):
      self.potentials.append(tuple([json.loads(packet_str) for packet_str in pair.splitlines()]))

  @property
  def correct_indexes(self):
    return [i + 1 for i in range(len(self.potentials)) if Packets.compare(self.potentials[i][0], self.potentials[i][1])]
  
  @property
  def sorted_packets(self):
    packets = [packet for comparison_pair in self.potentials for packet in comparison_pair]
    packets += self.divider_packets
    packets.sort(key=cmp_to_key(Packets.cmp))
    # return sorted(packets, key=cmp_to_key(Packets.compare), reverse=True)
    return packets

  @property
  def key_indices(self):
    return [i + 1 for i in range(len(self.sorted_packets)) if self.sorted_packets[i] in self.divider_packets]


def main():
  # logging.basicConfig(level=logging.INFO)
  # packets = Packets('inputs/2022/day13-test.txt')
  packets = Packets('inputs/2022/day13.txt')
  print(f'Part 1: {sum(packets.correct_indexes)}')

if __name__ == '__main__':
  main()
