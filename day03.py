import csv
import sys
import pandas as pd
from functools import cache, reduce

class Rucksack:
  @classmethod
  def priority(cls, item):
    ascii = ord(item)
    return (ascii - 97) + 27 if ascii > 96 else ascii - 64

  def __init__(self, row):
    half = int(len(row)/2)
    self.compartments = [
      list(row[0:half]),
      list(row[half:])
    ]
    self.both = set(self.compartments[0]).intersection(self.compartments[1])

class Rucksacks:
  def __init__(self, filename):
    self.rucksacks = []
    with open(filename, newline='') as csv_file:
      reader = csv.reader(csv_file)
      for row in reader:
        if len(row) > 0:
          self.rucksacks.append(Rucksack(row))
  
  @cache
  def priority(self):
    return reduce(lambda x, y: Rucksack.priority(x.both) + Rucksack.priority(y.both), self.rucksacks)

def main(filename):
  rucksacks = Rucksacks(filename)
  print(f'Part 1: the sum of priorities of items in both compartments is {rucksacks.priority()}')

if __name__ == "__main__":
  # Call `python day_n.py <csv_file>`
  main(sys.argv[1])
  