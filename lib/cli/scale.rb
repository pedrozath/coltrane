# frozen_string_literal: true

module Coltrane
  module Cli
    # Interfaces commands with the scales functionality
    class Scale
      def self.parse(str)
        *scale_name, tone = str.split('-')
        Coltrane::Scale.fetch(scale_name.join('_'), tone)
      end

      def self.find(notes: [], chords: [])
        if notes.any?
          puts "\nSearching for scales containing #{notes.join(', ')}:\n\n"
          notes = NoteSet[*notes]
        elsif chords.any?
          puts "\nSearching for scales containing #{chords.join(', ')}:\n\n"
          notes = chords.reduce(NoteSet[]) do |memo, c|
            memo + Coltrane::Chord.new(name: c).notes
          end
        else raise BadFindScales
        end
        render_search(notes)
        puts "\nUnderlined means the scale has all notes"
      end

      def self.render_search(searched_notes)
        search = Coltrane::Scale.having_notes(searched_notes)
        output = []
        scale_width = search.results.keys.map(&:size).max
        search.results.each do |name, scales_by_tone|
          output << name.ljust(scale_width + 1, ' ')
          scales_by_tone.each do |tone_number, notes|
            p     = (notes.size.to_f / searched_notes.size) * 100
            l     = p == 100 ? p : (p + 20) * 0.4
            und   = p == 100 ? :underline : nil
            color = Color::HSL.new(30, p, l / 2).html
            output << Paint["#{Note[tone_number].name}(#{notes.size})", color, und]
            output << ' '
          end
          output << "\n"
        end
        puts output.join
      end

      def initialize(scale, on: :text, flavor: 'degrees')
        desc = "This is the #{scale.tone.name} #{scale.name} scale:"
        Coltrane::Cli::Notes.new(scale.notes, on: on, desc: desc, flavor: flavor)
      end
    end
  end
end
