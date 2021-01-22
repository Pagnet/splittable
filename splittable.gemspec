# frozen_string_literal: true

require_relative 'lib/splittable/version'

Gem::Specification.new do |spec|
  spec.name          = 'splittable'
  spec.version       = Splittable::VERSION
  spec.authors       = ['Arthur Brandão', 'Marcelo Toledo']
  spec.email         = ['arthur_aebc@hotmail.com', 'marcelotoledo5000@gmail.com']

  spec.license       = 'MIT'

  spec.summary       = 'Calculate division and normalize parcels.'
  spec.description   = 'Calculate division and normalize parcels to use just cents.'
  spec.homepage      = 'https://github.com/Pagnet/splittable'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.5.3')

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/Pagnet/splittable'
  spec.metadata['changelog_uri'] = 'https://github.com/Pagnet/splittable/blob/master/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']
end
