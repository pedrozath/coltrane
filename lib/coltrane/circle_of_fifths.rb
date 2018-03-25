# frozen_string_literal: true

module Coltrane
  class CircleOfFifths
    attr_reader :notes

    LETTER_SEQUENCE = %w[C G D A E B F].freeze

    def initialize(start_note = Note['C'], size = Float::INFINITY)
      index  = letters.index(start_note.name[0])
      @notes = fifths(note: start_note - Interval.perfect_fifth,
                      size: size,
                      index: (index - 1) % LETTER_SEQUENCE.size)
    end

    private

    def fifths(note:, index: nil, notes: [], size:)
      return notes if size == 0
      return notes if notes.any? && note.as(letters(index)).name == notes.first.name
      fifths note: note + Interval.perfect_fifth,
             notes: notes + [note.as(letters(index))],
             index: index + 1,
             size:  size - 1
    end

    def letters(i = nil)
      i.nil? ? LETTER_SEQUENCE : LETTER_SEQUENCE[i % LETTER_SEQUENCE.size]
    end
  end
end
