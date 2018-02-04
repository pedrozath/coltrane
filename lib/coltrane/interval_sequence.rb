# frozen_string_literal: true

module Coltrane
  # It describes a sequence of intervals
  class IntervalSequence
    extend Forwardable
    attr_reader :intervals

    def_delegators :@intervals, :map, :each, :[], :size,
                   :reduce, :delete

    Interval::ALL_FULL_NAMES.each do |full_name|
      define_method "has_#{full_name.underscore}?" do
        !!(intervals.detect {|i| i.public_send("#{full_name.underscore}?")})
      end
    end

    (1..15).each do |i|
      # defines methods like :fifth, :third, eleventh:
      define_method i.interval_name.underscore do
        priority = send("#{i.interval_name.underscore}!")
        return priority unless priority.nil?
        @intervals.each do |ix|
          ix.full_names.detect do |ixx|
            return ixx if ixx.match(/#{i.interval_name}/)
          end
        end
        nil
      end

      define_method "#{i.interval_name.underscore}!" do
        @intervals.each do |ix|
          ix.full_names.detect do |ixx|
            next if ixx.match(/Diminished|Augmented/)
            return ixx if ixx.match? /#{i.interval_name}/
          end
        end
        nil
      end

      # defines methods like :has_fifth?, :has_third?, has_eleventh?:
      define_method "has_#{i.interval_name.underscore}?" do
        !!@intervals.detect {|ix| ix.full_name.match(/#{i.interval_name}/) }
      end
    end

    def initialize(notes: nil, intervals: nil, distances: nil)
      if !notes.nil?
        notes = NoteSet[*notes] if notes.is_a?(Array)
        @intervals = intervals_from_notes(notes)
      elsif !intervals.nil?
        @intervals = intervals.map { |i| Interval[i] }
      elsif !distances.nil?
        @distances = distances
        @intervals = intervals_from_distances(distances)
      else
        raise 'Provide: [notes:] || [intervals:] || [distances:]'
      end
    end

    def distances
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

    def has?(interval_name)
      @intervals.include?(Interval[interval_name])
    end

    alias interval_names names

    def all
      intervals
    end

    def [](x)
      intervals[x]
    end

    def shift(ammount)
      IntervalSequence.new(intervals: intervals.map do |i|
        (i.semitones + ammount) % 12
      end)
    end

    def zero_it
      shift(-intervals.first.semitones)
    end

    def inversion(index)
      IntervalSequence.new(intervals: intervals.rotate(index)).zero_it
    end

    def next_inversion
      inversion(index + 1)
    end

    def previous_inversion
      inversion(index - 1)
    end

    def inversions
      Array.new(intervals.length) do |index|
        inversion(index)
      end
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

    def intervals_from_distances(distances)
      distances[0..-2].reduce([Interval[0]]) do |memo, d|
        memo + [memo.last + d]
      end
    end

    def intervals_from_notes(notes)
      notes.map { |n| notes.root - n }.sort_by(&:semitones)
    end
  end
end
