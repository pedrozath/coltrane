# frozen_string_literal: true

module ColtraneInstruments
  module Guitar
    DEFAULT_TUNING = %w[E4 A5 D5 G5 B5 E6]
    DEFAULT_FRETS = 23
    # A base class for operations involving Guitars
    class Base
      attr_reader :strings, :frets

      def self.find_chords(target_chord)
        unless target_chord.is_a?(Chord)
          target_chord = Coltrane::Chord.new(name: target_chord)
        end

        ColtraneInstruments::Guitar::Chord.new(target_chord, guitar: new)
                                          .fetch_descendant_chords
      end

      def initialize(tuning = DEFAULT_TUNING, frets = DEFAULT_FRETS)
        @strings = tuning.map do |p|
          String.new(Coltrane::Pitch[p], guitar: self)
        end

        @frets = frets
      end
    end
  end
end
