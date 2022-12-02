import csv
import sys
import pandas as pd

class RockPaperScissors:  
  def __init__(self, filename):
    elf = {
      'A': 'Rock', 
      'B': 'Paper',
      'C': 'Scissors',
    }
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
    shape_score = {
      'Rock': 1,
      'Paper': 2,
      'Scissors': 3,
    }
    outcome_score = {
      'win': 6,
      'draw': 3,
      'lose': 0,
    }
    self.my_score = 0
    self.elf_score = 0
    with open(filename, newline='') as csv_file:
      reader = csv.reader(csv_file, delimiter=' ')
      for row in reader:
        if len(row) > 0:
          my_shape = elf[row[1]]
          elf_shape = me[row[0]]
          round_outcome = outcome[elf_shape][my_shape]
          score += shape_score[my_shape]
          score += outcome_score[round_outcome]
          

def main(filename):
  game = RockPaperScissors(filename)
  print(f'PMy score is {game.score}')

if __name__ == "__main__":
  # Call `python day_n.py <csv_file>`
  main(sys.argv[1])
  