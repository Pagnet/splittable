require_relative 'lib/splittable/version'

Gem::Specification.new do |spec|
  spec.name          = "splittable"
  spec.version       = Splittable::VERSION
  spec.authors       = ["Arthur Brandão"]
  spec.email         = ["arthur.brandao@useblu.com.br"]

  spec.summary       = "Calculate division and normalize parcels to Blu`s projects."
  spec.description   = "Calculate division and normalize parcels to Blu`s projects."
  spec.homepage      = "https://github.com/Pagnet/pagnet"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.6")

  spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/Pagnet/pagnet"
  # spec.metadata["changelog_uri"] = "TODO: Put your gem's CHANGELOG.md URL here."
  spec.metadata["changelog_uri"] = "https://github.com/Pagnet/pagnet"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
end
