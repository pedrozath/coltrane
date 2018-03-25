# frozen_string_literal: true

module Coltrane
  # Interval describe the logarithmic distance between 2 frequencies.
  # It's measured in cents.
  class FrequencyInterval
    include Comparable

    attr_reader :cents

    class << self
      alias [] new
    end

    def initialize(cents)
      @cents = cents.round
    end

    def semitones
      (cents.to_f / 100).round
    end

    def ascending
      self.class[cents.abs]
    end

    def descending
      self.class[-cents.abs]
    end

    def ascending?
      cents > 0
    end

    def descending?
      cents < 0
    end

    def inversion
      self.class[(-cents.abs % 1200) * (ascending? ? +1 : -1)]
    end

    def opposite
      self.class.new(-cents)
    end

    def interval_class
      IntervalClass.new(semitones)
    end

    def ==(other)
      return false unless other.is_a? FrequencyInterval
      cents == other.cents
    end

    alias eql? ==
    alias hash cents

    def +(other)
      case other
      when Numeric then FrequencyInterval[cents + other]
      when Interval then FrequencyInterval[cents + other.cents]
      end
    end

    def -(other)
      case other
      when Numeric then FrequencyInterval[cents - other]
      when Interval then FrequencyInterval[cents - other.cents]
      end
    end

    def -@
      FrequencyInterval[-cents]
    end

    def <=>(other)
      cents <=> other.cents
    end
  end
end
