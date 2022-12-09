from day09 import Bridge

def test_init():
  bridge = Bridge('day09-test.txt')
  assert bridge.data
  assert bridge.motions[3]['direction'] == 'D'
  assert bridge.motions[3]['steps'] == 1
  assert len(bridge.motions) == 8
  