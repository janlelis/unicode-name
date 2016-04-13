# -*- encoding: utf-8 -*-

require File.dirname(__FILE__) + "/lib/unicode/name/constants"

Gem::Specification.new do |gem|
  gem.name          = "unicode-name"
  gem.version       = Unicode::Name::VERSION
  gem.summary       = "Returns the name and aliases of a Unicode codepoint/character"
  gem.description   = "[Unicode version: #{Unicode::Name::UNICODE_VERSION}] Returns the name and aliases of a Unicode codepoint/character"
  gem.authors       = ["Jan Lelis"]
  gem.email         = ["mail@janlelis.de"]
  gem.homepage      = "https://github.com/janlelis/unicode-name"
  gem.license       = "MIT"

  gem.files         = Dir["{**/}{.*,*}"].select{ |path| File.file?(path) && path !~ /^pkg/ }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = "~> 2.0"
end
