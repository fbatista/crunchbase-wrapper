# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'crunchbase/version'

Gem::Specification.new do |spec|
  spec.name          = "crunchbase-wrapper"
  spec.version       = Crunchbase::VERSION
  spec.authors       = ["Fábio Batista"]
  spec.email         = ["fbatista@gmail.com"]
  spec.description   = %q{A Ruby Wrapper for the Crunchbase v2 REST API}
  spec.summary       = %q{A Ruby Wrapper for the Crunchbase v2 REST API}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_development_dependency "minitest"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "webmock"

  spec.add_dependency "faraday"
  spec.add_dependency "json"
  spec.add_dependency "hashie"
end
