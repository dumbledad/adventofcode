class CRT:
  @classmethod
  def parse_instructions(cls, lines):
    return list([parsed for line in lines.splitlines() if (parsed := CRT._parse(line))])

  @classmethod
  def _parse(cls, line):
    parsed = line.split()
    match len(parsed):
      case 2:
        return [parsed[0], int(parsed[1])]
      case 1:
        return parsed
      case _:
        return []

  @classmethod
  def perform_instructions_with_register(cls, register, instructions):
    for instruction in instructions:
      match instruction[0]:
        case 'noop':
          register.append(register[-1])
        case 'addx':
          register.append(register[-1])
          register.append(register[-1] + instruction[1])
    return register

  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
    self.registers = { 'X': [1] }
    self.instructions = CRT.parse_instructions(self.data)
    self.screen = [['.'] * 40 for _ in range(0, 6)]

  def perform_instructions(self):
    self.registers['X'] = CRT.perform_instructions_with_register(self.registers['X'], self.instructions)
  
  def signal_strengths(self, start=20, step=40):
    if len(self.registers['X']) == 1:
      self.perform_instructions()
    return list([(i + 1) * self.registers['X'][i] for i in range(start - 1, len(self.registers['X']), step)])

  def render_screen(self):
    if len(self.registers['X']) == 1:
      self.perform_instructions()
    for i in range(0, 240):
      row = int(i / 40)
      column = i - (row * 40)
      if abs(self.registers['X'][i] - column) <= 1:
        self.screen[row][column] = '#'


def main():
  crt = CRT('inputs/2022/day10.txt')
  print(f'Part 1: {sum(crt.signal_strengths())}')
  crt.render_screen()
  for i in range(0, 6):
    print((''.join(crt.screen[i])).replace('.', ' '))

if __name__ == '__main__':
  main()