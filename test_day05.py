from day05 import CargoShip

def test_cargoship_init_moves():
  ship = CargoShip('day05-test.txt')
  assert len(ship.moves) == 4
  assert ship.moves[0]['moves'] == 1
  assert ship.moves[0]['from'] == '2'
  assert ship.moves[0]['to'] == '1'
  assert ship.moves[-1]['moves'] == 1
  assert ship.moves[-1]['from'] == '1'
  assert ship.moves[-1]['to'] == '2'

def test_cargoship_init_stacks():
  ship = CargoShip('day05-test.txt')
  assert ship.stacks['1'] == ['[Z]', '[N]']
  assert '2' in ship.stacks
  assert '3' in ship.stacks
  assert '4' not in ship.stacks

def test_cargoship_init_stack_names():
  ship = CargoShip('day05-test.txt')
  assert ship.stack_names == ['1', '2', '3']
  assert ship.stack_names == list(ship.stacks)
  assert ship.stack_tops == 'NDP'

def test_cargoship_init_real_data():
  ship = CargoShip('day05.txt')
  assert ship.stack_tops == 'ZLFGWFJQP'

def test_cargoship_move_crate():
  ship = CargoShip('day05-test.txt')
  ship._move_crate('1', '3')
  assert CargoShip.stack_to_str(ship.stacks['3']) == 'PN'

def test_cargoship_do_move():
  ship = CargoShip('day05-test.txt')
  ship._do_move({
    'moves': 3,
    'from': '2',
    'to': '1'
  })
  assert CargoShip.stack_to_str(ship.stacks['1']) == 'ZNDCM'

def test_cargoship_move_crates():
  ship = CargoShip('day05-test.txt')
  ship.move_crates()
  assert ship.stack_tops == 'CMZ'
