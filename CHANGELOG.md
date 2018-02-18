# Changelog

## [Unreleased]
- Correct Flat/Sharp on scales
- Refactor notes and add pitch frequencies, pitch classes

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
