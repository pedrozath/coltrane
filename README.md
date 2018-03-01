# Coltrane

A music calculation library/CLI written in Ruby.

![Coltrane](img/coltrane-logo.png)

* [How to use this library](https://github.com/pedrozath/coltrane/wiki/Core-music-theory-library).
* [Why did I wrote this library](https://medium.com/@pedrozath/so-i-wrote-a-library-to-help-me-compose-music-ddb4ae7c8227).
* [Chat room for discussing the project, answering questions, etc.](https://gitter.im/coltrane-music/Lobby)

## CLI (Command Line Interface)

![Screenshot](img/using-coltrane.gif)
![Screenshot](img/guitar-chords.png)

## Features

* Generate chord progressions for Jazz, Blues, Pop, or custom and see how to play them
* Seek chords, see their notes and how to play them
* Seek scales, see their notes and see how to play them
* Find chords that are common between 2 scales
* Find scales containing a chord or a set of notes
* Find possible progressions of a chord sequence
* All of the above can be seen on guitar, bass, piano or ukelele representations, no sheet music needed

## Installation

```bash
$ gem install coltrane
```

PS: Once you install the gem the CLI is instaled in your system and it's ready to be used.

## Changelog

[See the changelog](CHANGELOG.md)

## Contributing

We are looking for contributors. Find me on [our chatroom](https://gitter.im/coltrane-music/Lobby) if you need any kind of information.

### How to contribute
1. Fork this code
2. Install the test suite (RSpec) by running good old `bundle` command
3. Make your changes and maybe write a test or two.
4. Check if specs pass `bundle exec rspec spec`
5. Submit a PR.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

by Pedro Maciel | [twitter](http://twitter.com/pedrozath) | pedro@pedromaciel.com