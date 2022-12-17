import re

class Valve:
  def __init__(self, name, flow, to_names):
    self.name = name
    self.flow = flow
    self.to_names = to_names
    self.to = []
    self.open = self.flow == 0
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
    if self.flow > 0:
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
    max_score, max_route = -1, None
    all_routes = self.routes(max_depth=minutes)
    for route in all_routes:
      score = self.score_route(route)
      if score > max_score:
        max_score = score
        max_route = route
    return max_score, max_route

  def tick(self):
    for valve in self.valves:
      valve.tick()
  
  def flowed(self):
    return sum([valve.flowed for valve in self.valves])

  def reset(self):
    for valve in self.valves:
      valve.reset()

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
          prior=prior + [f'open{start.name}'],
          max_depth=max_depth-1
        )
      )
    for valve in start.to:
      result.extend(
        self.routes(
          start=valve,
          prior=prior + [valve.name],
          max_depth=max_depth-1
        )
      )
    return result

  def score_route(self, route):
    self.reset()
    for entry in route:
      self.tick()
      if entry.startswith('open'):
        if valve := next([valve for valve in self.valves if entry.endswith(valve.name)], None):
          valve.open = True
    return self.flowed()
      