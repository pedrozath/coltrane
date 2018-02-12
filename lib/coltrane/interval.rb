# frozen_string_literal: true

module Coltrane
  # It describes a interval between 2 pitches
  class Interval
    include Multiton
    attr_reader :semitones

    INTERVALS = %w[
      P1
      m2
      M2
      m3
      M3
      P4
      A4
      P5
      m6
      M6
      m7
      M7
    ].freeze

    def self.split(interval)
      interval.scan(/(\w)(\d\d?)/)[0]
    end

    def self.full_name(interval)
      q,n = split(interval)
      "#{q.interval_quality} #{n.to_i.interval_name}"
    end

    # Create full names and methods such as major_third? minor_seventh?
    # TODO: It's a mess and it really needs a refactor one day
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

    def self.[](arg)
      new(case arg
          when Interval then arg.semitones
          when String   then INTERVALS.index(arg) || interval_by_full_name(arg)
          when Numeric  then arg
          end % 12)
    end

    ALL_FULL_NAMES = NAMES.values.flatten

    NAMES.each do |interval_name, full_names|
      full_names.each do |the_full_name|
        define_method "#{the_full_name.underscore}?" do
          name == interval_name
        end
        self.class.define_method "#{the_full_name.underscore}" do
          self[interval_name]
        end
      end
    end

    def initialize(semitones)
      @semitones = semitones
    end

    private_class_method :new

    def all_full_names
      ALL_FULL_NAMES
    end



    def name
      INTERVALS[semitones]
    end

    def full_name
      self.class.full_name(name)
    end

    def full_names
      NAMES[name]
    end

    def +(other)
      case other
      when Numeric then Interval[semitones + other]
      when Interval then Interval[semitones + other.semitones]
      end
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
