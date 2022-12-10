from day10 import CRT

simples = '''
noop
addx 3
addx -5
'''

def test_crt_init():
  crt = CRT('day10-test.txt')
  assert crt.data
  assert crt.registers['X'] == [1]
  assert crt.instructions[0] == ['addx', 15]
  assert crt.instructions[9] == ['noop']
  assert len(crt.instructions) == 146
