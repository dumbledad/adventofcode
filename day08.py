class Trees:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
      self.grid = [list(line) for line in self.data.splitlines()]
