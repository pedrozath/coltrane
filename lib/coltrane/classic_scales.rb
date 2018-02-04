# frozen_string_literal: true

module Coltrane
  # This module deals with well known scales on music
  module ClassicScales
    SCALES = {
      'Major'            => [2, 2, 1, 2, 2, 2, 1],
      'Pentatonic Major' => [2, 2, 3, 2, 3],
      'Blues Major'      => [2, 1, 1, 3, 2, 3],
      'Natural Minor'    => [2, 1, 2, 2, 1, 2, 2],
      'Harmonic Minor'   => [2, 1, 2, 2, 1, 3, 1],
      'Hungarian Minor'  => [2, 1, 2, 1, 1, 3, 1],
      'Pentatonic Minor' => [3, 2, 2, 3, 2],
      'Blues Minor'      => [3, 2, 1, 1, 3, 2],
      'Whole Tone'       => [2, 2, 2, 2, 2, 2],
      'Flamenco'         => [1, 3, 1, 2, 1, 2, 2],
      'Chromatic'        => [1]*12
    }.freeze

    MODES = {
      'Major' => %w[Ionian Dorian Phrygian Lydian Mixolydian Aeolian Locrian]
    }.freeze

    # Creates factories for scales
    SCALES.each do |name, distances|
      define_method name.underscore do |tone = 'C', mode = 1|
        new(*distances, tone: tone, mode: mode, name: name)
      end
    end

    # Creates factories for Greek Modes and possibly others
    MODES.each do |scale, modes|
      modes.each_with_index do |mode, index|
        mode_name = mode
        mode_n = index + 1
        define_method mode.underscore do |tone = 'C'|
          new(*SCALES[scale], tone: tone, mode: mode_n, name: mode_name)
        end
      end
    end

    alias minor natural_minor
    alias pentatonic pentatonic_major
    alias blues blues_major

    def known_scales
      SCALES.keys
    end

    # All but the chromatic
    def standard_scales
      SCALES.reject { |k,v| k == 'Chromatic' }
    end

    def fetch(name, tone = nil)
      Coltrane::Scale.public_send(name, tone)
    end

    def from_key(key)
      key_regex = /([A-G][#b]?)([mM]?)/
      _, note, s = *key.match(key_regex)
      scale = s == 'm' ? :minor : :major
      Scale.public_send(scale, note)
    end

    # Will output a OpenStruct like the following:
    # {
    #   scales: [array of scales]
    #   results: {
    #     scale_name: {
    #       note_number => found_notes
    #     }
    #   }
    # }

    def having_notes(notes)
      format = { scales: [], results: {} }
      OpenStruct.new(
        standard_scales.each_with_object(format) do |(name, intervals), output|
          Note.all.each.map do |tone|
            scale = new(*intervals, tone: tone, name: scale)
            output[:results][name] ||= {}
            next if output[:results][name].key?(tone.number)
            output[:scales] << scale if scale.include?(notes)
            output[:results][name][tone.number] = scale.notes & notes
          end
        end
      )
    end

    def having_chords(*chords)
      should_create = !chords.first.is_a?(Chord)
      notes = chords.reduce(NoteSet[]) do |memo, c|
        memo + (should_create ? Chord.new(name: c) : c).notes
      end
      having_notes(notes)
    end

    alias having_chord having_chords
  end
end
