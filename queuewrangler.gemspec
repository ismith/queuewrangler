# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'queuewrangler/version'

Gem::Specification.new do |spec|
  spec.name          = "queuewrangler"
  spec.version       = QueueWrangler::VERSION
  spec.authors       = ["R. Tyler Croy, Shaw Vrana"]
  spec.email         = ["shaw@lookout.com"]
  spec.description   = %q{Easily create long running background actions}
  spec.summary       = %q{Make deffering action easy}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
