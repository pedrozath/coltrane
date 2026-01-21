module Coltrane
  module Commands
    class GetInstrumentWithTuning < Command
      GUITAR_TUNING_MAP = {
        'Standard (E A D G B E)' => %w[E2 A2 D3 G3 B3 E4],
        'Drop D (D A D G B E)' => %w[D2 A2 D3 G3 B3 E4],
        'Open G (D G D G B D)' => %w[D2 G2 D3 G3 B3 D4],
        'Open D (D A D F# A D)' => %w[D2 A2 D3 F#3 A3 D4],
        'Open A (E A C# E A E)' => %w[E2 A2 C#3 E3 A3 E4],
        'Half Step Down (D# G# C# F# A# D#)' => %w[D#2 G#2 C#3 F#3 A#3 D#4],
        'Full Step Down (D G C F A D)' => %w[D2 G2 C3 F3 A3 D4]
      }.freeze

      UKULELE_TUNING_MAP = {
        'Standard (G C E A)' => %w[G3 C4 E4 A4],
        'Low G (G C E A)' => %w[G2 C4 E4 A4],
        'Linear (A D F# B)' => %w[A3 D4 F#4 B4]
      }.freeze

      BASS_TUNING_MAP = {
        'Standard (E A D G)' => %w[E1 A1 D2 G2],
        'Drop D (D A D G)' => %w[D1 A1 D2 G2],
        'Half Step Down (D# G# C# F#)' => %w[D#1 G#1 C#2 F#2],
        'Full Step Down (D G C F)' => %w[D1 G1 C2 F2]
      }.freeze

      def run(instrument, tuning_key, custom_tuning = nil)
        # Normalize the key by replacing hyphens with spaces (from command line)
        normalized_key = tuning_key.gsub('-', ' ')

        tuning_map = case instrument
                     when 'Ukulele'
                       UKULELE_TUNING_MAP
                     when 'Bass'
                       BASS_TUNING_MAP
                     else
                       GUITAR_TUNING_MAP
                     end

        tuning = if normalized_key == 'Custom' && custom_tuning
                   custom_tuning
                 else
                   default_key = tuning_map.keys.first
                   tuning_map[normalized_key] || tuning_map[default_key]
                 end

        instrument_class = Object.const_get("Coltrane::Representation::#{instrument}")
        instrument_class.new(tuning: tuning)
      end
    end

    class GetGuitarWithTuning < GetInstrumentWithTuning
    end
  end
end
