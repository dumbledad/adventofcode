from day05 import CargoShip

def test_cargoship_init_moves():
  ship = CargoShip('day05-test.txt')
  assert len(ship.moves) == 4
  assert ship.moves[0]['move'] == 1
  assert ship.moves[0]['from'] == '2'
  assert ship.moves[0]['to'] == '1'
  assert ship.moves[-1]['move'] == 1
  assert ship.moves[-1]['from'] == '1'
  assert ship.moves[-1]['to'] == '2'

def test_cargoship_init_stacks():
  ship = CargoShip('day05-test.txt')
  assert ship.stacks['1'] == ['[Z]', '[N]', '   ']
  assert '2' in ship.stacks
  assert '3' in ship.stacks
  assert '4' not in ship.stacks

def test_cargoship_init_stack_names():
  ship = CargoShip('day05-test.txt')
  assert ship.stack_names == ['1', '2', '3']
  assert ship.stack_names == list(ship.stacks)

def test_cargoship_stack_tops():
  ship = CargoShip('day05-test.txt')
  assert ship.stack_tops == 'NDP'
