module Coltrane
  module Commands
    class Progression < Command
      def self.mercenary_init(program)
        program.command(:progression) do |c|
          c.syntax 'progression <roman numeral notation> in <key> [--on <instrument>]'
          c.description 'Gives you chords of a progression in a key. Ex: coltrane progression I-IV-iv-V in Am --on guitar'
          add_shared_option(:flavor, c)
          add_shared_option(:on, c)
          add_shared_option(:voicings, c)
          c.action do |(prog, _, key), **options|
            prog
            .tr('-', '_')
            .yield_self { |possible_method|
              if Theory::Progression.respond_to?(possible_method)
                Theory::Progression.send(possible_method, key)
              else
                Theory::Progression.new(prog, key: key)
              end
            }
            .chords
            .each { |chord| Commands::Chords.new(chord, **options).render }
          end
        end
      end
    end
  end
end