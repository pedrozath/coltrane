module Coltrane
  # It describe a chord
  class Chord
    attr_reader :root_note, :quality

    def initialize(arg)
      @root_note, @quality = case arg
                               when String then note_and_quality_from_name(arg)
                               when GuitarNoteSet then [arg.root_note, arg.chord_quality]
                             end
    end

    def guitar_chords
      GuitarChordFinder.by_chord(self)
    end

    def guitar_notes_for_root
      root_note.guitar_notes
    end

    def name
      "#{root_note.name}#{quality.name}"
    end

    def notes
      quality.intervals.each_with_object([]) do |interval, notes|
        notes << Note.new(root_note.number + interval)
      end
    end

    protected

    def note_and_quality_from_name(chord_name)
      _, name, quality = chord_name.match(/([A-Z]#?)(.*)/).to_a
      [Note.new(name), ChordQuality.new_from_string(quality)]
    end
  end
end