module Coltrane
  module UI
    class Router
      class Route
        attr_reader :path, :view, :last
        attr_accessor :params

        def initialize(path, to:, with: {})
          @path   = path
          @view   = to
          @params = with
        end

        def render(**other_params)
          view.render(**params, **other_params)
        end
      end

      class History
        attr_reader :routes

        def initialize
          @routes = []
        end

        def add(route)
          @routes << route
        end

        def previous
          routes[-2]&.path || ''
        end

        def current_route
          routes[-1]
        end

        def back
          routes.pop.render
        end

        def refresh(params={})
          current_route.render(params)
        end
      end

      attr_reader :path, :params, :routes, :history, :url

      def initialize
        @routes  = []
        @history = History.new

        draw_route '', to: Coltrane::UI::Views::Index
        Views.constants.each do |view|
          draw_route view.to_s.underscore.humanize.downcase, to: "Coltrane::UI::Views::#{view}".constantize
        end
      end

      def get(**params)
        path = params.delete(:path)
        @url  = build_url(path || history.current_route.path, **params)
        route = @routes.detect { |route| route.path == path }
        return history.refresh(params) unless route
        history.add(route)
        route.render(**params)
      end

      def build_url(path, params)
        [
          path,
          (params || {}).map do |k,v|
            [k,v.gsub(' ', '-')].join(':')
          end
        ].compact.join(' ')
      end

      def previous_path
        history.previous
      end

      def draw_route(*args, **keyword_args, &block)
        @routes << Route.new(*args, **keyword_args, &block)
      end
    end
  end
end