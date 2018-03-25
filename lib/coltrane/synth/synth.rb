# frozen_string_literal: true

module ColtraneSynth
  class Synth
    attr_reader :freq, :nominal_rate

    def initialize(buffer, freq, nominal_rate)
      @freq = freq.to_f
      @nominal_rate = nominal_rate

      i = -1
      wav = NArray.sint(1024)

      while i += 1
        1024.times do |j|
          wav[j] = (0.4 * Math.sin(phase(freq) * (i * 1024 + j)) * 0x7FFF).round
        end
        buffer << wav
      end
    end

    def phase(freq)
      Math::PI * 2.0 * freq / nominal_rate
    end
  end
end
