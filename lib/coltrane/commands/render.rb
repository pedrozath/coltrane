module Coltrane
  module Commands
    class Render < Command
      def run(object)
        Renderers::TextRenderer.render(object)
      end
    end
  end
end