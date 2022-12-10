from day03 import Rucksack, Rucksacks

def test_rucksacks_team_badge():
  rucksack1 = Rucksack('abcdec')
  rucksack2 = Rucksack('efghig')
  rucksack3 = Rucksack('jklmle')
  team_badge = Rucksacks.team_badge([rucksack1, rucksack2, rucksack3])
  assert team_badge == 'e'

def test_rucksacks_badges():
  rucksacks = Rucksacks('day03-test.csv')
  badges = rucksacks.get_badges()
  assert badges == ['r', 'Z']

def test_rucksacks_badge_priority():
  rucksacks = Rucksacks('day03-test.csv')
  assert rucksacks.badge_priority() == 70
