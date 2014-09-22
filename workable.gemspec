$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "workable/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "workable"
  s.version     = Workable::Version::STRING
  s.authors     = ["Shawn Catanzarite"]
  s.email       = ["me@shawncatz.com"]
  s.homepage    = "https://github.com/shawncatz/workable"
  s.summary     = "Common workers code"
  s.description = "Common workers code"
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 4.1.6"

  s.add_dependency 'activesupport', '~> 4.1.6'

  s.add_dependency 'sidekiq', '~> 3.2.2'
  s.add_dependency 'sidekiq-failures', '~> 0.4.3'
  s.add_dependency 'sidekiq-scheduler', '~> 1'
  s.add_dependency 'sinatra', '~> 1.4.5'
  s.add_dependency 'slim', '~> 2.0.3'

  s.add_development_dependency "sqlite3"
end
