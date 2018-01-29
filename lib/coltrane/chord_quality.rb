# frozen_string_literal: true

module Coltrane
  # It describe the quality of a chord, like maj7 or dim.
  class ChordQuality < IntervalSequence
    attr_reader :name
    include Qualities

    def initialize(name: nil, notes: nil)
      if !name.nil?
        binding.pry unless (intervals = CHORD_QUALITIES[name])
        raise ChordNotFoundError unless (intervals = CHORD_QUALITIES[name])
        @name = name
        super(intervals: intervals)
      elsif !notes.nil?
        super(notes: notes)
        @name = CHORD_QUALITIES.key(intervals_semitones)
      else
        raise WrongKeywordsError, '[name:] || [notes:]'
      end
    end
  end
end
