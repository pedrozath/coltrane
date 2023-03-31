# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'coltrane/version'

Gem::Specification.new do |spec|
  spec.name          = "coltrane"
  spec.version       = Coltrane::VERSION
  spec.authors       = ["Pedro Maciel"]
  spec.email         = ["pedro@pedromaciel.com"]

  spec.summary       = %q{It deals with all sorts of calculations around music theory
                          and allows for graphical representations of it}
  spec.homepage      = "http://github.com/pedrozath/coltrane"
  spec.license       = "MIT"

  spec.required_ruby_version = '>= 2.5'

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features|img)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'dry-monads',  '~> 0.4'
  spec.add_runtime_dependency 'gambiarra',   '= 0.0.6'
  spec.add_runtime_dependency 'paint',       '~> 2.0'
  spec.add_runtime_dependency 'color',       '~> 1.8'
  spec.add_runtime_dependency 'activesupport', '> 5.2'
  spec.add_development_dependency "bundler",   '~> 2.2.5'
  spec.add_development_dependency "rake",      '~> 13.0'
end
