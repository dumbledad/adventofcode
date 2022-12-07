import re

class File:
  def __init__(self, name, size):
    self.name = name
    self.size = size

class Dir:
  def __init__(self, name, parent=None):
    self.name = name
    self._parent = parent
    self._sub_dirs = []
    self._files = []

  def add_file(self, file_name, file_size):
    if not [file for file in self._files if file.name == file_name]:
      self._files.append(File(file_name, file_size))

  def cd(self, dir_name):
    sub_dir =  next((sub_dir for sub_dir in self._sub_dirs if sub_dir.name == dir_name), None)
    if not sub_dir:
      sub_dir = Dir(dir_name, self)
      self._sub_dirs.append(sub_dir)
    return sub_dir
  
  def up(self):
    if self._parent:
      return self._parent
    raise Exception('Cannot .. from root directory')

  def sum_size_under(self, under):
    return sum([file.size for file in self._files if file.size <= under])


class Filesystem:
  @classmethod
  def parse_dir_tree(cls, rows):
    root = cwd = Dir('root')
    for row in rows:
      cd_match = re.match('\$ cd (.+)', row)
      if cd_match:
        cwd = cwd.cd(cd_match.group(1))
        continue
      if row == '$ cd ..':
        cwd = cwd.up()
        continue
      file_match = re.match('(\d+) (.*)', row)
      if file_match:
        cwd.add_file(file_match.group(2), file_match.group(1))
    return root

  def __init__(self, filename):
    with open(filename) as data:
      self.data = data.read()
      self.root = Filesystem.parse_dir_tree(self.data.splitlines())

  def file_sum(self, under):
    return sum([int(num.strip()) for num in re.findall('\\n(\d+)', self.data) if int(num.strip()) <= under])


def main():
  fs = Filesystem('day07.txt')
  print(f"Part 1: {fs.file_sum(100_000)}")

if __name__ == "__main__":
  main()