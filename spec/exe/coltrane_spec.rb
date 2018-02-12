# # frozen_string_literal: true

# require 'spec_helper'

# describe 'coltrane' do
#   ENV['TERM_PROGRAM'] = 'Unsupported'

#   let!(:cmd1) { 'coltrane' }

#   describe 'notes' do
#     let!(:cmd2) { cmd1 + ' notes' }

#     context 'non-empty notes' do
#       let!(:cmd3) { cmd2 + ' C-D-E' }
#       subject { `#{cmd3}` }

#       it { is_expected.to include('C', 'D') }
#       it { is_expected.to_not include('C#') }

#       context('on guitar') do
#         let!(:cmd4) { cmd3 + ' --on guitar' }
#         subject { `#{cmd4}` }

#         it { is_expected.to_not include('Error') }
#       end
#     end
#   end

#   describe 'scale' do
#     let!(:cmd2) { cmd1 + ' scale' }

#     context('with a scale provided') do
#       let!(:cmd3) { cmd2 + ' harmonic-minor-d' }
#       subject { `#{cmd3}` }

#       it { is_expected.to include('D E F G A A♯ C♯') }

#       context('on ukelele') do
#         let!(:cmd4) { cmd3 + ' --on ukelele' }
#         subject { `#{cmd4}` }
#         it { is_expected.to include <<~OUTPUT }
#           A 05 | 06 -- -- 07 01 -- 02 03 -- 04 -- 05
#           E 02 | 03 -- 04 -- 05 06 -- -- 07 01 -- 02
#           C -- | 07 01 -- 02 03 -- 04 -- 05 06 -- --
#           G 04 | -- 05 06 -- -- 07 01 -- 02 03 -- 04
#         OUTPUT

#         context('with degrees flavor') do
#           let!(:cmd5) { cmd4 + ' --flavor intervals' }
#           subject { `#{cmd5}` }

#           it { is_expected.to include <<~OUTPUT }
#             A 5P | 6m -- -- 7M 1P -- 2M 3m -- 4P -- 5P
#             E 2M | 3m -- 4P -- 5P 6m -- -- 7M 1P -- 2M
#             C -- | 7M 1P -- 2M 3m -- 4P -- 5P 6m -- --
#             G 4P | -- 5P 6m -- -- 7M 1P -- 2M 3m -- 4P
#           OUTPUT
#         end
#       end
#     end
#   end

#   describe 'find-scale' do
#     let!(:cmd2) { cmd1 + ' find-scale' }

#     context('using notes') do
#       let!(:cmd3) { cmd2 + ' --notes C-D-E-F-G' }
#       subject { `#{cmd3}` }

#       it { is_expected.to include *<<~OUTPUT.split("\n") }
#         Major            C(5) C#(2) D(3) D#(4) E(1) F(5) F#(1) G(4) G#(3) A(2) A#(4) B(1)
#         Pentatonic Major C(4) C#(1) D(2) D#(3) E(1) F(4) F#(0) G(3) G#(2) A(1) A#(4) B(0)
#         Blues Major      C(4) C#(2) D(3) D#(3) E(2) F(4) F#(0) G(3) G#(2) A(2) A#(4) B(1)
#         Natural Minor    C(4) C#(1) D(5) D#(1) E(4) F(3) F#(2) G(4) G#(1) A(5) A#(2) B(3)
#       OUTPUT
#     end

#     context('using chords') do
#       let!(:cmd3) { cmd2 + ' --chords Cmaj7' }
#       subject { `#{cmd3}` }

#       it { is_expected.to include *<<~OUTPUT.split("\n") }
#         Major            C(4) C#(1) D(3) D#(2) E(2) F(3) F#(1) G(4) G#(2) A(2) A#(2) B(2)
#         Pentatonic Major C(3) C#(0) D(2) D#(2) E(2) F(2) F#(0) G(3) G#(1) A(2) A#(2) B(1)
#         Blues Major      C(3) C#(1) D(2) D#(2) E(3) F(2) F#(0) G(3) G#(2) A(3) A#(2) B(1)
#         Natural Minor    C(2) C#(2) D(3) D#(1) E(4) F(2) F#(2) G(2) G#(2) A(4) A#(1) B(3)
#         Harmonic Minor   C(3) C#(2) D(2) D#(1) E(4) F(3) F#(1) G(2) G#(3) A(3) A#(1) B(3)
#       OUTPUT
#     end
#   end

#   describe 'chord' do
#     let!(:cmd2) { cmd1 + ' chord' }
#     context('using chord') do
#       let!(:cmd3) { cmd2 + ' Cmaj7' }
#       subject { `#{cmd3}` }

#       it { is_expected.to include 'C E G B' }
#     end

#     context('using notes') do
#       let!(:cmd3) { cmd2 + ' --notes C-E-G' }
#       subject { `#{cmd3}` }

#       it { is_expected.to include 'CM' }
#     end
#   end
# end
