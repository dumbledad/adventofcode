import csv

class Assignments:
  def __init__(self, filename):
    self.pairs = []
    with open(filename, newline='') as csv_file:
      reader = csv.reader(csv_file)
      for row in reader:
        if len(row) > 0:
          self.pairs.append(self.parse_row(row))

  def parse_row(self, row):
    return [self.parse_range(row[0]), self.parse_range(row[1])]

  def parse_range(self, range_string):
    range_elements = range_string.split('-')
    return range(int(range_elements[0]), int(range_elements[1]) + 1)