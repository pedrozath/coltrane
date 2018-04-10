module Coltrane
  module Commands
    class Notes < Command
      attr_reader :notes, :flavor, :on, :preface

      def initialize(notes, flavor: :notes, on: :text, preface: nil)
        raise 'Provide some notes. Ex: coltrane notes C-D-Gb' if notes.nil?
        @notes   = notes.is_a?(Theory::NoteSet) ? notes : Theory::NoteSet[*notes.split('-')]
        @flavor  = flavor.to_sym
        @preface = preface || 'Here are the notes you asked for'
        @on      = on
      end

      def representation
        { preface => on_model }
      end

      def renderer_options
        { flavor: flavor }
      end

      def on_model
        case on.to_sym
        when /custom_guitar/    then custom_guitar_notes
        when :guitar            then Representation::Guitar.find_notes(notes)
        when :ukulele, :ukelele then Representation::Ukulele.find_notes(notes)
        when :bass              then Representation::Bass.find_notes(notes)
        when :piano             then Representation::Piano.find_notes(notes)
        end
      end

      def custom_guitar_notes
        Representation::Guitar::NoteSet.new(notes, guitar: custom_guitar)
      end

      def self.mercenary_init(program)
        program.command(:notes) do |c|
          c.alias(:note)
          c.syntax 'notes <notes separated by space> [--on <instrument>]'
          c.description 'Shows the given notes.'
          add_shared_option(:voicings, c)
          add_shared_option(:flavor, c)
          add_shared_option(:on, c)
          c.action { |(notes), **options| new(notes, **options).render }
        end
      end
    end
  end
end