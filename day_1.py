import csv
import sys
import numpy as np

class Calories:
  """Store the calorie count of each elf"""
  elves = np.array()
  
  def __init__(self, filename):
    with open(filename, newline='') as csv_file:
      count = 0
      reader = csv.reader(csv_file, quoting=csv.QUOTE_NONNUMERIC)
      for row in reader:
        if row == '':
          self.elves.append(count)
        else:
          count += int(row)          

def main(filename):
  calories = Calories(filename)
  print(f'')

if __name__ == "__main__":
  # Call `python day_1.py <csv_file>`
  main(sys.argv[1])