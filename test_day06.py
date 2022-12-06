from day06 import Tuning

datastreams = [
  { 'datastream': 'mjqjpqmgbljsphdztnvjfqwrcgsmlb', 'position': 7 },
  { 'datastream': 'bvwbjplbgvbhsrlpgdmjqwftvncz', 'position': 5 },
  { 'datastream': 'nppdvjthqldpwncqszvftbrmjlhg', 'position': 6 },
  { 'datastream': 'nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg', 'position': 10 },
  { 'datastream': 'zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw', 'position': 11 }
]

def test_start_of_packet():
  for pair in datastreams:
    assert Tuning.start_of_packet(pair['datastream']) == pair['position']
