# frozen_string_literal: true

module Coltrane
  module Representation
    class Piano
      class NoteSet
        extend Forwardable
        include Enumerable

        attr_reader :notes, :piano
        def_delegators :notes, :each, :root

        def initialize(note_set, piano:)
          @notes = note_set
          @piano = piano
        end

        instance_eval { alias [] new }
      end
    end
  end
end
