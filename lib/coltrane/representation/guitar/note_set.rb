# frozen_string_literal: true

module Coltrane
  module Representation
    class Guitar
      class NoteSet
        extend Forwardable
        include Enumerable

        attr_reader :notes, :guitar
        def_delegators :notes, :each, :root

        def initialize(note_set, guitar:)
          @notes  = note_set
          @guitar = guitar
        end

        instance_eval { alias [] new }

        def results
          @strings ||= begin
            guitar.strings.map do |string|
              {
                pitch: string.pitch,
                notes: notes.map { |note| string.find(note) }
              }
            end
          end
        end

        alias strings results
      end
    end
  end
end
