module Coltrane
  module Commands
    class Chords < Command
      attr_reader :chord, :flavor, :on, :preface

      def initialize(chord = nil,
                     flavor: :notes,
                     on: :text,
                     notes: nil,
                     preface: nil,
                     **options)
        if chord
          @chord = chord.is_a?(Theory::Chord) ? chord : Theory::Chord.new(name: chord)
        elsif notes
          @chord = Theory::Chord.new(notes: notes&.split('-'))
        else
          raise 'Provide chord names or notes. Ex: coltrane chords Cm7-Db7, ' \
                'or coltrane chords --notes C-E-G'
        end

        @flavor  = flavor.to_sym
        @preface = preface || @chord.name
        @on      = on.to_sym
      end

      def representation
        return on_model if on == :text
        { preface => on_model }
      end

      def on_model
        case on
        when :text              then chord
        when :guitar            then Representation::Guitar.find_chords(chord).first(6)
        when :ukulele, :ukelele then Representation::Ukulele.find_chords(chord).first(6)
        when :bass              then Representation::Bass.find_chords(chord).first(6)
        when :piano             then Representation::Piano.find_notes(chord.notes)
        end
      end

      def layout_horizontal?
        [:guitar, :ukulele, :ukelele, :bass, :piano].include?(on)
      end

      def renderer_options
        [
          { flavor: flavor },
          (
            {
              layout: :horizontal,
              per_row: 6,
            } if layout_horizontal?
          )
        ]
        .compact
        .reduce({}, :merge)
      end

      def self.mercenary_init(program)
        program.command(:chords) do |c|
          c.alias(:chord)
          c.syntax 'chords [<chord-name>] [--on <instrument>]'
          c.description 'Shows the given chord. Ex: coltrane chord Cmaj7 --on piano'
          c.alias(:chords)
          c.option :notes, '--notes C-D-E', 'finds chords with those notes, ' \
                           'provided they are separated by dashes'

          add_shared_option(:flavor, c)
          add_shared_option(:on, c)
          c.action { |(chords), **options|
            (chords&.split('-') || [nil]).each { |chord| new(chord, **options).render }
          }
        end
      end
    end
  end
end