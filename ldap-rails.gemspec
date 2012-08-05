$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "ldap-rails/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "ldap-rails"
  s.version     = LdapRails::VERSION
  s.authors     = ["Ben Weissmann"]
  s.email       = ["ben@benweissmann.com"]
  s.homepage    = "http://github.com/benweissmann/ldap-rails"
  s.summary     = "Radically simple LDAP authentication for Rails."
  s.description = "Generator that enabled LDAP authentication with a single command."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["LICENSE.txt", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.0"
  s.add_dependency "net-ldap", "~> 0.3.1"

  s.add_development_dependency "sqlite3"
end
