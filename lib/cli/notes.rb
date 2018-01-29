# frozen_string_literal: true

module Coltrane
  module Cli
    class Notes
      def initialize(notes, on: 'text', desc: 'The notes you supplied:', flavor: 'notes')
        @desc   = desc
        flavor  = flavor.underscore.to_sym
        on      = on.to_sym
        notes   = Coltrane::NoteSet.new(notes)
        @representation = Representation.build(on, notes, flavor)
        render
      end

      def render
        puts "\n" + [@desc, @representation.render].join("\n" * 2)
      end
    end
  end
end
