
require 'lib/ruote/cukes/version.rb'

require 'rubygems'
require 'rake'


begin

  require 'jeweler'

  Jeweler::Tasks.new do |gem|

    gem.version = Ruote::Cukes::VERSION
    gem.name = 'ruote-cukes'
    gem.summary = 'cucumber helpers for testing ruote definitions and participants'
    gem.description = %{
cucumber helpers (steps) for testing ruote process definitions and participants
    }
    gem.email = 'jmettraux@gmail.com'
    gem.homepage = 'http://ruote.rubyforge.org'
    gem.authors = [ 'John Mettraux' ]
    gem.rubyforge_project = 'ruote'
    #gem.test_file = 'test/test.rb'

    gem.add_dependency 'ruote', '>= 2.1.7'
    gem.add_dependency 'cucumber'

    gem.add_development_dependency 'rake'
    gem.add_development_dependency 'jeweler'

    # Gem::Specification http://www.rubygems.org/read/chapter/20
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end

require 'rake/clean'
CLEAN.include('pkg')

task :default => [ :clean ]

