class Interval
  attr_reader :number

  NAMES = %w[1P 2m 2M 3m 3M 4P 4A 5P 6m 6M 7m 7M].freeze

  def initialize(number)
    @number = number
  end

  def name
    NAMES[number]
  end
end
