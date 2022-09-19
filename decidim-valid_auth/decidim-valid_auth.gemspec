# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "decidim-valid_auth"
  s.summary = "A valid_auth component for decidim's participatory processes."
  s.description = s.summary
  s.required_ruby_version = ">= 2.7"
  s.version = "0.0.1"
  s.authors = ["Marc Riera Casals"]
  s.email = ["mrc2407@gmail.com"]

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]

  s.add_dependency "decidim-verifications"

  s.add_development_dependency "decidim-dev"
end
