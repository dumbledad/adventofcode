import re

class Directory:


  def __init__(self, filename):
    with open(filename) as data:
      self.data = data
      # self.root = self._parse_dirs(data.read())

  def _parse_dirs(self, data):
    parent = '__parent__'
    root = dict()
    cwd = root
    cd_prefix = '$ cd '
    dir_prefix = 'dir '
    ls_prefix = '$ ls'
    up_prefix = '$ cd ..'
    for row in data.split('\n'):
      if row.startswith(cd_prefix):
        dir = row.replace(cd_prefix, '')
        if not dir in cwd:
          cwd[dir] = { parent: cwd }
        parent = cwd
        cwd = cwd[dir]
      elif row.startswith(up_prefix):
        cwd = cwd[parent]
      elif row.startswith(dir_prefix) or row.startswith(ls_prefix):
        continue
      elif len(row) > 1:
        size_name = row.split()
        if size_name[1] == parent:
          raise Exception(f'{parent} is a reserved name and cannot be used as a directory nor file name') 
        cwd[size_name[1]] = int(size_name[0])
    return root

  def sum(self, under):
    # re.findall()
    return -1


def main():
  dir = Directory('day07.txt')
  print(f"Part 1: {dir.sum(under=100_000)}")

if __name__ == "__main__":
  main()