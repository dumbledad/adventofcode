class CRT:
  def __init__(self, filename):
    with open(filename) as file:
      self.data = file.read()
    self.registers = { 'X': [1] }
    self.instructions = list([parsed for line in self.data.splitlines() if (parsed := self._parse(line))])

  def _parse(self, line):
    parsed = line.split()
    match len(parsed):
      case 2:
        return [parsed[0], int(parsed[1])]
      case 1:
        return parsed
      case _:
        return []

