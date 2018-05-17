# frozen_string_literal: true

module Coltrane
  module Theory
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

      # Creates factories for scales
      SCALES.each do |name, distances|
        define_method name.underscore do |tone = 'C', mode = 1|
          new(*distances, tone: tone, mode: mode, name: name)
        end
      end

      # Creates factories for Greek Modes
      class_eval(GreekMode::MODES.each_with_index.reduce('') { |code, (mode, index)| code + <<-RUBY }, __FILE__, __LINE__ + 1)
        def #{mode.underscore}(tone = 'C')
          GreekMode.new(:#{mode.underscore.to_sym}, tone)
        end
      RUBY

      # Factories for the diatonic scale
      def major(note = 'C')
        DiatonicScale.new(note)
      end

      def minor(note = 'A')
        DiatonicScale.new(note, major: false)
      end

      alias diatonic      major
      alias natural_minor minor
      alias pentatonic    pentatonic_major
      alias blues         blues_major

      def known_scales
        SCALES.keys + ['Major', 'Natural Minor']
      end

      # List of scales appropriate for search
      def standard_scales
        known_scales - ['Chromatic']
      end

      def fetch(name, tone = nil)
        public_send(name.underscore, tone)
      end

      # def having_notes(notes)
      #   format = { scales: [], results: {} }
      #   standard_scales.each_with_object(format) do |name, output|
      #     PitchClass.all.each.map do |tone|
      #       scale = send(name.underscore, tone)
      #       output[:results][name] ||= {}
      #       next if output[:results][name].key?(tone.integer)
      #       output[:scales] << scale if scale.include?(notes)
      #       output[:results][name][tone.integer] = scale.notes & notes
      #     end
      #   end
      # end

      def having_notes(notes)
        PitchClass.all
        .reduce([]) { |scales, tone|
          standard_scales
          .reduce([]) { |tone_scales, scale|
            fetch(scale, tone)
            .yield_self { |scale|
              (scale & notes).size > 0 ? tone_scales + [scale] : tone_scales
            }
          }.yield_self { |scales_for_tone|
            scales + scales_for_tone
          }
        }
        .yield_self { |scales| ScaleSet.new(*scales, searched_notes: notes) } # and convert to a set

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
end
