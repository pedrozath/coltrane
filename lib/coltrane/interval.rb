module Coltrane
  # It describes a interval between 2 pitches
  class Interval
    attr_reader :semitones

    NAMES = [
      '1P',
      '2m',
      '2M',
      '3m',
      '3M',
      '4P',
      '4A',
      '5P',
      '6m',
      '6M',
      '7m',
      '7M'
    ].freeze

    def initialize(arg)
      @semitones = (case arg
                     when Interval then arg.semitones
                     when String   then NAMES.index(arg)
                     when Numeric  then arg
                   end) % 12
    end

    def name
      NAMES[semitones]
    end

    def +(x)
      case x
      when Numeric then Interval.new(semitones + x)
      when Interval then Interval.new(semitones + x.semitones)
      end
    end

  end
end