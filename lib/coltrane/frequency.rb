# frozen_string_literal: true

module Coltrane
  class Frequency
    attr_reader :frequency

    def initialize(frequency)
      @frequency = frequency.to_f
    end

    class << self
      alias [] new
    end

    def to_s
      "#{frequency}hz"
    end

    def to_f
      frequency
    end

    def octave(n)
      frequency * 2**n
    end

    def ==(other)
      frequency == (other.is_a?(Frequency) ? other.frequency : other)
    end

    def octave_up(n = 1)
      octave(n)
    end

    def octave_down(n = 1)
      octave(-n)
    end

    def /(other)
      case other
      when Frequency then Interval[1200 * Math.log2(frequency / other.frequency)]
      when Numeric then Frequency[frequency / other]
      end
    end

    def method_missing(method, *args)
      Frequency[frequency.send(method, args[0].to_f)]
    end
  end
end
