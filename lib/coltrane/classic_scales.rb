# frozen_string_literal: true

module Coltrane
  # This module deals with well known scales on music
  module ClassicScales
    SCALES = {
      'Pentatonic Major' => [2, 2, 3, 2, 3],
      'Blues Major'      => [2, 1, 1, 3, 2, 3],
      'Harmonic Minor'   => [2, 1, 2, 2, 1, 3, 1],
      'Hungarian Minor'  => [2, 1, 2, 1, 1, 3, 1],
      'Pentatonic Minor' => [3, 2, 2, 3, 2],
      'Blues Minor'      => [3, 2, 1, 1, 3, 2],
      'Whole Tone'       => [2, 2, 2, 2, 2, 2],
      'Flamenco'         => [1, 3, 1, 2, 1, 2, 2],
      'Chromatic'        => [1] * 12
    }.freeze

    GREEK_MODES = %w[
      Ionian
      Dorian
      Phrygian
      Lydian
      Mixolydian
      Aeolian
      Locrian
    ].freeze

    # Creates factories for scales
    SCALES.each do |name, distances|
      define_method name.underscore do |tone = 'C', mode = 1|
        new(*distances, tone: tone, mode: mode, name: name)
      end
    end

    # Creates factories for Greek Modes
    GREEK_MODES.each_with_index do |mode, index|
      mode_name = mode
      mode_n = index + 1
      define_method mode.underscore do |tone = 'C'|
        new(notes: DiatonicScale.new(tone).notes.rotate(index))
      end
    end

    # Factories for the diatonic scale
    def major(note='C')
      DiatonicScale.new(note)
    end

    def minor(note='A')
      DiatonicScale.new(note, major: false)
    end

    alias diatonic major
    alias natural_minor minor
    alias pentatonic pentatonic_major
    alias blues blues_major

    def known_scales
      SCALES.keys + ['Major', 'Natural Minor']
    end

    # List of scales appropriate for search
    def standard_scales
      known_scales - ['Chromatic']
    end

    def fetch(name, tone = nil)
      Coltrane::Scale.public_send(name, tone)
    end

    def having_notes(notes)
      format = { scales: [], results: {} }
      standard_scales.each_with_object(format) do |name, output|
        PitchClass.all.each.map do |tone|
          scale = send(name.underscore, tone)
          output[:results][name] ||= {}
          next if output[:results][name].key?(tone.integer)
          output[:scales] << scale if scale.include?(notes)
          output[:results][name][tone.integer] = scale.notes & notes
        end
      end
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
