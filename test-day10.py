from day10 import CRT

simples = '''
noop
addx 3
addx -5
'''

def test_init():
  crt = CRT('day10-test.txt')
  assert crt.data
  assert crt.registers['X'] == 1
