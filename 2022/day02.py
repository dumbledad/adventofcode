import csv
import sys
import pandas as pd

class RockPaperScissors:  
  def __init__(self, filename):
    self.elf = {
      'A': 'Rock', 
      'B': 'Paper',
      'C': 'Scissors',
    }
    self.shape_score = {
      'Rock': 1,
      'Paper': 2,
      'Scissors': 3,
    }
    self.outcome_score = {
      'win': 6,
      'draw': 3,
      'lose': 0,
    }
    self.score = 0
    with open(filename, newline='') as csv_file:
      reader = csv.reader(csv_file, delimiter=' ')
      for row in reader:
        if len(row) > 0:
          self.part2_score(row)
  
  def part2_score(self, row):
    round_outcome = {
      'X': 'lose', 
      'Y': 'draw',
      'Z': 'win',
    }
    shape_choice = {
      'lose': {
        'Rock': 'Scissors',
        'Paper': 'Rock',
        'Scissors': 'Paper',
      },
      'draw': {
        'Rock': 'Rock',
        'Paper': 'Paper',
        'Scissors': 'Scissors',
      },
      'win': {
        'Rock': 'Paper',
        'Paper': 'Scissors',
        'Scissors': 'Rock',
      },
    }
    elf_shape = self.elf[row[0]]
    my_shape = shape_choice[round_outcome[row[1]]][elf_shape]
    self.score += self.shape_score[my_shape]
    self.score += self.outcome_score[round_outcome[row[1]]]
    
  def part1_score(self, row):
    me = {
      'X': 'Rock', 
      'Y': 'Paper',
      'Z': 'Scissors',
    }
    outcome = {
      'Rock': {
        'Rock': 'draw',
        'Paper': 'lose',
        'Scissors': 'win',
      },
      'Paper': {
        'Rock': 'win',
        'Paper': 'draw',
        'Scissors': 'lose',
      },
      'Scissors': {
        'Rock': 'lose',
        'Paper': 'win',
        'Scissors': 'draw',
      },
    }
    elf_shape = self.elf[row[0]]
    my_shape = me[row[1]]
    round_outcome = outcome[my_shape][elf_shape]
    self.score += self.shape_score[my_shape]
    self.score += self.outcome_score[round_outcome]
   
def main(filename):
  game = RockPaperScissors(filename)
  print(f'My score is {game.score}')

if __name__ == "__main__":
  # Call `python day_n.py <csv_file>`
  main(sys.argv[1])
  