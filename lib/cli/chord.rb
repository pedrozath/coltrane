# frozen_string_literal: true

module Coltrane
  module Cli
    # Interfaces chord functionality with the lib
    class Chord
      def initialize(*chords, notes: nil)
        Cli.config do |c|
          if c.on == :guitar
            c.on = :guitar_chords
          elsif c.on == :guitar_arm
            c.on = :guitar
          end
        end

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
          desc = "#{chord.name} chord:"
          Coltrane::Cli::Notes.new chord.notes, desc: desc
          ColtraneSynth::Base.play(chord, 1) if Cli.config.sound
        end
      end
    end
  end
end

# rubocop:enable Metrics/MethodLength
