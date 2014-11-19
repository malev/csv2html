# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'csv2html/version'

Gem::Specification.new do |spec|
  spec.name          = "csv2html"
  spec.version       = Csv2html::VERSION
  spec.authors       = ["Marcos Vanetta"]
  spec.email         = ["marcosvanetta@gmail.com"]
  spec.summary       = %q{Take a CSV file and make it a HTML table}
  spec.description   = %q{Take a CSV file and make it a HTML table}
  spec.homepage      = "http://codingnews.info"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"
end
