from day07 import Filesystem

def test_filesystem_init():
  fs = Filesystem('day07-test.txt')
  assert fs.root._sub_dirs[0].name == '/'

def test_dir_all_sub_dirs():
  fs = Filesystem('day07-test.txt')
  assert len(fs.root.all_sub_dirs) == 4

def test_dir_sum_size_under():
  fs = Filesystem('day07-test.txt')
  assert fs.root.sum_size_under(100_000) == 95_437

def test_dir_size():
  fs = Filesystem('day07-test.txt')
  assert fs.root.size == 48_381_165