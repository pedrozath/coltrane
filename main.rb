require 'paint'

class IntervalSequence
  def initialize(*intervals)
    @intervals = intervals
    @number_of_frets = 24
    sum = @intervals.reduce(:+)
    sum < 12 && @intervals << 12 - sum
  end

  def to_s
    @intervals.to_s
  end

  def to_frets(offset=0)
    frets = [-offset]
    i = 0
    while(frets.last < @number_of_frets) do
      frets << frets.last + @intervals[i % @intervals.length]
      i += 1
    end
    frets
  end

end

class GuitarScale
  def initialize(interval_sequence)
    @interval_sequence = interval_sequence
  end

  def string_offsets
    [0,5,10,15,19,24]
  end

  def print
    puts render_strings
  end

  def render_strings
    string_offsets.reverse.map do |offset|
      render_string(offset)
    end.join("\n")
  end

  def render_string(string_offset)
    frets = @interval_sequence.to_frets(string_offset)
    output = 24.times.map do |x|
      render_fret frets.include?(x)
    end.join(' ')
  end

  def render_fret(status)
    status ? Paint['•', :red] : Paint['—', :black]
  end

end

def get_user_input(message)
  puts message
  gets
end

def get_intervals_from_user
  get_user_input('Please type intervals divided by commas (,)')
    .delete("\n").split(',').map(&:to_i)
end

def main
  GuitarScale.new(
    IntervalSequence.new(*get_intervals_from_user)
  ).print
  main
end

main