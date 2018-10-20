module Coltrane
  module UI
    class BaseView < Gambiarra::View
      def self.render(view)
        Commands::Render.run(view.render)
      end
    end
  end
end
