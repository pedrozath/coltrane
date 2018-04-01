module Coltrane
  module Commands
    class FindScale < Command
      attr_reader :scale_set

      def initialize(scale_set)
        @scale_set = scale_set
      end

      def representation
        scale_set
      end

      def self.mercenary_init(program)
        program.command(:'find-scale') do |c|
          c.syntax 'find-scale --notes C-D-E-...] OR --chord Cmaj7-Db7'
          c.description 'finds scales with the provided --notes or --chord'
          c.option :notes, '--notes C-D-E', 'Find scales with those notes'
          c.option :chords, '--chords Cmaj7-D11', 'find scales with those chords'
          c.action do |(_), notes: nil, chords: nil|
            begin
              if notes
                Theory::Scale.having_notes(
                  Theory::NoteSet[*notes.to_s.split('-')]
                )
              elsif chords
                Theory::Scale.having_chords(*chords.to_s.split('-'))
              else
                raise 'Provide --notes or --chords separated by dashes.' \
                      'For example coltrane find-scale --notes C-E-F#'
              end
            end
            .yield_self { |scale_set| new(scale_set).render }
          end
        end
      end
    end
  end
end