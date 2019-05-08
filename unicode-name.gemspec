# -*- encoding: utf-8 -*-

require File.dirname(__FILE__) + "/lib/unicode/name/constants"

Gem::Specification.new do |gem|
  gem.name          = "unicode-name"
  gem.version       = Unicode::Name::VERSION
  gem.summary       = "Returns name/aliases/label of a Unicode codepoint"
  gem.description   = "[Unicode #{Unicode::Name::UNICODE_VERSION}] Returns name/aliases/label of a Unicode codepoint"
  gem.authors       = ["Jan Lelis"]
  gem.email         = ["mail@janlelis.de"]
  gem.homepage      = "https://github.com/janlelis/unicode-name"
  gem.license       = "MIT"

  gem.files         = Dir["{**/}{.*,*}"].select{ |path| File.file?(path) && path !~ /^pkg/ }
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.required_ruby_version = "~> 2.0"
  gem.add_dependency "unicode-types", "~> 1.5"
end
