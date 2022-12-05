import pandas as pd

class AOCData:
  def __init__(self, filename, delimiter=',', header=None, skip_blank_lines=False):
    self.data = pd.read_csv(filename, delimiter=delimiter, header=header, skip_blank_lines=skip_blank_lines)