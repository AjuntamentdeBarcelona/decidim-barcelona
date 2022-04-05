# frozen_string_literal: true
$LOAD_PATH.push File.expand_path("../lib", __FILE__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "decidim-ephemeral_participation"
  s.summary     = "A decidim module that allows users to participate without registration."
  s.description = s.summary
  s.version     = "0.0.2"
  s.authors     = ["Ivan Vergés"]
  s.email       = ["ivan@platoniq.net"]

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]

  s.add_dependency "decidim-verifications"

  s.add_development_dependency "decidim-dev"
end
