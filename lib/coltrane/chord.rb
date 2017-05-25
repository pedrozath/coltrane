module Coltrane
  # It describe a chord
  class Chord
    attr_reader :root_note, :quality

    def initialize(arg)
      @root_note, @quality = case arg
        when String then note_and_quality_from_name(arg)
        when GuitarNoteSet then [arg.root_note, arg.chord_quality]
        when Array
          case arg[0]
            when String then note_and_quality_from_notes(*arg.map{|a| Note.new(a)})
            when Note then note_and_quality_from_notes(*arg)
          end
      end
    end

    def guitar_chords
      GuitarChordFinder.by_chord(self)
    end

    def guitar_notes_for_root
      root_note.guitar_notes
    end

    def name
      return '—' if root_note.nil? || quality.nil?
      "#{root_note.name}#{quality.name}"
    end

    def notes
      quality.intervals.each_with_object([]) do |interval, notes|
        notes << Note.new(root_note.number + interval)
      end
    end

    def intervals
      IntervalSequence.new(NoteSet.new(notes))
    end

    def on_guitar
      name + "\n" +
      NoteSet.new(notes).guitar_notes.render(root_note) + "\n\n"
    end

    def on_piano
      PianoRepresentation.render_intervals(notes, root_note)
    end

    def size
      notes.size
    end

    def scales
      Scale.having_chord(self.name)
    end

    def next_inversion
      Chord.new(notes.rotate(1))
    end

    def invert(n=1)
      Chord.new(notes.rotate(n))
    end

    def previous_inversion
      Chord.new(notes.rotate(-1))
    end

    protected

    def note_and_quality_from_name(chord_name)
      _, name, quality = chord_name.match(/([A-Z]#?)(.*)/).to_a
      [Note.new(name), ChordQuality.new_from_string(quality)]
    end

    def note_and_quality_from_notes(*notes)
      [notes.first, ChordQuality.new_from_notes(notes)]
    end
  end
end