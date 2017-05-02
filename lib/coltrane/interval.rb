module Coltrane
  # It describes a interval between 2 pitches
  class Interval
    attr_reader :number

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
      '8P',
      '9m',
      '9M',
      '10m',
      '10M',
      '11P',
      '12P',
      '13m',
      '13M',
      '14m',
      '14M',
      '15P',
      '15A'
    ].freeze

    def initialize(number)
      @number = number
    end

    def name
      NAMES[number]
    end
  end
end