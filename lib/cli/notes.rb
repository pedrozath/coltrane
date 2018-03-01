# frozen_string_literal: true

module Coltrane
  module Cli
    # Interfaces notes outputting functionality with the lib
    class Notes
      def initialize(notes, desc: nil)
        @desc   = desc || 'The notes you supplied:'
        notes   = Coltrane::NoteSet.new(notes)
        @representation = Representation.build(notes)
        render
        # notes.each {|n| ColtraneSynth::Base.play(n, 0.1) } if Cli.config.sound
      end

      def render
        puts "\n" + [@desc, @representation.render].join("\n" * 2)
      end
    end
  end
end
