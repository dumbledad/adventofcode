import json

class Packets:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
