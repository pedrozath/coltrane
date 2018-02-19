# Coltrane

A musical abacus written in ruby.

![Coltrane](img/coltrane-logo.png)

More info, story and purpose of the library [here](https://medium.com/@pedrozath/so-i-wrote-a-library-to-help-me-compose-music-ddb4ae7c8227).

Chat room for discussing the project, answering questions, etc:
https://gitter.im/coltrane-music/Lobby

## CLI (Command Line Interface)

![Screenshot](img/using-coltrane.gif)

### Installation

#### Compiled binary

There's an experimental compiled version you can [download here](https://raw.githubusercontent.com/pedrozath/coltrane/master/dist/coltrane). It has been tested only macOS High Sierra so far, but it should work on Linux and Windows as well.

macOS & Linux: You probably will need `chmod +x coltrane` before running it.
Windows users: Please add the `.exe` extension to it before running it (via command prompt).

#### Ruby command

```bash
$ gem install coltrane
```

Once you install the gem the CLI is instaled in your system and it's ready to be used.

### Usage

It allows you to query for notes and chords and display them on your favorite instrument. No sheet music reading skills needed. It also allows you to find scales with a chord and find chords shared between two scales (that is actually the main goal when I did this project).

## As a library

Add this line to your application's Gemfile:

```ruby
gem 'coltrane'
```

And then execute:
```sh
$ bundle
```

The whole library will be available under the `Coltrane` module. The CLI code won't be imported to your application as default. Here's a quick example on how to use it:

```ruby
require 'coltrane'

puts Coltrane::Scale.major('C').sevenths.map(&:name)
# => ["CM7", "Dm7", "Em7", "FM7", "G7", "Am7", "Bm7b5"]

puts Coltrane::Scale.having_chord('CM7').scales.map(&:name)
# => ["C Major", "G Major", "E Natural Minor", "A Natural Minor", "E Harmonic Minor", "B Flamenco"]
```

## Changelog

See the changelog [here](CHANGELOG.md)

## Contributing

Install the test suite (RSpec) by running good old `bundle` command

Fork the code, make your changes and maybe write a test or two. Then run:

Then run:
```
bundle exec rspec spec
```

Make sure the specs pass and submit a PR.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

