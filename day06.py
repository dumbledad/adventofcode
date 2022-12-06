class Tuning:
  @classmethod
  def start_of_packet(cls, datastream, marker_count=4):
    data = list(datastream)
    for i, _ in enumerate(data):
      if i > marker_count - 1 and len(set(data[i-marker_count:i])) == marker_count:
        return i
    return -1


def main():
  print(Tuning.start_of_packet(open('day06.txt').read()))

if __name__ == "__main__":
  main()