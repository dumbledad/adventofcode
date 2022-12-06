class Tuning:
  @classmethod
  def start_of_packet(cls, datastream):
    data = list(datastream)
    for i, _ in enumerate(data):
      if i > 3 and len(set(data[i-4:i])) == 4:
        return i
    return -1
