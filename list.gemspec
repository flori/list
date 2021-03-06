# -*- encoding: utf-8 -*-
# stub: list 0.0.0 ruby ext lib
# stub: ext/list/extconf.rb

Gem::Specification.new do |s|
  s.name = "list".freeze
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["ext".freeze, "lib".freeze]
  s.authors = ["Florian Frank".freeze]
  s.date = "2017-03-08"
  s.description = "It foos\u2026 mostly".freeze
  s.email = "flori@ping.de".freeze
  s.extensions = ["ext/list/extconf.rb".freeze]
  s.extra_rdoc_files = ["README.md".freeze, "lib/list.rb".freeze, "lib/list/version.rb".freeze, "ext/list/list.c".freeze]
  s.files = [".gitignore".freeze, ".rspec".freeze, ".utilsrc".freeze, "Gemfile".freeze, "README.md".freeze, "Rakefile".freeze, "VERSION".freeze, "examples/random.rb".freeze, "ext/list/extconf.rb".freeze, "ext/list/list.c".freeze, "ext/list/list.h".freeze, "lib/list.rb".freeze, "lib/list/version.rb".freeze, "list.gemspec".freeze, "spec/list_spec.rb".freeze, "spec/spec_helper.rb".freeze]
  s.homepage = "http://github.com/flori/list".freeze
  s.rdoc_options = ["--title".freeze, "List - A list extension".freeze, "--main".freeze, "README.md".freeze]
  s.rubygems_version = "2.6.10".freeze
  s.summary = "A list extension".freeze
  s.test_files = ["spec/list_spec.rb".freeze, "spec/spec_helper.rb".freeze]

  if s.respond_to? :specification_version then
    s.specification_version = 4

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<gem_hadar>.freeze, ["~> 1.9.1"])
      s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    else
      s.add_dependency(%q<gem_hadar>.freeze, ["~> 1.9.1"])
      s.add_dependency(%q<rspec>.freeze, [">= 0"])
    end
  else
    s.add_dependency(%q<gem_hadar>.freeze, ["~> 1.9.1"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
  end
end
