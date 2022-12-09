class Bridge:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
      self.motions = list([{ 'direction': pair[0], 'steps': int(pair[1]) } for line in self.data.splitlines() if len(pair := line.split()) == 2])
