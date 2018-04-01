module Coltrane
  module Renderers
    module Renderer
      include Dry::Monads::Try::Mixin

      def render(model, **options)
        model
          .yield_self { |model| model_class_list(model) }
          .yield_self { |model_classes| renderer_class(*model_classes) }
          .value_or   { raise("Renderer doesn't implements #{model.class}") }
          .new(model, **options)
          .render
      end

      private

      def model_class_list(model)
        model
          .class
          .ancestors
          .yield_self { |classes| classes[0...classes.index(Object)]  }
      end

      def renderer_class(*classes)
        return if classes.empty?
        Try() { classes }
          .fmap { |classes|
             classes
              .first
              .to_s
              .gsub('Coltrane::', '')
              .gsub('::', '')
              .prepend("#{self.name}::")
              .concat('Drawer')
              .yield_self {|class_name| Object.const_get(class_name) }
          }
          .to_maybe
          .or(renderer_class(*classes[1..-1]))
      end
    end
  end
end