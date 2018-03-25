require 'paint'
require 'color'

require 'coltrane/renderers/text_renderer/base_drawer'
require 'coltrane/renderers/text_renderer/array_drawer'
require 'coltrane/renderers/text_renderer/hash_drawer'
require 'coltrane/renderers/text_renderer/theory_note_set_drawer'
require 'coltrane/renderers/text_renderer/theory_chord_drawer'
require 'coltrane/renderers/text_renderer/theory_scale_drawer'
require 'coltrane/renderers/text_renderer/theory_scale_set_drawer'
require 'coltrane/renderers/text_renderer/theory_progression_drawer'
require 'coltrane/renderers/text_renderer/theory_progression_set_drawer'
require 'coltrane/renderers/text_renderer/representation_guitar_note_set_drawer'
require 'coltrane/renderers/text_renderer/representation_guitar_chord_drawer'
require 'coltrane/renderers/text_renderer/representation_piano_note_set_drawer'

module Coltrane
  module Renderers
    module TextRenderer
      extend Renderer
    end
  end
end
