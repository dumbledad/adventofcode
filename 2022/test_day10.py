from day10 import CRT

simples = '''
noop
addx 3
addx -5
'''

def test_crt_init():
  crt = CRT('../inputs/2022/day10-test.txt')
  assert crt.data
  assert crt.registers['X'] == [1]
  assert crt.instructions[0] == ['addx', 15]
  assert crt.instructions[9] == ['noop']
  assert len(crt.instructions) == 146
  assert len(crt.screen) == 6
  assert len(crt.screen[0]) == 40
  assert crt.screen[5][21] == '.'

def test_perform_instructions_with_register():
  instructions = CRT.parse_instructions(simples)
  register = CRT.perform_instructions_with_register([1], instructions)
  assert register == [1, 1, 1, 4, 4, -1]

def test_signal_strengths():
  crt = CRT('../inputs/2022/day10-test.txt')
  assert crt.signal_strengths() == [420, 1140, 1800, 2940, 2880, 3960]
  assert sum(crt.signal_strengths()) == 13140 # Testing aoc wording not Python

def test_render_screen():
  crt = CRT('../inputs/2022/day10-test.txt')
  crt.render_screen()
  assert ''.join(crt.screen[0]) == '##..##..##..##..##..##..##..##..##..##..'
  assert ''.join(crt.screen[1]) == '###...###...###...###...###...###...###.'
  assert ''.join(crt.screen[2]) == '####....####....####....####....####....'
  assert ''.join(crt.screen[3]) == '#####.....#####.....#####.....#####.....'
  assert ''.join(crt.screen[4]) == '######......######......######......####'
  assert ''.join(crt.screen[5]) == '#######.......#######.......#######.....'