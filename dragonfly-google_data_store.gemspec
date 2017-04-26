# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dragonfly/google_data_store/version'

Gem::Specification.new do |spec|
  spec.name          = "dragonfly-google_data_store"
  spec.version       = Dragonfly::GoogleDataStore::VERSION
  spec.authors       = ["Raffael Schmid"]
  spec.email         = ["raffael@yux.ch"]

  spec.summary       = %q{A data store for dragonfly using google cloud}
  spec.homepage      = "https://github.com/wtag/dragonfly-google_data_store"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'dragonfly', '~> 1.1'
  spec.add_dependency 'google-cloud-storage', '~> 1.0'

  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
