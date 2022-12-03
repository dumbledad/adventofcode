import csv
import sys
import pandas as pd
from functools import cache, reduce

class Rucksack:
  @classmethod
  def priority(cls, item):
    ascii = ord(item)
    return ascii - 96 if ascii > 96 else (ascii - 64) + 26

  def __init__(self, row):
    half = int(len(row)/2)
    self.items = list(row)
    self.compartments = [
      list(row[0:half]),
      list(row[half:])
    ]
    self.both = list(set(self.compartments[0]).intersection(self.compartments[1]))[0]

  def both_priority(self):
    return Rucksack.priority(self.both)

class Rucksacks:
  @classmethod
  def team_badge(cls, team):
    return list(
      set(team[0].items).intersection(set(team[1].items).intersection(set(team[2].items)))
    )[0]

  def __init__(self, filename):
    self.rucksacks = []
    with open(filename, newline='') as csv_file:
      reader = csv.reader(csv_file)
      for row in reader:
        if len(row) > 0:
          self.rucksacks.append(Rucksack(row[0]))
    # print(f'Priorities: {[Rucksack.priority(rucksack.both) for rucksack in self.rucksacks]}')
  
  @cache
  def priority(self):
    return sum([rucksack.both_priority() for rucksack in self.rucksacks])

  @cache
  def get_teams(self):
    self.teams = []
    previous = 0
    for i in range(3, len(self.rucksacks) + 1, 3):
      self.teams.append(self.rucksacks[previous:i])
      previous = i
    return self.teams
  
  @cache
  def get_badges(self):
    teams = self.get_teams()
    self.badges = [Rucksacks.team_badge(team) for team in teams]
    return self.badges


def main(filename):
  rucksacks = Rucksacks(filename)
  print(f'Part 1: the sum of priorities of items in both compartments is {rucksacks.priority()}')

if __name__ == "__main__":
  # Call `python day_n.py <csv_file>`
  main(sys.argv[1])
  