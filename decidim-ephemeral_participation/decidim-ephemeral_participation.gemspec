# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "decidim-ephemeral_participation"
  s.summary = "A decidim module that allows users to participate without registration."
  s.description = s.summary
  s.required_ruby_version = ">= 3.1"
  s.version = "0.0.4"
  s.authors = ["Ivan Vergés"]
  s.email = ["ivan@platoniq.net"]

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]

  s.add_dependency "decidim-verifications", "~> 0.28.0"

  s.add_development_dependency "decidim-dev", "~> 0.28.0"
  s.metadata["rubygems_mfa_required"] = "true"
end
