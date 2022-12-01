import csv
import sys
import numpy as np

class Calories:
  """Store the calorie count of each elf"""
  
  def __init__(self, filename):
    with open(filename, newline='') as csv_file:
      count = 0
      elves = []
      reader = csv.reader(csv_file, quoting=csv.QUOTE_NONNUMERIC)
      for row in reader:
        if len(row) == 0:
          elves.append(count)
          count = 0
        else:
          count += int(row[0])
    self.elves = np.array(elves)         

def main(filename):
  calories = Calories(filename)
  argmax = np.argmax(calories.elves)
  print(f'Part 1: elf {argmax + 1} is carrying {calories.elves[argmax]} calories')

if __name__ == "__main__":
  # Call `python day_1.py <csv_file>`
  main(sys.argv[1])
  