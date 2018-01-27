module Coltrane
  module Cli
    class Scale
      def self.find(notes: [], chords: [])
        if notes.any? then having_notes(*notes)
        elsif chords.any? then having_chords(chords.map(&:notes))
        else raise BadFindScales.new
        end
      end

      def self.having_notes(*notes)
        # TODO: This is a complete mess, refactor it!
        puts "\nSearching #{notes.join(', ')} in scales:\n\n"
        scale_name_size = Coltrane::ClassicScales::SCALES.keys.map(&:size).max
        notes = notes.map { |n| Coltrane::Note.new(n) }
        Coltrane::ClassicScales::SCALES.each_with_object([]) do |scale_obj, results|
          scale_name, intervals = scale_obj
          print Paint[scale_name.ljust(scale_name_size), 'yellow']
          Note.all.each do |note|
            found_sth = false
            print ' '
            scale  = Coltrane::Scale.new(*intervals, tone: note.name)
            notes_included = scale.include_notes?(*notes)
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
                     on: "text",
                     flavor: :degrees,
                     notes: [],
                     chords: [])

        @notes  = notes
        @chords = chords
        @flavor = flavor.downcase.to_sym
        @scale  = Coltrane::Scale.public_send(name, root_note) unless name.nil?
        puts notes
      end

      def notes
        desc = if on == "text"
                 "The notes of the given scale are:"
               else
                 "This is the #{@scale.tone.name} #{@scale.name} scale on #{on}"
               end

        Coltrane::Cli::Notes.new(@scale.notes, on: on, desc: desc, flavor: @flavor)
      end

    end
  end
end