import json

class Packets:
  @classmethod
  def compare(cls, left, right):
    if isinstance(left, list) and isinstance(right, int):
      right = [right]
    elif isinstance(left, int) and isinstance(right, list):
      left = [left]
    if isinstance(left, int) and isinstance(right, int) and left < right:
      return False
    if isinstance(left, list) and isinstance(right, list):
      if len(left) > len(right):
        return False
      for i in range(len(left)):
        if not Packets.compare(left[i], right[i]):
          return False
    return True

  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
    self.potentials = []
    for pair in self.data.split('\n\n'):
     self.potentials.append(tuple([json.loads(packet_str) for packet_str in pair.splitlines()]))

  @property
  def right_indexes(self):
    return [i + 1 for i in range(len(self.potentials)) if Packets.compare(self.potentials[i][0], self.potentials[i][0])]
