class Directory:
  @classmethod
  def parse_dirs(self, data):
    root = dict()

  def __init__(self, filename):
    with open(filename) as data:
      self.root = Directory.parse_dirs(data.read())

  def sum(self, under):
    return -1


def main():
  dir = Directory('day07.txt')
  print(f"Part 1: {dir.sum(under=100_000)}")

if __name__ == "__main__":
  main()