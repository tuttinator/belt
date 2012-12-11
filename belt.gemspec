# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'belt/version'

Gem::Specification.new do |gem|
  gem.name          = "belt"
  gem.version       = Belt::VERSION
  gem.authors       = ["Caleb"]
  gem.email         = ["caleb@onebigvoice.com"]
  gem.description   = %q{Holy utility belt, Batman! A CLI server tasks with Chef and Capistrano integration}
  gem.summary       = %q{Holy utility belt, Batman! A CLI server tasks with with Chef powers, DNS API integration, Capistrano integration and assorted goodness for managing servers.}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency('rdoc')
  gem.add_development_dependency('aruba')
  gem.add_development_dependency('rake', '~> 0.9.2')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('pry')
  gem.add_dependency('methadone', '~> 1.2.3')
  gem.add_dependency('clickatell')
  gem.add_dependency('httparty')
  gem.add_dependency('zonomi')
  gem.add_dependency('colored')
  gem.add_dependency('capistrano')
  gem.add_dependency('rvm-capistrano')
  gem.add_dependency('capistrano-ext')
  gem.add_dependency('fog')
end
