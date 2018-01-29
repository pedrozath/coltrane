# frozen_string_literal: true

module Coltrane
  # It describes a musical note, independent of octave

  class Note
    include Multiton

    attr_reader :name, :number
    alias id number

    NOTES = {
      'C'  => 0,
      'C#' => 1,
      'Db' => 1,
      'D'  => 2,
      'D#' => 3,
      'Eb' => 3,
      'E'  => 4,
      'F'  => 5,
      'F#' => 6,
      'Gb' => 6,
      'G'  => 7,
      'G#' => 8,
      'Ab' => 8,
      'A'  => 9,
      'A#' => 10,
      'Bb' => 10,
      'B'  => 11
    }.freeze

    def initialize(name)
      @name = name
      @number = NOTES[name]
    end

    private_class_method :new

    def self.[](arg)
      name =
        case arg
        when Note then return arg
        when String then find_note(arg)
        when Numeric then NOTES.key(arg % 12)
        else
          raise InvalidNote, "Wrong type: #{arg.class}"
        end

      new(name) || (raise InvalidNote, arg.to_s)
    end

    def self.all
      %w[C C# D D# E F F# G G# A A# B].map { |n| Note[n] }
    end

    def self.find_note(str)
      NOTES.each { |k, _v| return k if str.casecmp?(k) }
      nil
    end

    def pretty_name
      @name.tr('b', "\u266D").tr('#', "\u266F")
    end

    alias to_s name

    def accident?
      [1, 3, 6, 8, 10].include?(number)
    end

    def +(n)
      case n
      when Interval then Note[number + n.semitones]
      when Numeric  then Note[number + n]
      when Note     then Chord.new(number + n.number)
      end
    end

    def -(n)
      case n
      when Numeric then Note.new(n - number)
      when Note    then Interval.new(n.number - number)
      end
    end

    def interval_to(note_name)
      Note[note_name] - self
    end
  end
end
