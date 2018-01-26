module Coltrane
  class Scale
    extend ClassicScales
    attr_reader :interval_sequence, :tone

    def initialize(*distances, tone: 'C', mode: 1)
      @tone              = Note.new(tone)
      distances          = distances.rotate(mode-1)
      @interval_sequence = IntervalSequence.new(distances: distances)
    end

    def self.new_by_notes(*notes)
      return nil if notes.size < 5
      is = NoteSet.new(notes).interval_sequence.numbers.sort
      self.new(*is, tone: notes.first)
    end

    def name
      is = self.interval_sequence.distances
      (0...is.size).each do |i|
        if (scale_name = Coltrane::ClassicScales::SCALES.key(is.rotate(i)))
          return scale_name
        end
      end

      nil
    end

    def degree(d)
      if d < 1 || d > size
        raise "Provide a number between 1 and #{degrees}"
      end

      tone + interval_sequence[d - 1].semitones
    end

    alias_method :[], :degree

    def degrees
      (1..size)
    end

    def degree_of_chord(chord)
      if chords(chord.size).map(&:name).include?(chord.name)
        degree_of_note(chord.root_note)
      end
    end

    def degree_of_note(note)
      note = notes.map(&:name).index(note.name)
      return note + 1 unless note.nil?
    end

    def include_notes?(*arg_notes)
      arg_notes.each_with_object([]) do |n, memo|
        memo << n if notes.map(&:name).include?(n.name)
      end
    end

    def notes
      @notes ||= degrees.map { |d| self[d] }
    end

    def interval(i)
      interval_sequence[(i-1) % size]
    end

    def size
      interval_sequence.size
    end

    def tertians(n=3)
      degrees.size.times.reduce([]) do |memo, d|
        ns = NoteSet.new(*n.times.map { |i| notes[(d + (i*2)) % (size)]})
        chord = Chord.new(notes: ns)
        chord.named? ? memo + [chord] : memo
      end
    end

    def triads
      tertians(3)
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

    def on_flute
      NoteSet.new(notes).guitar_notes.render
    end

    def intervals_on_guitar
      NoteSet.new(notes).guitar_notes.render(tone)
    end

    def degrees_on_guitar
      GuitarRepresentation.render_degrees(NoteSet.new(notes).guitar_notes, self)
    end

    def notes_on_guitar
      GuitarRepresentation.render_notes(NoteSet.new(notes).guitar_notes, self)
    end

    def intervals_on_piano
      PianoRepresentation.render_intervals(notes, tone)
    end

    def on_piano
      intervals_on_piano
    end

    def progression(*degrees)
      Progression.new(self, degrees)
    end

    def chords(size)
      included_names = []
      notes.permutation(size).reduce([]) do |memo, ns|
        chord = Chord.new(notes: ns)
        if chord.named? && !included_names.include?(chord.name)
          included_names << chord.name
          memo + [chord]
        else
          memo
        end
      end
    end
  end
end