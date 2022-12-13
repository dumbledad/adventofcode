import json

class Packets:
  @classmethod
  def compare(cls, left, right):
    if isinstance(left, list) and isinstance(right, int):
      right = [right]
    elif isinstance(left, int) and isinstance(right, list):
      left = [left]
    if isinstance(left, int) and isinstance(right, int):
      if left < right:
        return True
      elif left > right:
        return False
    if isinstance(left, list) and isinstance(right, list):
      for i in range(len(right)):
        if i >= len(left):
          return True
        match Packets.compare(left[i], right[i]):
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
    for pair in self.data.split('\n\n'):
     self.potentials.append(tuple([json.loads(packet_str) for packet_str in pair.splitlines()]))

  @property
  def correct_indexes(self):
    return [i + 1 for i in range(len(self.potentials)) if Packets.compare(self.potentials[i][0], self.potentials[i][1])]

def main():
  packets = Packets('inputs/2022/day13.txt')
  # print(f'Part 1: {sum(packets.correct_indexes)}')
  for i in packets.correct_indexes:
    print(f'{i - 1}: {packets.potentials[i - 1]}')

if __name__ == '__main__':
  main()
