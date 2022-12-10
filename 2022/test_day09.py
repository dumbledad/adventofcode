from day09 import Bridge

def test_init():
  bridge = Bridge('day09-test.txt')
  assert bridge.data
  assert bridge.motions[3]['direction'] == 'D'
  assert bridge.motions[3]['steps'] == 1
  assert len(bridge.motions) == 8

def test_tail_positions_count():
  bridge = Bridge('day09-test.txt')
  assert bridge.tail_positions_count == 13
  bridge = Bridge('day09-test.txt', 10)
  assert bridge.tail_positions_count == 1
  bridge = Bridge('day09-test-2.txt', 10)
  assert bridge.tail_positions_count == 36
  