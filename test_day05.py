from day05 import CargoShip

def test_cargoship_init():
  ship = CargoShip('day05-test.txt')
  assert len(ship.moves) == 4
  assert ship.moves[0]['move'] == 1
  assert ship.moves[0]['from'] == '2'
  assert ship.moves[0]['to'] == '1'
  assert ship.moves[-1]['move'] == 1
  assert ship.moves[-1]['from'] == '1'
  assert ship.moves[-1]['to'] == '2'
