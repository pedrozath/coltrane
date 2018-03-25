# frozen_string_literal: true

module ColtraneSynth
  class Base
    attr_reader :device, :buffer

    SAMPLE_RATE = 44_000

    def self.play(something, duration = 1.0)
      new.play(*extract_frequencies(something), duration: duration)
    end

    def initialize
      @device = CoreAudio.default_output_device
    end

    def play(*freqs, duration: 1.0)
      @device = CoreAudio.default_output_device
      buffer = @device.output_loop(SAMPLE_RATE)

      SAMPLE_RATE.times do |i|
        sound = freqs.reduce(0) { |sum, freq| Math.sin(phase(freq) * i) + sum }
        buffer[i] = (sound * (0x6AFF / freqs.size)).round
      end

      buffer.start
      sleep duration
      buffer.stop
    end

    private

    def self.extract_frequencies(arg)
      case arg
      when Coltrane::Chord then arg.notes.map { |n| n.frequency.octave(4).to_f }
      when Coltrane::PitchClass then arg.frequency.octave(4).to_f
      when Coltrane::Voicing then arg.frequencies.map(&:to_f)
      end
    end

    def sine_wave(freq, i)
      Math.sin(phase(freq) * i)
    end

    def phase(freq)
      (Math::PI * 2.0 * freq) / SAMPLE_RATE.to_f
    end
  end
end
