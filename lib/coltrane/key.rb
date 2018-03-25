# frozen_string_literal: true

module Coltrane
  class Key < DiatonicScale
    KEY_REGEX = /([A-G][#b]?)([mM]?)/

    def initialize(notation)
      _, note, s = *notation.match(KEY_REGEX)
      super(note, major: s != 'm')
    end

    def self.[](notation)
      new(notation)
    end
  end
end
