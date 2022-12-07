from day07 import Filesystem

# def test_filesystem_file_sum():
#   fs = Filesystem('day07-test.txt')
#   assert fs.file_sum(100_000) == 94_853

def test_filesystem_init():
  fs = Filesystem('day07-test.txt')
  assert fs.data
