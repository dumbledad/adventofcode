import pandas as pd
import re

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
    self._populate_grid()

  def _populate_grid(self):
    x_range =range(self.bounds['min_x'] - (self.bounds['max_distance'] + 1), self.bounds['max_x'] + self.bounds['max_distance'] + 2)
    y_range =range(self.bounds['min_y'] - (self.bounds['max_distance'] + 1), self.bounds['max_y'] + self.bounds['max_distance'] + 2)
    self.grid = pd.DataFrame('.', index=y_range, columns=x_range)
    for sensor in self.sensors:
      self.grid[sensor['coords'][0]][sensor['coords'][1]] = 'S'
      self.grid[sensor['closest_beacon'][0]][sensor['closest_beacon'][1]] = 'B'
      for y in y_range:
        for x in x_range:
          if self.grid[x][y] == '.':
            if ((abs(sensor['coords'][0] - x) + abs(sensor['coords'][1] - y)) <= sensor['distance']):
              self.grid[x][y] = '#'

  def impossible_count_old(self, y):
    impossible_x = set()
    for x in range(self.bounds['min_x'] - (self.bounds['max_distance'] + 1), self.bounds['max_x'] + self.bounds['max_distance'] + 2):
      for sensor in self.sensors:
        if (((abs(sensor['coords'][0] - x) + abs(sensor['coords'][1] - y)) <= sensor['distance'])
            and ((x, y) not in [s['coords'] for s in self.sensors])
            and ((x, y) not in [s['closest_beacon'] for s in self.sensors])):
          impossible_x.add(x)
    return len(impossible_x)

  def impossible_count(self, y):
    return self.grid.loc[y].value_counts()['#']


  # def distress_tuning(self, min=0, max=4_000_000):



def main():
  filename = 'inputs/2022/day15.txt'
  tunnels = Tunnels(filename)
  print(f'Part 1: {tunnels.impossible_count(2_000_000)}')

if __name__ == '__main__':
  main()
