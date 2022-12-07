from day07 import Directory

def test_directory_parse_dirs():
  with open('day07-test.txt') as data:
    root = Directory.parse_dirs(data.read())
    assert '/' in root
