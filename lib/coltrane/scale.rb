class Scale
  extend ClassicScales
  attr_reader :interval_sequence, :tone

  def initialize(*interval_steps, tone: 'C', mode: 1)
    @tone = Note.new(tone)
    intervals = interval_steps.rotate(mode-1).reduce([0]) do |intervals, step|
      intervals << (intervals.last + step)
    end

    @interval_sequence = IntervalSequence.new(intervals)
  end

  def [](degree)
    if degree < 1
      raise 'Wrong degree! Use music convention for requesting degrees'
    end

    tone + interval_sequence[(degree-1) % (size)].number
  end

  def degrees
    (1..size)
  end

  def degree_of_chord(chord)
    if chords(chord.size).map(&:name).include?(chord.name)
      degree_of_note(chord.root_note)
    end
  end

  def degree_of_note(note)
    notes.map(&:name).index(note.name)&.+1
  end

  def notes
    degrees.map { |d| self[d] }
  end

  def interval(i)
    interval_sequence[(i-1) % size]
  end

  def size
    interval_sequence.all.count - 1
  end

  def tertians
    degrees.reduce([]) do |chords, degree|
      intervals = IntervalSequence.new(3.times.map { |i| interval(degree+(i*2)) })
      intervals = intervals.shift(-intervals.numbers[0])
      chord_name = "#{self[degree].name}#{ChordQuality.new(intervals).name}"
      chords << Chord.new(chord_name)
    end
  end

  def sevenths
    degrees.reduce([]) do |chords, degree|
      intervals = IntervalSequence.new(4.times.map { |i| interval(degree+(i*2)) })
      intervals = intervals.shift(-intervals.numbers[0])
      chord_name = "#{self[degree].name}#{ChordQuality.new(intervals).name}"
      chords << Chord.new(chord_name)
    end
  end

  def on_guitar
    NoteSet.new(notes).guitar_notes.render
  end

  def intervals_on_guitar
    NoteSet.new(notes).guitar_notes.render(tone)
  end

  def degrees_on_guitar
    GuitarRepresentation.render_degrees(NoteSet.new(notes).guitar_notes, self)
  end

  def intervals_on_piano
    PianoRepresentation.render_intervals(notes, tone)
  end

  def on_piano
    intervals_on_piano
  end

  def chords(size)
    permutations = interval_sequence.numbers.permutation(size).map do |intervals|
      IntervalSequence.new(intervals)
    end
    permutations.uniq.map do |c|
      quality = ChordQuality.new(c.zero_it)
      unless quality.name.nil?
        Chord.new "#{(tone + c[0].number).name}#{quality.name}"
      end
    end.compact
  end
end