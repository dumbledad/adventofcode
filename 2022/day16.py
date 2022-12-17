import re

class Valve:
  def __init__(self, name, flow, to_names):
    self.name = name
    self.flow = flow
    self.to_names = to_names
    self.to = []
    self.open = False
    self.flowed = 0

  def __eq__(self, other):
    return self.name == other.name

  def __ne__(self, other):
    return self.name != other.name
  
  def __lt__(self, other):
    return self.flow < other.flow

  def __le__(self, other):
    return self.flow <= other.flow

  def __gt__(self, other):
    return self.flow > other.flow

  def __ge__(self, other):
    return self.flow >= other.flow

  def tick(self):
    if self.open:
      self.flowed += self.flow

  def reset(self):
    self.open = False
    self.flowed = 0

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
    all_routes = self.routes()
    

  def routes(self, start=None, prior=[], max_depth=30):
    if not start:
      start = self.current
    if max_depth == 0:
      return prior
    result = []
    if f'open{start.name}' not in prior:
      result.extend(
        self.routes(
          start=start,
          prior=prior.append(f'open{start.name}'),
          max_depth=max_depth-1
        )
      )
    for valve in start.to:
      result.extend(
        self.routes(
          start=valve,
          prior=prior.append(valve.name),
          max_depth=max_depth-1
        )
      )
    return result

  def score_route(self, route):
    
      