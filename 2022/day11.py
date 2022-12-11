class Monkey:
  @classmethod
  def bored_with(cls, item):
    return int(item / 3)

  def __init__(self, starting_items, operation, test):
    self.items = starting_items
    self.inspection_count = 0
    self.operation = operation
    self.test = test

  def take_turn(self):
    thrown = []
    for item in self.items:
      worried = self.inspect(item)
      worried = Monkey.bored_with(worried)
      thrown.append({ 'monkey': self.throw_to(worried), 'item': worried })
    self.items = []
    return thrown

  def inspect(self, item):
    vars = { 'old': item }
    exec(self.operation, vars)
    self.inspection_count += 1
    return vars['new']

  def throw_to(self, item):
    return self.test['true'] if item % self.test['divisor'] == 0 else self.test['false']


class Troupe:
  def __init__(self, filename):
    monkey_txt = 'Monkey '
    starting_items_txt = '  Starting items: '
    operation_txt = '  Operation: '
    divisible_test_txt = '  Test: divisible by '
    true_txt = '    If true: throw to monkey '
    false_txt = '    If false: throw to monkey '
    self.monkeys = []
    current_monkey = {}
    with open(filename) as file:
      self.data = file.read()
    for line in self.data.splitlines():
      if line.startswith(starting_items_txt):
        current_monkey['starting_items'] = list([int(item) for item in line.replace(starting_items_txt, '').split(',')])
      elif line.startswith(operation_txt):
        current_monkey['operation'] = line.replace(operation_txt, '')
      elif line.startswith(divisible_test_txt):
        current_test = { 'divisor': int(line.replace(divisible_test_txt, '')) }
      elif line.startswith(true_txt):
        current_test['true'] = int(line.replace(true_txt, ''))
      elif line.startswith(false_txt):
        current_test['false'] = int(line.replace(false_txt, ''))
        current_monkey['test'] = current_test
        self.monkeys.append(Monkey(**current_monkey))
        current_monkey = {}

  def perform_round(self):
    for monkey in self.monkeys:
      throws = monkey.take_turn()
      for throw in throws:
        self.monkeys[throw['monkey']].items.append(throw['item'])

  def perform_rounds(self, count):
    for _ in range(0, count):
      self.perform_round()
