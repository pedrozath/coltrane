# frozen_string_literal: true

module Coltrane
  # Interval class here is not related to the Object Oriented Programming context
  # but to the fact that there is a class of intervals that can all be categorized
  # as having the same quality.
  #
  # This class in specific still takes into account the order of intervals.
  # C to D is a major second, but D to C is a minor seventh.
  class IntervalClass < FrequencyInterval
    QUALITY_SEQUENCE = [
      %w[P],
      %w[m M],
      %w[m M],
      %w[P A],
      %w[P],
      %w[m M],
      %w[m M]
    ].freeze

    ALTERATIONS = {
      'A' => +1,
      'd' => -1
    }.freeze

    SINGLE_DISTANCES_NAMES = %w[
      Unison
      Second
      Third
      Fourth
      Fifth
      Sixth
      Seventh
    ].freeze

    COMPOUND_DISTANCES_NAMES = [
      'Octave',
      'Ninth',
      'Tenth',
      'Eleventh',
      'Twelfth',
      'Thirteenth',
      'Fourteenth',
      'Double Octave'
    ].freeze

    DISTANCES_NAMES = (SINGLE_DISTANCES_NAMES + COMPOUND_DISTANCES_NAMES).freeze

    QUALITY_NAMES = {
      'P' => 'Perfect',
      'm' => 'Minor',
      'M' => 'Major',
      'A' => 'Augmented',
      'd' => 'Diminished'
    }.freeze

    class << self
      def distances_names
        DISTANCES_NAMES
      end

      def distance_name(n)
        DISTANCES_NAMES[n - 1]
      end

      def quality_name(q)
        QUALITY_NAMES[q]
      end

      def names
        @names ||= begin
          SINGLE_DISTANCES_NAMES.each_with_index.reduce([]) do |i_names, (_d, i)|
            i_names + QUALITY_SEQUENCE[i % 7].reduce([]) do |qs, q|
              qs + ["#{q}#{i + 1}"]
            end
          end
        end
      end

      def compound_names
        @compound_names ||= all.map(&:compound_name)
      end

      def all_names_including_compound
        @all_names_including_compound ||= names + compound_names
      end

      def full_names
        @full_names ||= names.map { |n| expand_name(n) }
      end

      def all
        @all ||= names.map { |n| IntervalClass[n] }
      end

      def full_names_including_compound
        @full_names_including_compound ||=
          all_names_including_compound.map { |n| expand_name(n) }
      end

      def split(interval)
        interval.scan(/(\w)(\d\d?)/)[0]
      end

      def expand_name(name)
        q, n = split(name)
        (
          case name
          when /AA|dd/ then 'Double '
          when /AAA|ddd/ then 'Triple '
          else ''
          end
        ) + "#{quality_name(q)} #{distance_name(n.to_i)}"
      end
    end

    def initialize(arg)
      super case arg
            when FrequencyInterval then arg.semitones
            when String
              self.class.names.index(arg) ||
                self.class.full_names.index(arg) ||
                self.class.all_names_including_compound.index(arg) ||
                self.class.full_names_including_compound.index(arg)
            when Numeric then arg
            else
              raise WrongArgumentsError,
                    'Provide: [interval] || [name] || [number of semitones]'
            end % 12 * 100
    end

    instance_eval { alias [] new }

    def interval
      Interval.new(letter_distance: distance, semitones: semitones)
    end

    def compound_interval
      Interval.new(
        letter_distance: distance,
        semitones: semitones,
        compound: true
      )
    end

    alias compound compound_interval

    def ==(other)
      return false unless other.is_a? FrequencyInterval
      (semitones % 12) == (other.semitones % 12)
    end

    def alteration
      name.chars.reduce(0) { |a, s| a + (ALTERATIONS[s] || 0) }
    end

    def ascending
      self.class[semitones.abs]
    end

    def descending
      self.class[-semitones.abs]
    end

    def inversion
      self.class[-semitones % 12]
    end

    def full_name
      self.class.expand_name(name)
    end

    def name
      self.class.names[semitones % 12]
    end

    def compound_name
      "#{quality}#{distance + 7}"
    end

    def distance
      self.class.split(name)[1].to_i
    end

    def quality
      self.class.split(name)[0]
    end

    def +(other)
      IntervalClass[semitones + other]
    end

    def -(other)
      IntervalClass[semitones - other]
    end

    def -@
      IntervalClass[-semitones]
    end

    private

    def self.interval_by_full_name(arg)
      NAMES.invert.each do |full_names, interval_name|
        return INTERVALS.index(interval_name) if full_names.include?(arg)
      end
      raise IntervalNotFoundError, arg
    end
  end
end
