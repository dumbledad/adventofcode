class Bridge:
  def __init__(self, filename, knot_count=2):
    with open(filename) as file:
      self.data = file.read()
    self.motions = list([{ 'direction': pair[0], 'steps': int(pair[1]) } for line in self.data.splitlines() if len(pair := line.split()) == 2])
    self.positions = list([[(0,0)] for _ in range(0, knot_count)])
    self.head_positions = self.positions[0]
    self.tail_positions = self.positions[-1]
    self.perform_moves()

  def perform_moves(self):
    for motion in self.motions:
      self._perform_move(**motion)

  @property
  def tail_positions_count(self):
    return len(set(self.tail_positions))

  def _perform_move(self, direction, steps):
    if (steps == 1):
      self.positions[0].append(self._move(self.positions[0][-1], direction))
      for i in range(1, len(self.positions)):
        self.positions[i].append(self._suggest(self.positions[i - 1][-1], self.positions[i][-1]))
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

  def _suggest(self, leader, follower):
    suggestion = (follower[0], follower[1])
    far_enough = abs(leader[0] - follower[0]) > 1 or abs(leader[1] - follower[1]) > 1
    if leader[0] > follower[0] and far_enough:
      suggestion = (suggestion[0] + 1, suggestion[1])
    elif leader[0] < follower[0] and far_enough:
      suggestion = (suggestion[0] - 1, suggestion[1])
    if leader[1] > follower[1] and far_enough:
      suggestion = (suggestion[0], suggestion[1] + 1)
    elif leader[1] < follower[1] and far_enough:
      suggestion = (suggestion[0], suggestion[1] - 1)
    return suggestion


def main():
  bridge = Bridge('inputs/2022/day09.txt')
  print(f'Part 1: {bridge.tail_positions_count}')
  bridge = Bridge('inputs/2022/day09.txt', 10)
  print(f'Part 2: {bridge.tail_positions_count}')

if __name__ == "__main__":
  main()