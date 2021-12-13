# frozen_string_literal: true

# https://adventofcode.com/2021/day/12
class Caves
  attr_accessor :links, :revisit_one_small

  def initialize(input_data_filename, revisit: false)
    @revisit_one_small = revisit
    @links = Hash.new { [] }
    File.readlines(input_data_filename).map(&:chomp).map { |l| l.split('-') }.each { |p| add_link(p) }
    paths
  end

  def add_link(pair)
    @links[pair[0]] = (@links[pair[0]] << pair[1]).uniq
    @links[pair[1]] = (@links[pair[1]] << pair[0]).uniq
  end

  def paths
    @paths = @links['start'].map { |c| ['start', c] }
    added = @paths.length
    added = add_to_paths while added.positive?
  end

  def num_complete_paths
    @paths.count { |p| p[-1] == 'end' }
  end

  def add_to_paths
    added = []
    @paths.each do |p|
      @links[p[-1]].each { |l| add_if_valid(p, l, added) }
    end
    @paths = added + @paths.select { |p| p[-1] == 'end' }
    puts "#{@paths.max_by(&:length).join('-')} longest of #{@paths.length} paths"
    added.length
  end

  def add_if_valid(path, linked, added)
    return unless valid?(path, linked)

    extended_path = path.clone << linked
    added << extended_path unless (@paths + added).include? extended_path
  end

  def valid?(path, addition)
    return false if path[-1] == 'end' || addition == 'start'
    return false unless valid_revisit?(path, addition)

    true
  end

  def valid_revisit?(path, addition)
    return true if addition == addition.upcase

    if @revisit_one_small
      return false unless revisits_at_most_one_small_cave(path, addition)
    elsif addition == addition.downcase && path.include?(addition)
      return false
    end
    true
  end

  def revisits_at_most_one_small_cave(path, addition)
    small_cave_tally = (path.clone << addition).select { |c| c == c.downcase }.tally
    return false if small_cave_tally[addition] > 2
    return false if small_cave_tally.count { |_, v| v > 1 } > 1

    true
  end
end

def report(filename, allow_repeat_one_small)
  data = Caves.new(filename, revisit: allow_repeat_one_small)
  before = Time.now
  puts "\n#{allow_repeat_one_small ? 'PART 2:' : 'PART 1:'} #{data.num_complete_paths} paths from #{filename}"
  puts "Ran in #{Time.now - before} seconds (WHY IS THIS SO WRONG?)\n\n"
end

[false, true].each do |allow|
  ['day12-input-test.txt', 'day12-input-01.txt'].each { |f| report(f, allow) }
end
