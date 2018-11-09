lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "code_care/version"

Gem::Specification.new do |spec|
  spec.name          = "code_care"
  spec.version       = CodeCare::VERSION
  spec.authors       = ["reinteractive"]
  spec.email         = ["team@reinteractive.com"]

  spec.summary       = "Provides common setup used for CodeCare apps"
  spec.homepage      = "https://github.com/reinteractive/CodeCareGem"
  spec.license       = "MIT"

  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path("..", __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "bullet", ">= 0"
  spec.add_dependency "guard-rspec", ">= 0"
  spec.add_dependency "pry-byebug", ">= 0"
  spec.add_dependency "pry-rails", ">= 0"
  # reinteractive-style includes rubocop dependency
  spec.add_dependency "reinteractive-style", "~> 0"
  spec.add_dependency "simplecov", ">= 0"
  spec.add_dependency "spring-commands-rspec", ">= 0"
end
