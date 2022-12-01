import csv
import sys

class Calories:
  """Store the calorie count of each elf"""
  
  def __init__(self, filename):
    self.elves = []
    with open(filename, newline='') as csv_file:
      count = 0
      reader = csv.reader(csv_file, quoting=csv.QUOTE_NONNUMERIC)
      for row in reader:
        if len(row) == 0:
          self.elves.append(count)
          count = 0
        else:
          count += int(row[0])

  def sum_max()         

def main(filename):
  calories = Calories(filename)
  print(f'Part 1: top elf is carrying {max(calories.elves)} calories')

if __name__ == "__main__":
  # Call `python day_1.py <csv_file>`
  main(sys.argv[1])
  