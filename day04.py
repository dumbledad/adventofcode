import csv

class Assignments:
  @classmethod
  def has_containment(cls, range1, range2):
    set1 = set(range1)
    set2 = set(range2)
    intersection = set1.intersection(set2)
    return intersection == set1 or intersection == set2

  def __init__(self, filename):
    self.pairs = []
    with open(filename, newline='') as csv_file:
      reader = csv.reader(csv_file)
      for row in reader:
        if len(row) > 0:
          self.pairs.append(self._parse_row(row))
  
  def containment_count():
    return 1

  def _parse_row(self, row):
    return [self._parse_range(row[0]), self._parse_range(row[1])]

  def _parse_range(self, range_string):
    range_elements = range_string.split('-')
    return range(int(range_elements[0]), int(range_elements[1]) + 1)
  