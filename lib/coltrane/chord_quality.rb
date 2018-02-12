# frozen_string_literal: true

module Coltrane
  # It describe the quality of a chord, like maj7 or dim.
  class ChordQuality < IntervalSequence
    attr_reader :name

    private

    def self.chord_trie
      trie = YAML.load_file(
        File.expand_path("#{'../'*3}data/qualities.yml", __FILE__)
      )

      trie.clone_values from_keys: ['Perfect Unison', 'Major Third'],
                        to_keys: ['Perfect Unison', 'Major Second'],
                        suffix: 'sus2'

      trie.clone_values from_keys: ['Perfect Unison', 'Major Third'],
                        to_keys: ['Perfect Unison', 'Perfect Fourth'],
                        suffix: 'sus4'
      trie.deep_dup
    end

    def self.intervals_per_name(quality_names: {}, intervals: [], hash: nil)
      hash ||= chord_trie
      return quality_names if hash.empty?
      if hash['name']
        quality_names.merge! hash.delete('name') => intervals.map {|n| Interval[n] }
      end
      hash.reduce(quality_names) do |memo, (interval, values)|
        memo.merge intervals_per_name(hash:  values,
                                      quality_names: quality_names,
                                      intervals: intervals + [interval])
      end
    end

    NAMES = intervals_per_name

    def find_chord(given_interval_names, trie: self.class.chord_trie, last_name: nil)
      return if trie.nil?
      if given_interval_names.empty?
        @found = true
        return trie['name']
      end
      interval = given_interval_names.shift
      new_trie = trie[interval]
      find_chord given_interval_names, last_name: (trie['name'] || last_name),
                                       trie: new_trie
    end

    def normal_sequence
      %i[unison third! fifth sixth! seventh ninth eleventh! thirteenth]
    end

    def sus2_sequence
      %i[unison second! fifth sixth! seventh ninth eleventh! thirteenth]
    end

    def sus4_sequence
      %i[unison fourth! fifth sixth! seventh ninth eleventh! thirteenth]
    end

    def retrieve_chord_intervals(chord_sequence = normal_sequence)
      ints = IntervalSequence.new(intervals: self)
      chord_sequence.map do |int_sym|
        next unless interval_name = ints.public_send(int_sym)
        ints.delete(Interval[interval_name])
        interval_name
      end
    end

    public

    def get_name
      if result = find_chord([*retrieve_chord_intervals].compact)
        return result
      elsif result = find_chord([*retrieve_chord_intervals(sus2_sequence)].compact)
        return result
      elsif result = find_chord([*retrieve_chord_intervals(sus4_sequence)].compact)
        return result
      else
        raise ChordNotFoundError
      end
    end


    def suspension_type
      if has_major_second?
        'sus2'
      else has_fourth?
        'sus4'
      end
    end

    def initialize(name: nil, notes: nil, bass: nil)
      if !name.nil?
        @name = bass.nil? ? name : [name, bass].join('/')
        super(intervals: NAMES[name])
      elsif !notes.nil?
        super(notes: notes)
        @name = get_name
      else
        raise WrongKeywordsError, '[name:] || [notes:]'
      end
    end

    alias to_s name
  end
end
