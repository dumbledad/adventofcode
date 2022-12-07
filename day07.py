import re

class Directory:
  def __init__(self, filename):
    with open(filename) as data:
      self.data = data.read()

  def file_sum(self, under):
    return sum([int(end_num.strip()) for end_num in re.findall('\\n(\d+)', self.data) if int(end_num.strip()) <= under])


def main():
  dir = Directory('day07.txt')
  print(f"Part 1: {dir.sum(100_000)}")

if __name__ == "__main__":
  main()