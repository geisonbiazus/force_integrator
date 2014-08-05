# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'force_integrator/version'

Gem::Specification.new do |spec|
  spec.add_dependency 'databasedotcom'
  spec.name          = "force_integrator"
  spec.version       = ForceIntegrator::VERSION
  spec.authors       = ["Geison Biazus"]
  spec.email         = ["geisonbiazus@gmail.com"]
  spec.summary       = "Gem to integrate an Rails App with Salesforce"
  spec.description   = "Gem to integrate an Rails App with Salesforce"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.6"
  spec.add_development_dependency "rake"
end
