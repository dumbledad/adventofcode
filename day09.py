class Bridge:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
    self.motions = list([{ 'direction': pair[0], 'steps': int(pair[1]) } for line in self.data.splitlines() if len(pair := line.split()) == 2])
    self.head_positions = [(0, 0)]
    self.tail_positions = [(0, 0)]
    self.perform_moves()

  def perform_moves(self):
    for motion in self.motions:
      self._perform_move(**motion)

  @property
  def tail_positions_count(self):
    return len(set(self.tail_positions))

  def _perform_move(self, direction, steps):
    if (steps == 1):
      self.head_positions.append(self._move(self.head_positions[-1], direction))
      self.tail_positions.append(self._suggest(self.head_positions[-1], self.tail_positions[-1]))
    else:  
      for _ in range(0, steps):
        self._perform_move(direction, 1)

  def _move(self, position, direction):
    match direction:
      case 'U':
        return (position[0], position[1] + 1)
      case 'D':
        return (position[0], position[1] - 1)
      case 'L':
        return (position[0] - 1, position[1])
      case 'R':
        return (position[0] + 1, position[1])

  def _suggest(self, head, tail):
    suggestion = (tail[0], tail[1])
    far_enough = abs(head[0] - tail[0]) > 1 or abs(head[1] - tail[1]) > 1
    if head[0] > tail[0] and far_enough:
      suggestion = (suggestion[0] + 1, suggestion[1])
    elif head[0] < tail[0] and far_enough:
      suggestion = (suggestion[0] - 1, suggestion[1])
    if head[1] > tail[1] and far_enough:
      suggestion = (suggestion[0], suggestion[1] + 1)
    elif head[1] < tail[1] and far_enough:
      suggestion = (suggestion[0], suggestion[1] - 1)
    return suggestion
