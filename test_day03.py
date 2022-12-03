import pytest
from day03 import Rucksack, Rucksacks

def test_rucksacks_team_badge():
  r1 = Rucksack('abcdec')
  r2 = Rucksack('efghig')
  r3 = Rucksack('jklmle')
  team_badge = Rucksacks.team_badge([r1, r2, r3])
  assert team_badge == 'e'