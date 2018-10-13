module Coltrane
  module Cli
    module Views
      class View
        attr_reader :params, :path

        class << self
          def inherited(subclass)
            @questions ||= {}
            subclass.instance_variable_set(:@questions, @questions.deep_dup)
          end

          def questions(question_data)
            @questions.merge!(question_data)
          end

          def set_path(value)
            @params[:path] = value
          end

          def render(**params)
            remaining_questions = @questions.slice(*(@questions.keys - params.keys))
            return { questions: remaining_questions, **params } if remaining_questions.any?
            view = new(**params)
            { content: Commands::Render.run(view.render), **params }
          end
        end

        def initialize(**params)
          @params = params
        end

        def output(object)
          self.class.output(object)
        end

        def go_to(path, **params)
          # App.router.set_next(path, **params) and return
        end

        def ensure_param(param_name, &block)
          @params[param_name] = block.call if @params[param_name].nil?
        end
      end
    end
  end
end
