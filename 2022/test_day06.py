from day06 import Tuning

datastreams = [
  { 'datastream': 'mjqjpqmgbljsphdztnvjfqwrcgsmlb', 'position': 7, 'message': 19 },
  { 'datastream': 'bvwbjplbgvbhsrlpgdmjqwftvncz', 'position': 5, 'message': 23 },
  { 'datastream': 'nppdvjthqldpwncqszvftbrmjlhg', 'position': 6, 'message': 23 },
  { 'datastream': 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg', 'position': 10, 'message': 29 },
  { 'datastream': 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw', 'position': 11, 'message': 26 }
]

def test_start_of_packet():
  for pair in datastreams:
    assert Tuning.start_of_packet(pair['datastream']) == pair['position']

def test_start_of_message():
  for pair in datastreams:
    assert Tuning.start_of_packet(pair['datastream'], marker_count=14) == pair['message']
