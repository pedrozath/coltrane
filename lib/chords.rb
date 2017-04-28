class Chords
  def initialize(chord_name=nil)
    # @frets = frets
  end

  def to_s
    # chord_name(frets)
  end

  def intervals

  end

  def chord_name
    return @chord_name unless @chord_name.nil?
    puts 'Cmaj7'
  end
end

def main
  puts 'Enter the chord name (ex: Maj7)'
  puts Chords.new(gets).intervals
  main
end

main