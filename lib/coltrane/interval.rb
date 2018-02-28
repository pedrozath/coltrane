# frozen_string_literal: true

module Coltrane
  # Interval describe the logarithmic distance between 2 frequencies.
  # It's measured in cents.
  class Interval
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

    def ascending?
      cents < 0
    end

    def descending?
      cents > 0
    end

    def ==(other)
      cents == other.cents
    end

    alias eql? ==
    alias hash cents

    def +(other)
      case other
      when Numeric then Interval[cents + other]
      when Interval then Interval[cents + other.cents]
      end
    end

    def -(other)
      case other
      when Numeric then Interval[cents - other]
      when Interval then Interval[cents - other.cents]
      end
    end
  end
end
