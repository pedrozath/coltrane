# frozen_string_literal: true

# rubocop:disable Style/Documentation

module Coltrane
  class ColtraneError < StandardError
    def initialize(msg)
      super msg
    end
  end

  class BadConstructorError < ColtraneError
    def initialize(msg = nil)
      super "Bad constructor. #{msg}"
    end
  end

  class WrongKeywordsError < BadConstructorError
    def initialize(msg)
      super "Use one of the following set of keywords: #{msg}"
    end
  end

  class WrongArgumentsError < BadConstructorError
    def initialize(msg)
      super "Wrong argument(s)."
    end
  end

  class InvalidNoteError < BadConstructorError
    def initialize(note)
      super "#{note} is not a valid note"
    end
  end

  class InvalidNotesError < BadConstructorError
    def initialize(notes)
      super "#{notes} are not a valid set of notes"
    end
  end

  class HasNoNotesError < BadConstructorError
    def initialize
      super "The given object does not respond to :notes, "\
            "thereby it can't be used for this operation)"
    end
  end

  class WrongDegreeError
    def initialize(degree)
      super "#{degree} is not a valid degree. Degrees for this scale must be"\
            "between 1 and #{degrees}"
    end
  end

  class ChordNotFoundError < ColtraneError
    def initialize
      super "The chord you provided wasn't found. "\
            "If you're sure this chord exists, "\
            "would you mind to suggest it's inclusion here: "\
            'https://github.com/pedrozath/coltrane/issues '\
            "\n\nA tip tho: always include the letter M for major"
    end
  end

  class IntervalNotFoundError < ColtraneError
    def initialize(arg)
      super "The interval \"#{arg}\" that was provided wasn't found. "\
            "If you're sure this interval exists, "\
            "would you mind to suggest it's inclusion here: "\
            'https://github.com/pedrozath/coltrane/issues '\
    end
  end

  class InvalidPitchClassError < ColtraneError
    def initialize(arg)
      super "The given frequency(#{arg}) is not considered "\
            "part of a pitch class"\
    end
  end

  class InvalidNoteSymbolError < ColtraneError
    def initialize(arg)
      super "The musical notation included an unrecognizable symbol (#{arg})."
    end
  end

  class InvalidNoteLetterError < ColtraneError
    def initialize(arg)
      super "The musical notation included an unrecognizable letter (#{arg})."
    end
  end
end

# rubocop:enable Style/Documentation
