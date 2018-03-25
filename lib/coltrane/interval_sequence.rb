# frozen_string_literal: true

module Coltrane
  # It describes a sequence of intervals
  class IntervalSequence
    extend Forwardable
    attr_reader :intervals

    def_delegators :@intervals, :map, :each, :[], :size,
                   :reduce, :delete, :reject!, :delete_if, :detect, :to_a

    def initialize(*intervals, notes: nil, relative_intervals: nil)
      if intervals.any?
        @intervals = if intervals.first.is_a?(Interval)
          intervals
        else
          intervals.map { |i| Interval[i] }
        end

      elsif notes
        notes = NoteSet[*notes] if notes.is_a?(Array)
        @intervals = intervals_from_notes(notes)
      elsif relative_intervals
        @relative_intervals = relative_intervals
        @intervals = intervals_from_relative_intervals(relative_intervals)
      else
        binding.pry
        raise WrongKeywordsError,
          'Provide: [notes:] || [intervals:] || [relative_intervals:]'
      end
    end

    Interval.all_including_compound_and_altered.each do |interval|
      # Creates methods such as major_third, returning it if it finds
      define_method("#{interval.full_name.underscore}") { find(interval) }
      # Creates methods such as has_major_third?, returning a boolean
      define_method("has_#{interval.full_name.underscore}?") { has?(interval) }
    end

    Interval.distances_names.map(&:underscore).each_with_index do |distance, i|
      # Creates methods such as has_third?, returning a boolean
      define_method("has_#{distance}?") { !!find_by_distance(i+1) }
      # Creates methods such third, returning any third it finds
      define_method("#{distance}" )     { find_by_distance(i+1) }
      # Creates methods such third!, returning thirds that arent aug or dim
      define_method("#{distance}!")     { find_by_distance(i+1, false) }
    end

    instance_eval { alias [] new }

    def relative_intervals
      intervals_semitones[1..-1].each_with_index.map do |n, i|
        if i.zero?
          n
        elsif i < intervals_semitones.size
          n - intervals_semitones[i]
        end
      end + [12 - intervals_semitones.last]
    end

    def names
      intervals.map(&:name)
    end

    def find(interval)
      interval.clone if detect { |i| interval == i }
    end

    def has?(interval)
      !!find(interval)
    end

    def find_by_distance(n, accept_altered = true)
      strategy = (accept_altered ? :as : :as!)
      map { |interval| interval.send(strategy, n) }
        .compact
        .sort_by { |i| i.alteration.abs }
        .first
    end

    alias interval_names names

    def all
      intervals
    end

    def [](x)
      intervals[x]
    end

    def shift(ammount)
      self.class.new(*intervals.map do |i|
        (i.semitones + ammount) % 12
      end)
    end

    def zero_it
      shift(-intervals.first.semitones)
    end

    def inversion(index)
      self.class.new(*intervals.rotate(index)).zero_it
    end

    def next_inversion
      inversion(index + 1)
    end

    def previous_inversion
      inversion(index - 1)
    end

    def inversions
      Array.new(intervals.length) { |i| inversion(i) }
    end

    def intervals_semitones
      map(&:semitones)
    end

    def names
      map(&:name)
    end

    def full_names
      map(&:full_name)
    end

    def notes_for(root_note)
      NoteSet[
        *intervals.reduce([]) do |memo, interval|
          memo + [root_note + interval]
        end
      ]
    end

    def &(other)
      case other
      when Array then intervals & other
      when IntervalSequence then intervals & other.semitones
      end
    end

    private

    def intervals_from_relative_intervals(relative_intervals)
      relative_intervals[0..-2].reduce([Interval[0]]) do |memo, d|
        memo + [memo.last + d]
      end
    end

    def intervals_from_notes(notes)
      notes.map { |n| notes.root - n}.sort_by(&:semitones)
    end
  end
end
