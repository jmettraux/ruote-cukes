# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run the gemspec command
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{ruote-cukes}
  s.version = "2.1.9"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Mettraux"]
  s.date = %q{2010-06-14}
  s.description = %q{
cucumber helpers (steps) for testing ruote process definitions and participants
    }
  s.email = %q{jmettraux@gmail.com}
  s.extra_rdoc_files = [
    "README.rdoc"
  ]
  s.files = [
    "CHANGELOG.txt",
     "CREDITS.txt",
     "README.rdoc",
     "Rakefile",
     "TODO.txt",
     "features/basic.feature",
     "features/embedded.feature",
     "features/fields_and_json.feature",
     "features/initial_fields.feature",
     "features/over.feature",
     "features/reply.feature",
     "features/step_definitions/requiring.rb",
     "features/update.feature",
     "features/when.feature",
     "features/whole.feature",
     "flows/a.rb",
     "flows/a_to_b.rb",
     "lib/ruote/cukes.rb",
     "lib/ruote/cukes/version.rb",
     "ruote-cukes.gemspec"
  ]
  s.homepage = %q{http://ruote.rubyforge.org}
  s.rdoc_options = ["--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{ruote}
  s.rubygems_version = %q{1.3.6}
  s.summary = %q{cucumber helpers for testing ruote definitions and participants}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<ruote>, [">= 2.1.9"])
      s.add_runtime_dependency(%q<cucumber>, [">= 0"])
      s.add_development_dependency(%q<rake>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
    else
      s.add_dependency(%q<ruote>, [">= 2.1.9"])
      s.add_dependency(%q<cucumber>, [">= 0"])
      s.add_dependency(%q<rake>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
    end
  else
    s.add_dependency(%q<ruote>, [">= 2.1.9"])
    s.add_dependency(%q<cucumber>, [">= 0"])
    s.add_dependency(%q<rake>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
  end
end

