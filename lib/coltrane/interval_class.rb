module Coltrane
=begin
Interval class here is not related to the Object Oriented Programming context
but to the fact that there is a class of intervals that can all be categorized
as having the same quality.

This class in specific still takes into account the order of intervals.
C to D is a major second, but D to C is a minor seventh.
=end
  class IntervalClass < Interval
    INTERVALS = %w[P1 m2 M2 m3 M3 P4 A4 P5 m6 M6 m7 M7 ]

    def self.split(interval)
      interval.scan(/(\w)(\d\d?)/)[0]
    end

    def self.full_name(interval)
      q,n = split(interval)
      "#{q.interval_quality} #{n.to_i.interval_name}"
    end

    # Create full names and methods such as major_third? minor_seventh?
    # TODO: It's a mess and it really needs a refactor someday
    NAMES = INTERVALS.each_with_index.reduce({}) do |memo, (interval, index)|
      memo[interval] ||= []
      2.times do |o|
        q,i = split(interval)
        num = o * 7 + i.to_i
        prev_q = split(INTERVALS[(index - 1) % 12])[0]
        next_q = split(INTERVALS[(index + 1) % 12])[0]
        memo[interval] << full_name("#{q}#{num}")
        memo[interval] << full_name("d#{(num - 1 + 1) % 14 + 1}") if next_q.match? /m|P/
        next if q == 'A'
        memo[interval] << full_name("A#{(num - 1 - 1) % 14 + 1}") if prev_q.match? /M|P/
      end
      memo
    end

    ALL_FULL_NAMES = NAMES.values.flatten

    NAMES.each do |interval_name, full_names|
      full_names.each do |the_full_name|
        define_method "#{the_full_name.underscore}?" do
          name == interval_name
        end
        IntervalClass.class.define_method "#{the_full_name.underscore}" do
          IntervalClass.new(interval_name)
        end
      end
    end

    def initialize(arg)
      super case arg
            when Interval then arg.semitones
            when String
              INTERVALS.index(arg) || self.class.interval_by_full_name(arg)
            when Numeric then arg
            else raise WrongArgumentsError
            end % 12 * 100
    end

    def self.[](semis)
      new semis
    end

    def all_full_names
      self.class.all_full_names
    end

    def self.all_full_names
      ALL_FULL_NAMES
    end

    def ==(other)
      (cents % 12) == (other.cents % 12)
    end

    def name
      INTERVALS[semitones % 12]
    end

    def full_name
      self.class.full_name(name)
    end

    def full_names
      NAMES[name]
    end

    def +(other)
      IntervalClass[semitones + other]
    end

    def -(other)
      IntervalClass[semitones - other]
    end

    private

    def self.interval_by_full_name(arg)
      NAMES.invert.each do |full_names, interval_name|
        if full_names.include?(arg)
          return INTERVALS.index(interval_name)
        end
      end
      raise IntervalNotFoundError, arg
    end
  end
end