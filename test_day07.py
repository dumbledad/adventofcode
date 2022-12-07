from day07 import Directory

def test_directory_file_sum():
  dir = Directory('day07-test.txt')
  assert dir.sum(100_000) == 94_853
