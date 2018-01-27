module Coltrane
  module ClassicScales

    SCALES = {
      'Major'            => [2,2,1,2,2,2,1],
      'Natural Minor'    => [2,1,2,2,1,2,2],
      'Harmonic Minor'   => [2,1,2,2,1,3,1],
      'Hungarian Minor'  => [2,1,2,1,1,3,1],
      'Pentatonic Major' => [2,2,3,2,3],
      'Pentatonic Minor' => [3,2,2,3,2],
      'Blues Major'      => [2,1,1,3,2,3],
      'Blues Minor'      => [3,2,1,1,3,2],
      'Whole Tone'       => [2,2,2,2,2,2],
      'Flamenco'         => [1,3,1,2,1,2,2]
    }

    MODES = {
      'Major' => %w[Ionian Dorian Phrygian Lydian Mixolydian Aeolian Locrian]
    }

    private

    # A little helper to build method names
    # just make the code more clear
    def self.methodize(string)
      string.downcase.gsub(' ', '_')
    end

    public

    # Creates factories for scales
    SCALES.each do |name, distances|
      define_method methodize(name) do |tone='C', mode=1|
        new(*distances, tone: tone, mode: mode)
      end
    end

    # Creates factories for Greek Modes and possibly others
    MODES.each do |scale, modes|
      modes.each_with_index do |mode, index|
        scale_method = methodize(scale)
        mode_n = index + 1
        define_method methodize(mode) do |tone='C'|
          new(*SCALES[scale], tone: tone, mode: mode_n)
        end
      end
    end

    alias_method :minor,      :natural_minor
    alias_method :pentatonic, :pentatonic_major
    alias_method :blues,      :blues_major

    def known_scales
      SCALES.keys
    end

    def from_key(key)
      scale = key.delete!('m') ? :minor : :major
      note  = key
      Scale.public_send(scale.nil? || scale == 'M' ? :major : :minor, note)
    end
  end
end