
class Cave:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
