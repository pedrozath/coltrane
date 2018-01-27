module Coltrane
  class ColtraneError < StandardError
    def initialize(msg)
      super msg
    end
  end

  class BadConstructor < ColtraneError
    def initialize(msg=nil)
      super "Bad constructor. #{msg}"
    end
  end

  class WrongKeywords < BadConstructor
    def initialize(msg)
      super "Use one of the following set of keywords: #{msg}"
    end
  end

  class InvalidNote < BadConstructor
    def initialize(note)
      super "#{note} is not a valid note"
    end
  end

  class InvalidNotes < BadConstructor
    def initialize(notes)
      super "#{notes} are not a valid set of notes"
    end
  end

  class WrongDegree < BadConstructor
    def initialize(degree)
      super "#{degree} is not a valid degree. Degrees for this scale must be between 1 and #{degrees}"
    end
  end
end