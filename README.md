# Coltrane

A musical abacus written in ruby.

More info, story and purpose of the library:
https://medium.com/@pedrozath/so-i-wrote-a-library-to-help-me-compose-music-ddb4ae7c8227

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'coltrane'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install coltrane

## CLI (Command Line Interface)

When you install the gem on your system, you automatically gain access to the
CLI.

You can run it on terminal:

```bash
$ coltrane help
```

## Roadmap

There's a lot of things that need to be done on this library, specially on the CLI:

+ Refactor the CLI into a more succinct and elegantly organized architecture
+ Amplify the test coverage
+ Move Scale#chords method to NoteSet
+ Write tests for the caching
+ Write up a caching cleaning command
+ Include CLI commands to output chord progressions
+ Include a command to output a pretty HTML document containing the query

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

