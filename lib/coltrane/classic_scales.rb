require 'ostruct'

module ClassicScales

  SCALES = {
    'Major'            => [2,2,1,2,2,2,1],
    'Natural Minor'    => [2,1,2,2,1,2,2],
    'Harmonic Minor'   => [2,1,2,2,1,3,1],
    'Hungarian Minor'  => [2,1,2,1,1,3,1],
    'Pentatonic Major' => [2,2,3,2,3],
    'Pentatonic Minor' => [3,2,2,3,2],
    'Blues Major'      => [2,1,1,3,2,3],
    'Blues Minor'      => [3,2,1,1,3,2],
    'Whole Tone'       => [2,2,2,2,2,2],
    'Flamenco'         => [1,3,1,2,1,2,2]
  }

  def major(tone='C', mode=1)
    new(*SCALES['Major'], tone: tone, mode: mode)
  end

  def natural_minor(tone='C', mode=1)
    new(*SCALES['Natural Minor'], tone: tone, mode: mode)
  end

  def harmonic_minor(tone='C', mode=1)
    new(*SCALES['Harmonic Minor'], tone: tone, mode: mode)
  end

  def hungarian_minor(tone='C', mode=1)
    new(*SCALES['Hungarian Minor'], tone: tone, mode: mode)
  end

  def pentatonic_major(tone='C', mode=1)
    new(*SCALES['Pentatonic Major'], tone: tone, mode: mode)
  end

  def pentatonic_minor(tone='C', mode=1)
    new(*SCALES['Pentatonic Minor'], tone: tone, mode: mode)
  end

  def blues_major(tone='C', mode=1)
    new(*SCALES['Blues Major'], tone: tone, mode: mode)
  end

  def blues_minor(tone='C', mode=1)
    new(*SCALES['Blues Minor'], tone: tone, mode: mode)
  end

  def whole_tone(tone='C', mode=1)
    new(*SCALES['Blues Minor'], tone: tone, mode: mode)
  end

  def chromatic(tone='C', mode=1)
    new(*([1]*12), tone: tone, mode: mode)
  end

  def ionian(tone='C')
    new(*SCALES['Major'], tone: tone, mode: 1)
  end

  def dorian(tone='C')
    new(*SCALES['Major'], tone: tone, mode: 2)
  end

  def phrygian(tone='C')
    new(*SCALES['Major'], tone: tone, mode: 3)
  end

  def lydian(tone='C')
    new(*SCALES['Major'], tone: tone, mode: 4)
  end

  def mixolydian(tone='C')
    new(*SCALES['Major'], tone: tone, mode: 5)
  end

  def aeolian(tone='C')
    new(*SCALES['Major'], tone: tone, mode: 6)
  end

  def locrian(tone='C')
    new(*SCALES['Major'], tone: tone, mode: 7)
  end

  def flamenco(tone='C')
    new(*SCALES['Flamenco'], tone: tone)
  end

  def having_chord(chord)
    puts "\nSearching #{chord} in scales:\n\n"
    scale_name_size = SCALES.keys.map(&:size).max
    chord = Chord.new(chord)
    SCALES.each_with_object([]) do |scale_obj, results|
      scale_name, intervals = scale_obj
      print Paint[scale_name.ljust(scale_name_size), 'yellow']
      Note.all.each do |note|
        found_sth = false
        print ' '
        scale  = Scale.new(*intervals, tone: note.name)
        degree = scale.degree_of_chord(chord)
        unless degree.nil?
          found_sth = true
          results << OpenStruct.new({ name: "#{note.name} #{scale_name}",
                       degree: degree,
                       scale: scale})
        end
        print Paint[note.name, found_sth ? 'yellow' : 'black']
      end
      print "\n"
    end
  end

  def having_notes(*notes)
    puts "\nSearching #{notes.join(', ')} in scales:\n\n"
    scale_name_size = SCALES.keys.map(&:size).max
    notes = notes.map { |n| Note.new(n) }
    SCALES.each_with_object([]) do |scale_obj, results|
      scale_name, intervals = scale_obj
      print Paint[scale_name.ljust(scale_name_size), 'yellow']
      Note.all.each do |note|
        found_sth = false
        print ' '
        scale  = Scale.new(*intervals, tone: note.name)
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
end