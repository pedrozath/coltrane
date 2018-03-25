# Changelog

## [Unreleased]

- Fix chords so that they generate a barre and a non-barre version and prevent
  barre chords from picking notes before the barre.

## [3.0.0]

### Changes

- This is a huge architectural refactor. Hopefully the last big one. All code were redivided into the modules:

  1. Coltrane::Theory concentrates all music theory logic
  2. Coltrane::Representation contain musical instruments and any other needed musical-related abstract representations.
  3. Coltrane::Renderers right now contains the TextRenderer which has the ability of rendering Theory Objects, Representation Objects, etc
  4. Coltrane::Commands are ways of fetching Theory and Representation objects. They also glue Mercenary (the gem used for the CLI) into everything else.

## [2.2.0]

- Intervals were completely refactored according to [#11](https://github.com/pedrozath/coltrane/issues/11) and (https://github.com/pedrozath/coltrane/issues/12). Thanks [@art-of-dom](https://github.com/art-of-dom) for the valuable information. We now have new interval classes and new ways on how to deal with them.
  Check the [wiki](https://github.com/pedrozath/coltrane/wiki) for more details.

## [2.1.0]

- Correct Flat/Sharp on Diatonic Scales

- Fix chords so that they generate a barre and a non-barre version and prevent
  barre chords from picking notes before the barre.

### Adds

- Pitches and Voicings. Pitches are a way of expressing notes in a specific
  octave. Voicings are a way of expressing a chord with the exact pitches

- Introduces a little sound synthesizer (experimental, macOS-only).
  Use `--sound` to activate it wherever the program outputs chords.

- Introduces some modules classes to provide Guitar Chord finding.
  `ColtraneInstruments::Guitar::Base.find('C6/9')`

- Introduces DiatonicScale and Key classes.

### Changes

- Guitar Chords are now outputted using the default guitar chord notation

## [2.0.0]

### Changes

- Code has been completely refactored. Things are organized around frequencies.
  Intervals are backed by cents, which is an logarithmic measure used to measure
  the distance between 2 frequencies.

  We have now a distinction between PitchClass and Note. The first is a generic
  concept of Notes while the latter deals with sharps and flats logic.

  That refactor will allow us to in the next versions refactor scales so that
  they output proper sharps and flats (https://github.com/pedrozath/coltrane/issues/3).

## [1.2.3]

### Fixes

- Bug in `progression` command

## [1.2.2]

### Fixes

- A bug of the previous functionality that generated a infinite loop if a command wasn't found

## [1.2.0]

### Adds
- An interactive mode, so you don't have to type coltrane all the time.
- Adds notable progressions: You can type `coltrane progression jazz in C`
- Adds tritone substitution for chord, for the library only for now `Chord.new(name: 'CM7').tritone_substitution`
- Adds chord unary operators. `+ Note` for adding a note to a chord, `+ Interval or Integer` for transposing the chord
- Adds slash chords `Chord.new(name: 'CM/B')`
- Adds chord `#function` for Roman Chords, when they're on Diatonic Major scale, returning `Dominant, Submediant, Tonic, etc`

### Fixes
- Fixes a bug in Piano

## [1.1.2]

### Fixes
- Progression specs
- Comments out classic progressions for now

### Adds
- `Progression.find(*%w[AM DM F#m EM])`

## [1.1.0]

### Changes
- The qualities are now more procedural, less hardcoded as possible. The refactor
  has caused the chord list shorter. That may be an issue for some users, and if
  so, it should be addressed in next versions. However, I believe that reduces
  the spam, since we are focusing on the more relevant chords, as they're the
  basis for building more "exotic" chords.

- Intervals are now registered and displayed in the english language order.
  Ex: Minor Third was `3m` and now is `m3`.

### Adds
- A lot of helper methods for obtaining interval information! `Interval` has
  methods like `#minor_third?`, `#major_second?`, which are pretty self-explanatory.
  `#full_name` and `#full_names` are also added, the latter returning intervals that
  are pretty much the same, such as Major Second and Major Ninth.
  Interval sequences have methods like `#has_minor_third?` and `#third`, which will
  return the third it has, no matter if its major, or minor.

- Roman Chords and Chord Progressions are finally here! It's a bit experimental yet,
  the latter definitely needs more specs.

### Fixes
- The changelog

## [1.0.25]

### Fixes
- Ruby version on the gemspec

## [1.0.25]

### Removes
- Caching, as after some refactoring it made no sense anymore

### Adds
- Progressions and Roman Chords
- Adds Progression command to the CLI

## [1.0.24]

### Adds
- Some coloring on guitar output
- Chromatic Scale

### Fixes
- Adjusts the marked frets alignment

### Changes
- Removes Natural sign ~padding~ for guitar instruments


## [1.0.23]

### Adds
- A changelog

### Fixes
- #- operation on Note against number
