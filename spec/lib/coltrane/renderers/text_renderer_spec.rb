RSpec.describe TextRenderer do
  # it 'fetches the class using the model class' do
  #   expect(
  #     TextRenderer.send(:renderer_class, NoteSet['A', 'B'].class.name).value
  #   ).to eq(Coltrane::Renderers::TextRenderer::TheoryNoteSet)
  # end

  unless ENV['SKIP_HUMAN_TESTS']
    RSpec.shared_examples 'rendering' do |model_code, **options|
      it "renders #{model_code} fine" do
        puts <<~EOF



        We're gonna render with the options #{options.inspect} the following code:

        #{model_code}

        ---- rendering starts here ---

        #{TextRenderer.render(eval(model_code), **options)}

        ---- rendering ends here ---



        EOF

        expect(
          TTY::Prompt
            .new
            .keypress(
              'Press any key if the input above looks wrong or just wait',
              timeout: 2
            )
        ).to be_nil
    end
  end

  # it_behaves_like 'rendering', "NoteSet['A#', 'Db', 'E', 'F#', 'C']"
  # it_behaves_like 'rendering', "NoteSet['A#', 'Db', 'E', 'F#', 'C']", flavor: :intervals
  # it_behaves_like 'rendering', "Chord.new(name: 'Cm7')"
  # it_behaves_like 'rendering', "Scale.major('C')"
  # it_behaves_like 'rendering', "Scale.having_notes(NoteSet['C', 'A', 'G'])"
  # it_behaves_like 'rendering', "Progression.jazz('D#')"
  # it_behaves_like 'rendering', "Progression.find(*%w[AM DM F#m EM])"
  # it_behaves_like 'rendering', "Guitar.find_notes(NoteSet['C', 'A', 'G'])"
  # it_behaves_like 'rendering', "Guitar.find_notes(NoteSet['C', 'A', 'G'])", flavor: :intervals
  # it_behaves_like 'rendering', "Guitar.find_notes(NoteSet['C', 'A', 'G'])", flavor: :marks
  # it_behaves_like 'rendering', "Guitar.find_notes(NoteSet['C', 'A', 'G'])", flavor: :degrees
  # it_behaves_like 'rendering', "Guitar.find_chords('C6/9').first(6)", layout: :horizontal, per_row: 7
  # it_behaves_like 'rendering', "Ukulele.find_notes(NoteSet['C', 'A', 'G'])", flavor: :degrees
  # it_behaves_like 'rendering', "Bass.find_notes(NoteSet['C', 'A', 'G'])", flavor: :degrees
  it_behaves_like 'rendering', "Piano.find_notes(NoteSet['C', 'A', 'G'])"
  it_behaves_like 'rendering', "Piano.find_notes(NoteSet['C', 'A', 'G'])", flavor: :intervals
  it_behaves_like 'rendering', "Piano.find_notes(NoteSet['C', 'A', 'G'])", flavor: :degrees
  it_behaves_like 'rendering', "Piano.chord('Cm7')"
  end
end
