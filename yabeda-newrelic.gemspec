# frozen_string_literal: true

lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "yabeda/newrelic/version"

Gem::Specification.new do |spec|
  spec.name    = "yabeda-newrelic"
  spec.version = Yabeda::NewRelic::VERSION
  spec.authors = ["Andrey Novikov"]
  spec.email   = ["envek@envek.name"]

  spec.summary = "NewRelic adapter for reporting metrics from Yabeda suite"
  spec.description = <<~DESCRIPTION
    Adapter for reporting custom metrics from Yabeda to the NewRelic Insights.
  DESCRIPTION
  spec.homepage = "https://github.com/yabeda-rb/yabeda-newrelic"
  spec.license  = "MIT"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/yabeda-rb/yabeda-newrelic"
  spec.metadata["changelog_uri"] = "https://github.com/yabeda-rb/yabeda-newrelic/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "newrelic_rpm", ">= 5.0"
  spec.add_dependency "yabeda", "~> 0.1"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
