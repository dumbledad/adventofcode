from functools import reduce

class Monkey:
  def __init__(self, starting_items, operation, test, bored_divisor):
    self.items = starting_items
    self.inspection_count = 0
    self.operation = operation
    self.test = test
    self.bored_divisor = bored_divisor

  def take_turn(self):
    thrown = []
    for item in self.items:
      worried = self.inspect(item)
      worried = int(worried / self.bored_divisor)
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
  def __init__(self, filename, bored_divisor=3):
    monkey_txt = 'Monkey '
    starting_items_txt = '  Starting items: '
    operation_txt = '  Operation: '
    divisible_test_txt = '  Test: divisible by '
    true_txt = '    If true: throw to monkey '
    false_txt = '    If false: throw to monkey '
    self.monkeys = []
    current_monkey = {'bored_divisor': bored_divisor}
    with open(filename) as file:
      self.data = file.read()
    for line in self.data.splitlines():
      if line.startswith(starting_items_txt):
        current_monkey['starting_items'] = list([int(item) for item in line.replace(starting_items_txt, '').split(',')])
      elif line.startswith(operation_txt):
        current_monkey['operation'] = compile(line.replace(operation_txt, ''), '<string>', 'exec')
      elif line.startswith(divisible_test_txt):
        current_test = { 'divisor': int(line.replace(divisible_test_txt, '')) }
      elif line.startswith(true_txt):
        current_test['true'] = int(line.replace(true_txt, ''))
      elif line.startswith(false_txt):
        current_test['false'] = int(line.replace(false_txt, ''))
        current_monkey['test'] = current_test
        self.monkeys.append(Monkey(**current_monkey))
        current_monkey = {'bored_divisor': bored_divisor}
      self.product = 1
      for monkey in self.monkeys:
        if self.product % monkey.test['divisor'] != 0:
          self.product *= monkey.test['divisor']

  def perform_round(self):
    for monkey in self.monkeys:
      throws = monkey.take_turn()
      for throw in throws:
        throw['item'] %= self.product
        self.monkeys[throw['monkey']].items.append(throw['item'])

  def perform_rounds(self, count):
    for _ in range(0, count):
      self.perform_round()

  @property
  def monkey_business(self):
    largest = sorted([monkey.inspection_count for monkey in self.monkeys], reverse=True)[0:2]
    return largest[0] * largest[1]
  
def main():
  troupe = Troupe('../inputs/2022/day11.txt')
  troupe.perform_rounds(20)
  print(f'Part 1: {troupe.monkey_business}')
  troupe = Troupe('../inputs/2022/day11.txt', 1)
  troupe.perform_rounds(10_000)
  print(f'Part 2: {troupe.monkey_business}')

if __name__ == '__main__':
  main()
