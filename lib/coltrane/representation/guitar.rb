# frozen_string_literal: true
require 'coltrane/representation/guitar/chord'
require 'coltrane/representation/guitar/note'
require 'coltrane/representation/guitar/note_set'
require 'coltrane/representation/guitar/string'

module Coltrane
  module Representation
    class Guitar
      # A base class for operations involving Guitars
      attr_reader :strings, :tuning, :frets, :special_frets

      def self.find_chords(target_chord)
        unless target_chord.is_a?(Theory::Chord)
          target_chord = Theory::Chord.new(name: target_chord)
        end

        Guitar::Chord.find(target_chord, guitar: new)
      end

      def self.find_notes(notes)
        Guitar::NoteSet.new(notes, guitar: new)
      end

      def self.find_chord_by_notation(chord_notation)
        Guitar::Chord.find_by_notation(new, chord_notation)
      end

      def initialize(tuning: nil, frets: nil, special_frets: nil)
        @tuning        = tuning        || %w[E2 A2 D3 G3 B3 E4]
        @special_frets = special_frets || [3, 5, 7, 9, 12, 15, 17, 19]
        @frets         = frets         || 23

        @strings = @tuning.map do |p|
          String.new(Theory::Pitch[p], guitar: self)
        end
      end
    end
  end
end
