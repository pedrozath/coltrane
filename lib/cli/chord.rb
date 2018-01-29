# frozen_string_literal: true

module Coltrane
  module Cli
    class Chord
      def initialize(*chords, on: :text, flavor: 'intervals', notes: nil)
        @chords =
          if !chords.empty?
            if chords[0].is_a?(String)
              chords.map { |c| Coltrane::Chord.new(name: c) }
            else
              chords
            end
          elsif !notes.nil?
            [Coltrane::Chord.new(notes: notes)]
          end

        @chords.each do |chord|
          raise ChordNotFoundError unless chord.named?
          desc = "#{chord.name} chord:"
          Coltrane::Cli::Notes.new(chord.notes, on: on, desc: desc, flavor: flavor)
        end
      end
    end
  end
end
