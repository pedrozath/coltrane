module Coltrane
  module Cli
    class Scale
      def self.find(notes: [], chords: [])
        if notes.any?
          puts "\nSearching for scales containing #{notes.join(', ')}:\n\n"
          NoteSet[notes]
        elsif chords.any?
          puts "\nSearching for scales containing #{chords.join(', ')}:\n\n"
          notes = chords.reduce(NoteSet[]) {|memo, c| memo + Chord.new(name: c).notes }
        else raise BadFindScales.new
        end
        having_notes(notes)
      end

      def self.having_notes(notes)
        # TODO: This is a complete mess, refactor it!
        Coltrane::Scale.known_scales.each_with_object([]) do |scale_obj, results|
          scale_name, intervals = scale_obj
          width = Coltrane::Scale.known_scales.max_by(&:size).size
          print Paint[scale_name.ljust(width), 'yellow']
          Note.all.each do |note|
            found_sth = false
            print ' '
            scale  = Coltrane::Scale.new(*intervals, tone: note.name)
            notes_included = scale.include_notes?(notes)
            if notes_included == notes
              found_sth = true
              results << OpenStruct.new({
                name: "#{note.name} #{scale_name}",
                notes: notes_included
              })
            end
            print Paint[note.name, found_sth ? 'yellow' : 'black']
            print Paint["(#{notes_included.count || 0})", found_sth ? 'gray' : 'black']
          end
          print "\n"
        end
      end

      def initialize(name: nil,
                     root_note: nil,
                     on: :text,
                     flavor: :degrees,
                     notes: [],
                     chords: [])

        @notes  = notes
        @chords = chords
        @flavor = flavor.downcase.to_sym
        @scale  = Coltrane::Scale.public_send(name, root_note) unless name.nil?
        notes(on: on)
      end

      def notes(on:)
        desc = if on == :text
                 "The notes of the given scale are:"
               else
                 "This is the #{@scale.tone.name} #{@scale.name} scale on #{on}"
               end

        Coltrane::Cli::Notes.new(@scale.notes, on: on, desc: desc, flavor: @flavor)
      end

    end
  end
end