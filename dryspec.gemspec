lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'dryspec/version'

Gem::Specification.new do |spec|
  spec.name          = 'dryspec'
  spec.version       = DRYSpec::VERSION
  spec.authors       = ['Team Northwoods']
  spec.email         = ['brian.underwood@teamnorthwoods.com']

  spec.summary       = 'A Ruby gem to introduce RSpec helpers which can help you DRY up your specs'
  spec.description   = 'A Ruby gem to introduce RSpec helpers which can help you DRY up your specs'
  spec.homepage      = 'https://github.com/northwoodspd/dryspec'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.7.0'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '>= 2.2.33'
  spec.add_development_dependency 'guard-rspec', '~> 4.7.3'
  spec.add_development_dependency 'guard-rubocop', '~> 1.5.0'
  spec.add_development_dependency 'guard-yard', '~> 2.2.0'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rspec_junit_formatter', '~> 0.5.1'
  spec.add_development_dependency 'yard', '~> 0.9.9'
end
