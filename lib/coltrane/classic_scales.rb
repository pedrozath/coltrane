class GuitarScale
  def initialize(interval_sequence)
    @interval_sequence = interval_sequence
  end

  def string_offsets
    [0, 5, 10, 15, 19, 24]
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
    output = Array.new(24) do |x|
      render_fret frets.include?(x)
    end.join(' ')
  end

  def render_fret(status)
    status ? Paint['•', :red] : Paint['—', :black]
  end
end
