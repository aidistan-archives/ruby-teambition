lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'teambition/version'

Gem::Specification.new do |spec|
  spec.name          = 'teambition'
  spec.version       = Teambition::VERSION
  spec.authors       = ['Aidi Stan']
  spec.email         = ['aidistan@live.com']
  spec.summary       = 'Ruby wrapper of Teambition API'
  spec.description   = 'A simple Ruby wrapper of Teambition API, shipped with Rails support.'
  spec.homepage      = 'https://github.com/aidistan/ruby-teambition'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_runtime_dependency 'activesupport', '>= 4.2'
  spec.add_development_dependency 'bundler', '>= 1.7'
  spec.add_development_dependency 'highline', '~> 1.7.3'
  spec.add_development_dependency 'rake', '>= 12.0'
  spec.add_development_dependency 'rspec', '~> 3.4'
  spec.add_development_dependency 'simplecov', '~> 0.10'
end
