# frozen_string_literal: true

# # frozen_string_literal: true

require 'spec_helper'

describe 'coltrane' do
  ENV['TERM_PROGRAM'] = 'Unsupported'
  <<~COMMANDS.split("\n")
    notes C-E-G
    notes C-Bbb-G#
    notes C#-Db-Eb --on guitar
    notes C#-Db-Eb --on piano
    chords CM7
    chords C6/9
    chords C6/9 --on guitar
    chords C6/9 --on piano
    chords C6/9 --on ukelele --flavor degrees
    chords C6/9 --on ukelele --flavor notes
    scale major-C
    scale major-C --on guitar --flavor intervals
    scale minor-D# --on guitar --flavor intervals
    scale minor-D# --on guitar --flavor intervals
    find-scale --notes C-E-G
    find-scale --chords CM7-C6/9-DbM
    common-chords major-D major-C
    common-chords blues-D major-C
    progression jazz in C
    progression blues in D
    progression pop in A#
    progression II-iii-iv-Vm7b5-IM7 in A#
    find-progression CM7-Am7-D7-Gb6/9-D9-CM11-C+13
  COMMANDS
             .each do |command|
    it "#{command} should not return an error" do
      expect(`coltrane #{command}`)
        .to_not match(/error/i), -> { `coltrane #{command} --trace` }
    end
  end
end
