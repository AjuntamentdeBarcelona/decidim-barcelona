# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "decidim-dataviz"
  s.summary = "A dataviz component for decidim's participatory processes."
  s.description = s.summary
  s.required_ruby_version = ">= 3.0"
  s.version = "0.0.2"
  s.authors = ["David Morcillo Muñoz"]
  s.email = ["david.morcillo@gmail.com"]

  s.files = Dir["{app,config,db,lib}/**/*", "Rakefile", "README.md"]

  s.add_dependency "decidim-core"

  s.add_development_dependency "decidim-dev"
  s.metadata["rubygems_mfa_required"] = "true"
end
