module Coltrane
  # It describes a sequence of intervals
  class IntervalSequence
    extend Forwardable
    attr_reader :intervals

    def_delegators :@intervals, :map, :each, :[], :size, :reduce

    def initialize(notes: nil, intervals: nil, distances: nil)
      if !notes.nil?
        notes = NoteSet[*notes] if notes.is_a?(Array)
        @intervals = intervals_from_notes(notes)
      elsif !intervals.nil?
        @intervals = intervals.map { |i| Interval.new(i) }
      elsif !distances.nil?
        @distances = distances
        @intervals = intervals_from_distances(distances)
      else
        raise 'Provide: [notes:] || [intervals:] || [distances:'
      end
    end

    def distances
      intervals_semitones[1..-1].each_with_index.map do |n, i|
        if i == 0
          n
        elsif i < intervals_semitones.size
          n - intervals_semitones[i]
        end
      end + [12 - intervals_semitones.last]
    end

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
      self.shift(-intervals.first.semitones)
    end

    def inversion(index)
      IntervalSequence.new(intervals: intervals.rotate(index)).zero_it
    end

    def next_inversion
      inversion(index+1)
    end

    def previous_inversion
      inversion(index-1)
    end

    def inversions
      Array.new(intervals.length) do |index|
        inversion(index)
      end
    end

    def quality
    end

    def intervals_semitones
      map(&:semitones)
    end

    def names
      map(&:name)
    end

    def notes_for(root_note)
      NoteSet[
        *intervals.reduce([]) do |memo, interval|
          memo + [root_note + interval]
        end
      ]
    end

    private

    def intervals_from_distances(distances)
      distances[0..-2].reduce([Interval.new(0)]) do |memo, d|
        memo + [memo.last + d]
      end
    end

    def intervals_from_notes(notes)
      notes.map { |n| notes.root - n }.sort_by(&:semitones)
    end
  end
end