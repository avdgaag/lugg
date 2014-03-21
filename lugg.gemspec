# encoding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'lugg/version'

Gem::Specification.new do |spec|
  spec.name          = 'lugg'
  spec.version       = Lugg::VERSION
  spec.authors       = ['Arjan van der Gaag']
  spec.email         = ['arjan@kabisa.nl']
  spec.summary       = %q{Query Rails log files from the command line.}
  spec.description   = <<-EOS
A tiny command line utility to search through Rails server log files and
display requests that meet certain criteria.
EOS
  spec.homepage      = 'http://avdgaa.github.io/lugg'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.5'
  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'yard'
  spec.add_development_dependency 'rubocop'
end
