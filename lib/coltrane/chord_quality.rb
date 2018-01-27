module Coltrane
  # It describe the quality of a chord, like maj7 or dim.
  class ChordQuality < IntervalSequence
    attr_reader :name
    include Qualities

    def initialize(name: nil, notes: nil)
      if !name.nil?
        @name = name
        super(intervals: CHORD_QUALITIES[name])
      elsif !notes.nil?
        super(notes: notes)
        @name = find_quality
      else
        raise WrongKeywords.new('[name:] || [notes:]')
      end
    end

    private

    def find_quality
      (size).times do |i|
        if(found=CHORD_QUALITIES.key(inversion(i).intervals_semitones))
          return found
        end
      end
      nil
    end

  end
end