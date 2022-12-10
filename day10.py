class CRT:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
    self.registers = { 'X': 1 }
