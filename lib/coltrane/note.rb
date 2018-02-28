# frozen_string_literal: true

module Coltrane
=begin
Notes are different ways of calling pitch classes. In the context of equal
tempered scales, they're more like a conceptual subject for
matters of convention than an actual thing.

Take for example A# and Bb. Those are different notes. Nevertheless, in the
context of equal tempered scales they represent pretty much the same frequency.

The theory of notes have changed too much in the course of time, which lead us
with a lot of conventions and strategies when dealing with music. That's what
this class is for.
=end
  class Note < PitchClass
    attr_accessor :alteration

    ALTERATIONS = {
      'b' => -1,
      '#' => 1
    }

    def initialize(arg)
      note_name = case arg
                  when String then arg
                  when PitchClass then arg.true_notation
                  when Numeric, Frequency then PitchClass.new(arg).true_notation
                  else raise(WrongArgumentsError, arg)
                  end

      chars  = note_name.chars
      letter = chars.shift
      raise InvalidNoteError, arg unless ('A'..'G').include?(letter)
      @alteration = chars.reduce(0) do |alt, symbol|
        raise InvalidNoteError, arg unless ALTERATIONS.include?(symbol)
        alt + ALTERATIONS[symbol]
      end
      super((PitchClass[letter].integer + @alteration) % PitchClass.size)
    end

    def self.[](arg)
      new(arg)
    end

    def name
      "#{base_pitch_class.to_s}#{accidents}".gsub(/#b|b#/, '')
    end

    def base_pitch_class
      PitchClass[integer - alteration]
    end

    def alteration=(a)
      @alteration = a unless PitchClass[integer - a].accidental?
    end

    def alter(x)
      Note.new(name).tap {|n| n.alteration = x}
    end

    def accidents
      (@alteration > 0 ? '#' : 'b') * @alteration.abs
    end

    def interval_to(note_name)
      Note[note_name] - self
    end
  end
end
