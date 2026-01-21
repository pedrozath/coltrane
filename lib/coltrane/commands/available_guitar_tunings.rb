module Coltrane
  module Commands
    class AvailableInstrumentTunings < Command
      GUITAR_TUNINGS = [
        'Standard (E A D G B E)',
        'Drop D (D A D G B E)',
        'Open G (D G D G B D)',
        'Open D (D A D F# A D)',
        'Open A (E A C# E A E)',
        'Half Step Down (D# G# C# F# A# D#)',
        'Full Step Down (D G C F A D)',
        'Custom'
      ].freeze

      UKULELE_TUNINGS = [
        'Standard (G C E A)',
        'Low G (G C E A)',
        'Linear (A D F# B)',
        'Custom'
      ].freeze

      BASS_TUNINGS = [
        'Standard (E A D G)',
        'Drop D (D A D G)',
        'Half Step Down (D# G# C# F#)',
        'Full Step Down (D G C F)',
        'Custom'
      ].freeze

      def run(instrument = 'Guitar')
        case instrument
        when 'Ukulele'
          UKULELE_TUNINGS
        when 'Bass'
          BASS_TUNINGS
        else
          GUITAR_TUNINGS
        end
      end
    end

    class AvailableGuitarTunings < Command
      def run
        AvailableInstrumentTunings.new.run('Guitar')
      end
    end
  end
end
