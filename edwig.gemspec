# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "edwig/version"

Gem::Specification.new do |spec|
  spec.name          = "edwig"
  spec.version       = Edwig::VERSION
  spec.authors       = ["af83 dev team"]
  spec.email         = ["devs+gem@af83.com"]

  spec.summary       = %q{Ruby tools for Edwig, a real-time server for transport}
  spec.description   = %q{Provides Ruby SDK for Edwig API and munin plugins}
  spec.homepage      = "http://github.com/af83/edwig"
  spec.license       = "Apache-2.0"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_dependency 'rest-client'
  spec.add_dependency 'json'
end
