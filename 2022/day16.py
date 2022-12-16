from functools import total_ordering
import re

@total_ordering
class Valve:
  def __init__(self, name, flow, to_names):
    self.name = name
    self.flow = flow
    self.to_names = to_names
    self.to = []
    self.open = False
    self.flowed = 0

  def __eq__(self, other):
    return self.name.__eq__(other.name)
  
  def __lt__(self, other):
    return self.flow.__lt__(other.flow)

  def __le__(self, other):
    return self.flow.__le__(other.flow)

  def __gt__(self, other):
    return self.flow.__gt__(other.flow)

  def __ge__(self, other):
    return self.flow.__ge__(other.flow)

  def tick(self):
    if self.open:
      self.flowed += self.flow

class Cave:
  def __init__(self, filename) -> None:
    with open(filename) as file:
      self.data = file.read()
    pattern = re.compile(r'^Valve ([A-Z]{2}) has flow rate=(\d+); tunnels lead to valves ((?:[A-Z][A-Z][, ]*)+)')
    self.valves = []
    for line in self.data.splitlines():
      if match := pattern.match(line):
        valve = Valve(
          name = match.group(1),
          flow = int(match.group(2)),
          to_names = match.group(3).split(', '),
        )
        self.valves.append(valve)
    for valve in self.valves:
      valve.to = list([to_valve for to_valve in self.valves if to_valve.name in valve.to_names])
    self.current = self.valves[0]

  def do(self, minutes=30):
    for _ in range(minutes):
      for valve in self.valves:
        valve.tick()
      # One deep search
      if most_promising := max(valve for valve in self.current.to if not valve.open):
        if most_promising.flow > self.current.flow + 1 or self.current.open:
          print(f'You move to valve {most_promising.name}.')
          self.current = most_promising
          continue
      print(f'You open valve {self.current.name}.')
      self.current.open = True
    return sum([valve.flowed for valve in self.valves])