from day14 import Cave

filename = 'inputs/2022/day14-test.txt'

initial_grid = '''0 ......+...
1 ..........
2 ..........
3 ..........
4 ....#...##
5 ....#...#.
6 ..###...#.
7 ........#.
8 ........#.
9 #########.
'''

with_floor = '''............o............
...........ooo...........
..........ooooo..........
.........ooooooo.........
........oo#ooo##o........
.......ooo#ooo#ooo.......
......oo###ooo#oooo......
.....oooo.oooo#ooooo.....
....oooooooooo#oooooo....
...ooo#########ooooooo...
..ooooo.......ooooooooo..
#########################
'''

def test_cave_init():
  cave = Cave(filename)
  assert cave.data

def test_cave_bounds():
  cave = Cave(filename)
  assert cave.bounds == {
    'min_x': 494,
    'max_x': 503,
    'min_y': 0,
    'max_y': 9
  }

def test_cave_draw_no_floor(capfd):
  cave = Cave(filename)
  cave.draw(row_numbers=True)
  out, _ = capfd.readouterr()
  assert out == initial_grid

def test_cave_draw_floor(capfd):
  cave = Cave(filename)
  cave.draw(row_numbers=True)
  out, _ = capfd.readouterr()
  assert out == initial_grid

def test_cave_drop_grain():
  cave = Cave(filename)
  cave.drop_grain(False)
  assert cave.grid[8][500] == 'o'
  cave.drop_grain(False)
  assert cave.grid[8][499] == 'o'
  cave.drop_grain(False)
  assert cave.grid[8][501] == 'o'
  cave.drop_grain(False)
  assert cave.grid[7][500] == 'o'
  cave.drop_grain(False)
  assert cave.grid[8][498] == 'o'

def test_cave_keep_pouring():
  cave = Cave(filename)
  assert cave.keep_pouring(False) == 24
  cave = Cave(filename)
  assert cave.keep_pouring(True) == 93
