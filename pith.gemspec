$: << File.expand_path("../lib", __FILE__)
require "pith/version"

description = <<TEXT
Pith builds static websites, using markup/template languages including Haml, Sass, ERb, Liquid, Markdown and Textile.
TEXT

Gem::Specification.new do |gem|

  gem.name = "pith"
  gem.summary = "A static website generator"
  gem.description = description
  gem.homepage = "http://github.com/mdub/pith"
  gem.authors = ["Mike Williams"]
  gem.email = "mdub@dogbiscuit.org"

  gem.version = Pith::VERSION.dup
  gem.platform = Gem::Platform::RUBY

  gem.add_runtime_dependency("tilt", ">= 1.3")
  gem.add_runtime_dependency("rack", ">= 1.2.1")
  gem.add_runtime_dependency("thin", ">= 1.2.7")
  gem.add_runtime_dependency("clamp", ">= 0.3.0")

  gem.add_runtime_dependency("haml", ">= 3.1.3")
  gem.add_runtime_dependency("sass", ">= 3.1.10")
  gem.add_runtime_dependency("RedCloth", ">= 4.1.1")
  gem.add_runtime_dependency("rdiscount", ">= 1.6.8")

  gem.require_path = "lib"
  gem.files = Dir["lib/**/*", "sample/**/*", "README.markdown", "LICENSE"]
  gem.test_files = Dir["Rakefile", "spec/**/*", "features/**/*", "cucumber.yml"]
  gem.executables = ["pith"]

end
