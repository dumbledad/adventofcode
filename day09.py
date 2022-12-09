class Bridge:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
    self.motions = list([{ 'direction': pair[0], 'steps': int(pair[1]) } for line in self.data.splitlines() if len(pair := line.split()) == 2])
    self.head_positions = [(0, 0)]
    self.tail_positions = [(0, 0)]

  def perform_moves(self):
    for motion in self.motions:
      self._perform_move(*motion)

  def _perform_move(self, direction, steps):
    for i in range(0, steps):
      self
