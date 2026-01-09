# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

Gem::Specification.new do |s|
  s.name = "decidim-census_sms"
  s.summary = "A verification workflow for Decidim Barcelona."
  s.description = s.summary
  s.required_ruby_version = ">= 3.1"
  s.version = "0.0.3"
  s.authors = ["Vera Rojman"]
  s.email = ["vera@platoniq.net"]

  s.files = Dir["{app,config,lib}/**/*", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", "~> 0.30.0"

  s.add_development_dependency "decidim-dev", "~> 0.30.0"
  s.metadata["rubygems_mfa_required"] = "true"
end
