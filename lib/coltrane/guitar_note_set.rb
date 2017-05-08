module Coltrane
  class GuitarNoteSet
    attr_reader :guitar_notes

    def initialize(arg)
      arg = [arg] unless arg.class == Array
      @guitar_notes = arg.reduce([]) do |memo, arg_item|
        case arg_item
        when Hash
          if arg_item[:fret].nil?
            memo
          else
            (memo + [GuitarNote.new(arg_item)])
          end

        when GuitarNote then memo + [arg_item]
        when Pitch      then memo + guitar_notes_for_pitch(arg_item)
        when String     then memo + guitar_notes_for_pitch(Pitch.new(arg_item))
        end
      end
    end

    def guitar_notes_for_pitch(pitch)
      Guitar.strings.each_with_index.each_with_object([]) do |object, memo|
        guitar_string, index = object
        fret = guitar_string.fret_by_pitch(pitch)
        unless fret.nil?
          memo << GuitarNote.new(guitar_string_index: index, fret: fret)
        end
      end
    end

    def root_note
      lowest_pitch.note
    end

    def lowest_pitch
      pitches.sort_by(&:number).first
    end

    def pitches
      guitar_notes.collect(&:pitch)
    end

    def notes
      guitar_notes.collect(&:note)
    end

    def note_string
      notes.collect(&:name).join(' ')
    end

    def chord_quality
      ChordQuality.new_from_pitches(*pitches)
    end

    def render(*args)
      GuitarRepresentation.render(self, *args)
    end
  end
end