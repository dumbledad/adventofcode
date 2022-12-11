class Monkey:
  @classmethod
  def bored_with(cls, item):
    result = round(item / 3)
    return result

  def __init__(self, starting_items, operation, test):
    self.items = starting_items
    self.operation = operation
    self.test = test

  def take_turn(self):
    thrown = []
    for item in self.items:
      self.inspect(item)
      Monkey.bored_with(item)
      thrown.append(self.throw(item))
    return thrown

  def inspect(self, item):
    return self.operation(item)


class Troupe:
  def __input__(self, filename):
    return -1