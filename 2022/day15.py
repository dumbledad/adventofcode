import pandas as pd
import re

def manhattan(p1, p2):
  return abs(p2[0] - p1[0]) + abs(p2[1] - p1[1])
class Tunnels:
  def __init__(self, filename):
    self.sensors = []
    with open(filename) as file:
      self.data = file.read()
    for line in self.data.splitlines():
      matches = re.match(r'Sensor at x=(-{0,1}\d+), y=(-{0,1}\d+): closest beacon is at x=(-{0,1}\d+), y=(-{0,1}\d+)', line)
      sensor_x = int(matches.group(1))
      sensor_y = int(matches.group(2))
      beacon_x = int(matches.group(3))
      beacon_y = int(matches.group(4))
      self.sensors.append({
        'coords': (sensor_x, sensor_y),
        'closest_beacon': (beacon_x, beacon_y),
        'distance': abs(beacon_x - sensor_x) + abs(beacon_y - sensor_y)
      })
    self.bounds = {
      'min_x': min(min([s['coords'][0] for s in self.sensors]), min([s['closest_beacon'][0] for s in self.sensors])),
      'max_x': max(max([s['coords'][0] for s in self.sensors]), max([s['closest_beacon'][0] for s in self.sensors])),
      'min_y': min(min([s['coords'][1] for s in self.sensors]), min([s['closest_beacon'][1] for s in self.sensors])),
      'max_y': max(max([s['coords'][1] for s in self.sensors]), max([s['closest_beacon'][1] for s in self.sensors])),
      'min_distance': min([s['distance'] for s in self.sensors]),
      'max_distance': max([s['distance'] for s in self.sensors]),
    }

  def impossible_count(self, y):
    impossible_x = set()
    for x in range(self.bounds['min_x'] - (self.bounds['max_distance'] + 1), self.bounds['max_x'] + self.bounds['max_distance'] + 2):
      for sensor in self.sensors:
        if (x not in impossible_x
            and (manhattan((x, y), sensor['coords']) <= sensor['distance'])
            and ((x, y) not in [s['coords'] for s in self.sensors])
            and ((x, y) not in [s['closest_beacon'] for s in self.sensors])):
          impossible_x.add(x)
    return len(impossible_x)

  def distress_tuning_too_slow(self, min=0, max=4_000_000):
    for y in range(min, max + 1):
      for x in range(min, max + 1):
        possible = True
        for sensor in self.sensors:
          if (abs(sensor['coords'][0] - x) + abs(sensor['coords'][1] - y)) <= sensor['distance']:
            possible = False
            break
        if possible:
          return (x * 4_000_000) + y

  def distress_tuning(self, min=0, max=4_000_000):
    # Inspired by https://old.reddit.com/r/adventofcode/comments/zmjzu7/2022_day_15_part_2_no_search_formula/
    # Find the sensors where their distance is d1 + d2 + 2 apart, e.g.
    #    #
    #   ###
    #    # #
    #     ###
    #      #
    for s1, s2 in [(s1, s2) for i, s1 in enumerate(self.sensors) for s2 in self.sensors[i + 1:]]:
      if (manhattan(s1['coords'], s2['coords']) == s1['distance'] + s2['distance'] + 2
          and s1['coords'][0] != s2['coords'][0]
          and s1['coords'][1] != s2['coords'][1]):
        sensor, other = (s1, s2) if s1['distance'] <= s2['distance'] else (s2, s1)
        # Check along the smaller one's boundary with the other one
        if sensor['coords'][0] < other['coords'][0]:
          x_range = range(sensor['coords'][0] + 1, sensor['coords'][0] + sensor['distance'])
        else:
          x_range = range(sensor['coords'][0] - 1, sensor['coords'][0]  - sensor['distance'], -1)
        if sensor['coords'][1] < other['coords'][1]:
          y_range = list(range(sensor['coords'][1] + 1, sensor['coords'][1] + sensor['distance']))
        else:
          y_range = list(range(sensor['coords'][1] - 1, sensor['coords'][1]  - sensor['distance'], -1))
        for i, x in enumerate(x_range):
          y = y_range[i]
          if x >= min and y >= min and x <= max and y <= max and self.point_outside_sensors((x, y)):
            return (x * 4_000_000) + y

  def point_outside_sensors(self, p):
    for sensor in self.sensors:
      if manhattan(sensor['coords'], p) <= sensor['distance']:
        return False
    return True


def main():
  filename = 'inputs/2022/day15.txt'
  tunnels = Tunnels(filename)
  print(f'Part 1: {tunnels.impossible_count(2_000_000)}')
  print(f'Part 2: {tunnels.distress_tuning()}')

if __name__ == '__main__':
  main()
