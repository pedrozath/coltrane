module Coltrane
  class Interval < IntervalClass
    attr_reader :letter_distance, :cents
    alias compound? compound

    class << self
      def all
        @all ||= super.map(&:interval)
      end

      def all_compound
        @all_compound ||= all.map(&:compound)
      end

      def all_including_compound
        @all_including_compound ||= all + all_compound
      end

      def all_augmented
        @all_augmented ||= all_including_compound.select(&:has_augmented?)
                                                 .map(&:augmented)
      end

      def all_diminished
        @all_diminished ||= all_including_compound.select(&:has_diminished?)
                                                  .map(&:diminished)
      end

      def all_including_compound_and_altered
        @all_including_compound_and_altered ||=
          all_including_compound +
          all_diminished +
          all_augmented
      end
    end

    def initialize(arg_1 = nil, arg_2 = nil, ascending: true,
                                             letter_distance: nil,
                                             semitones: nil,
                                             compound: false)
      if arg_1 && !arg_2 # assumes arg_1 is a letter
        @compound = compound
        IntervalClass[arg_1].interval.yield_self do |interval|
          @letter_distance = interval.letter_distance
          @cents = interval.cents
        end
      elsif arg_1 && arg_2 # assumes those are notes
        if ascending
          @compound = compound
          @cents =
            (arg_1.frequency / arg_2.frequency)
              .interval_class
              .cents

          @letter_distance = calculate_letter_distance arg_1.letter,
                                                       arg_2.letter,
                                                       ascending
        else
          self.class.new(arg_1, arg_2).descending.yield_self do |base_interval|
            @compound        = base_interval.compound?
            @cents           = base_interval.cents
            @letter_distance = base_interval.letter_distance
          end
        end
      elsif letter_distance && semitones
        @compound        = compound || letter_distance > 8
        @cents           = semitones * 100
        @letter_distance = letter_distance
      else
        raise WrongKeywordsError,
          '[interval_class_name]' \
          'Provide: [first_note, second_note] || ' \
          '[letter_distance:, semitones:]'
      end
    end

    def self.[](arg)
      new(arg)
    end

    def interval_class
      FrequencyInterval[cents].interval_class
    end

    def compound?
      @compound
    end

    def has_augmented?
      name.match?(%r{M|P|A})
    end

    def has_diminished?
      name.match?(%r{m|P|d})
    end

    def accidentals
      case
      when distance_to_starting.positive? then 'A'
      when distance_to_starting.negative? then 'd'
      else return ''
      end * distance_to_starting.abs
    end

    def name
      @name ||= begin
        if distance_to_starting.zero? || distance_to_starting.abs > 2
          compound? ? interval_class.compound_name : interval_class.name
        else
          "#{accidentals}#{starting_interval.distance + (compound? ? 7 : 0)}"
        end
      end
    end

    def as(n)
      i = clone(letter_distance: n)
      i if i.name.match?(n.to_s)
    end

    def as!(n)
      i = as(n)
      i if !i&.name&.match?(%r{d|A})
    end

    def as_diminished(n=1)
      as(letter_distance + n)
    end

    def as_augmented(n=1)
      as(letter_distance - n)
    end

    def clone(override_args = {})
      self.class.new({
        semitones: semitones,
        letter_distance: letter_distance,
        compound: compound?
      }.merge(override_args))
    end

    def diminish(n=1)
      clone(semitones: semitones - n)
    end

    alias diminished diminish

    def augment(n=1)
      clone(semitones: semitones + n)
    end

    alias augmented augment

    def opposite
      clone(semitones: -semitones, letter_distance: (-letter_distance % 8) + 1)
    end

    def ascending
      ascending? ? self : opposite
    end

    def descending
      descending? ? self : opposite
    end

    private

    def starting_interval # select the closest interval possible to start from
      @starting_interval ||= begin
        IntervalClass.all
          .select { |i| i.distance == normalized_letter_distance }
          .sort_by { |i|
            (cents - i.cents)
              .yield_self { |d| [(d % 1200), (d % -1200)].min_by(&:abs) }
              .abs
          }
          .first
      end
    end

    def normalized_letter_distance
      return letter_distance if letter_distance < 8
      (letter_distance % 8) + 1
    end

    def distance_to_starting # calculate the closts distance to it
      d = semitones - starting_interval.semitones
      [(d % 12), (d % -12)].min_by(&:abs)
    end

    def all_letters
      PitchClass.all_letters
    end

    def calculate_letter_distance(a, b, asc)
      all_letters
        .rotate(all_letters.index(asc ? a : b))
        .index(b) + 1
    end

    public

    all_including_compound_and_altered.each do |interval|
      self.class.define_method(interval.full_name.underscore) { interval.clone }
    end

  end
end
