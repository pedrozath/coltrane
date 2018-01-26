module Coltrane
  # It describe a chord
  class Chord < NoteSet
    attr_reader :root_note, :quality, :notes

    def initialize(notes: nil, root_note: nil, quality: nil, name: nil)
      if !notes.nil?
        notes      = NoteSet.new(*notes) if notes.is_a?(Array)
        @notes     = notes
        @root_note = notes.first
        @quality   = ChordQuality.new(notes: notes)
      elsif !root_note.nil? && !quality.nil?
        @notes     = quality.notes_for(root_note)
        @root_note = root_note
        @quality   = quality
      elsif !name.nil?
        @root_note, @quality, @notes = parse_from_name(name)
      else
        raise 'Wrong keywords. Expected setup is:'\
          '[notes:] || [root_note:,quality:] || [name:]'
      end
    end

    # def new_from_root_note_and_quality
    #   quality.intervals.reduce([]) do |memo, intervals|
    #     memo + [Note.new(root_note.number + interval)]
    #   end
    # end

    # def initialize(arg)
    #   @root_note, @quality = case arg
    #     when String
    #       note_and_quality_from_name(arg)
    #     when GuitarNoteSet then [arg.root_note, arg.chord_quality]
    #     when Array
    #       if arg.empty?
    #         @notes = []
    #       else
    #         case arg[0]
    #           when String then note_and_quality_from_notes(*arg.map{|a| Note.new(a)})
    #           when Note then note_and_quality_from_notes(*arg)
    #         end
    #       end
    #   end
    # end

    def guitar_chords
      GuitarChordFinder.by_chord(self)
    end

    def guitar_notes_for_root
      root_note.guitar_notes
    end

    def name
      return @notes.names.join('/') if !named?
      "#{root_note.name}#{quality.name}"
    end

    def named?
      notes.size >= 3 &&
      !root_note.nil? &&
      !quality&.name.nil?
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

    def parse_from_name(name)
      _, name, quality_name = name.match(/([A-Z]#?)(.*)/).to_a
      root    = Note.new(name)
      quality = ChordQuality.new(name: quality_name)
      notes   = quality.notes_for(root)
      [root, quality, notes]
    end

    # def note_and_quality_from_notes(*notes)
    #   @notes = notes
    #   [notes.first, ChordQuality.new_from_notes(notes)]
    # end
  end
end