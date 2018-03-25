# frozen_string_literal: true

module Coltrane
  #
  # Pitch classes, and by classes here we don't mean in the sense of a ruby class
  # are all the classes of pitches (frequencies) that are in a whole number of
  # octaves apart.
  #
  # For example, C1, C2, C3 are all pitches from the C pitch class. Take a look into
  # Notes description if you somehow feel this is confuse and that it could just be
  # called as notes instead.
  #
  class PitchClass
    attr_reader :integer
    include Comparable

    NOTATION = %w[C C# D D# E F F# G G# A A# B].freeze

    def self.all_letters
      %w[C D E F G A B]
    end

    def self.all
      NOTATION.map { |n| new(n) }
    end

    def initialize(arg = nil, frequency: nil)
      @integer = case arg
                 when String then NOTATION.index(arg)
                 when Frequency then frequency_to_integer(Frequency.new(arg))
                 when Numeric then (arg % 12)
                 when nil then frequency_to_integer(Frequency.new(frequency))
                 when PitchClass then arg.integer
                 else raise(WrongArgumentsError)
                 end
    end

    def self.[](arg, frequency: nil)
      new(arg, frequency: nil)
    end

    def ==(other)
      integer == other.integer
    end

    alias eql? ==
    alias hash integer

    def true_notation
      NOTATION[integer]
    end

    def letter
      name[0]
    end

    def ascending_interval_to(other)
      Interval.new(self, (other.is_a?(PitchClass) ? other : Note.new(other)))
    end

    alias interval_to ascending_interval_to

    def descending_interval_to(other)
      Interval.new(
        self,
        (other.is_a?(PitchClass) ? other : Note.new(other)),
        ascending: false
      )
    end

    alias name true_notation

    def pretty_name
      name.tr('b', "\u266D").tr('#', "\u266F")
    end

    def accidental?
      notation.match? /#|b/
    end

    def sharp?
      notation.match? /#/
    end

    def flat?
      notation.match? /b/
    end

    alias notation true_notation
    alias to_s true_notation

    def +(other)
      case other
      when Interval   then self.class[integer + other.semitones]
      when Integer    then self.class[integer + other]
      when PitchClass then self.class[integer + other.integer]
      when Frequency  then self.class.new(frequency: frequency + other)
      end
    end

    def -(other)
      case other
      when Interval   then self.class[integer - other.semitones]
      when Integer    then self.class[integer - other]
      when PitchClass then Interval.new(self, other)
      when Frequency  then self.class.new(frequency: frequency - other)
      end
    end

    def <=>(other)
      integer <=> other.integer
    end

    def fundamental_frequency
      @fundamental_frequency ||=
        Frequency[
          Coltrane.base_tuning *
          (2**((integer - Coltrane::BASE_PITCH_INTEGER.to_f) / 12))
        ]
    end

    alias frequency fundamental_frequency

    def self.size
      NOTATION.size
    end

    def size
      self.class.size
    end

    def enharmonic?(other)
      case other
      when String then integer == Note[other].integer
      when Note then integer == other.integer
      end
    end

    private

    def frequency_to_integer(f)
      begin
        (Coltrane::BASE_PITCH_INTEGER +
          size * Math.log(f.to_f / Coltrane.base_tuning.to_f, 2)) % size
      end.round
    end
  end
end
