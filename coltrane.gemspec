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

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency 'facets',      '~> 3.1'
  spec.add_runtime_dependency 'paint',       '~> 2.0'
  spec.add_runtime_dependency 'chroma',      '~> 0.2.0'
  spec.add_runtime_dependency 'mercenary',   '~> 0.3'
  spec.add_development_dependency "bundler", '~> 1.14'
  spec.add_development_dependency "rake",    '~> 10.0'
end
