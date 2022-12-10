from day07 import Filesystem

def test_filesystem_init():
  fs = Filesystem('inputs/2022/day07-test.txt')
  assert fs.root._sub_dirs[0].name == '/'

def test_dir_all_sub_dirs():
  fs = Filesystem('inputs/2022/day07-test.txt')
  assert len(fs.root.all_sub_dirs) == 4

def test_dir_sum_size():
  fs = Filesystem('inputs/2022/day07-test.txt')
  assert fs.root.sum_size(100_000) == 95_437

def test_dir_size():
  fs = Filesystem('inputs/2022/day07-test.txt')
  assert fs.root.size == 48_381_165

def test_dir_smallest_sub_dir_size():
  fs = Filesystem('inputs/2022/day07-test.txt')
  assert fs.root.smallest_sub_dir_size(8_381_165) == 24_933_642
