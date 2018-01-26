module Coltrane
  module ClassicProgressions
    PROGRESSIONS = {
      pop:        [:major, [1,5,6,4]],
      fifties:    [:major, [1,6,4,5]],
      blues:      [:major, [1,4,1,5,4,1]],
      jazz:       [:major, [2,5,1]],
      jazz_minor: [:minor, [2,5,1]],
      andalusian: [:minor, [1,7,6,5]]
    }

    def pop(tone)
      scale, degrees = PROGRESSIONS[:pop]
      Scale.public_send(scale, tone).progression(*degrees)
    end

    def fifties(tone)
      scale, degrees = PROGRESSIONS[:fifties]
      Scale.public_send(scale, tone).progression(*degrees)
    end

    def blues(tone)
      scale, degrees = PROGRESSIONS[:blues]
      Scale.public_send(scale, tone).progression(*degrees)
    end

    def jazz(tone)
      scale, degrees = PROGRESSIONS[:jazz]
      Scale.public_send(scale, tone).progression(*degrees)
    end

    def andalusian(tone)
      scale, degrees = PROGRESSIONS[:andalusian]
      Scale.public_send(scale, tone).progression(*degrees)
    end
  end
end
