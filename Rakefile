# encoding: utf-8
require "rubygems"
require "rubygems/package_task"
require "rake/testtask"

Rake::TestTask.new do |t|
  t.libs << "test"
  t.test_files = FileList["test/**/*_test.rb"]
  t.verbose = true
end

task :default => ["test"]

# This builds the actual gem. For details of what all these options
# mean, and other ones you can add, check the documentation here:
#
#   http://rubygems.org/read/chapter/20
#

AUTHORS = [
  ["Johnny Diligente", "johnny.purist@gmail.com"]
]

spec = Gem::Specification.new do |s|

  # Change these as appropriate
  s.name              = "ruby-enum-attr"
  s.version           = "0.1.0"
  s.summary           = "enums for ruby"
  s.authors           = AUTHORS.map{ |name, email| name }
  s.email             = AUTHORS.map{ |name, email| email }
  s.homepage          = "https://github.com/purist/ruby-enum-attr"

  s.has_rdoc          = true
  # You should probably have a README of some kind. Change the filename
  # as appropriate
  s.extra_rdoc_files  = %w(README.md)
  s.rdoc_options      = %w(--main README.md)

  # Add any extra files to include in the gem (like your README)
  s.files             = %w(README.md) + Dir.glob("{test,lib}/**/*")
  s.require_paths     = ["lib"]

  # If you want to depend on other gems, add them here, along with any
  # relevant versions
  # s.add_dependency("some_other_gem", "~> 0.1.0")

  # If your tests use any gems, include them here
  # s.add_development_dependency("mocha") # for example
end

# This task actually builds the gem. We also regenerate a static
# .gemspec file, which is useful if something (i.e. GitHub) will
# be automatically building a gem for this project. If you're not
# using GitHub, edit as appropriate.
#
# To publish your gem online, install the 'gemcutter' gem; Read more
# about that here: http://gemcutter.org/pages/gem_docs
Gem::PackageTask.new(spec) do |pkg|
  pkg.gem_spec = spec
end

desc "Build the gemspec file #{spec.name}.gemspec"
task :gemspec do
  file = File.dirname(__FILE__) + "/#{spec.name}.gemspec"
  File.open(file, "w") {|f| f << spec.to_ruby }
end

# If you don't want to generate the .gemspec file, just remove this line. Reasons
# why you might want to generate a gemspec:
#  - using bundler with a git source
#  - building the gem without rake (i.e. gem build blah.gemspec)
#  - maybe others?
task :package => :gemspec

begin
  require "rdoc/task"

  # Generate documentation
  RDoc::Task.new do |rd|
    rd.rdoc_files.include("lib/**/*.rb")
    rd.rdoc_dir = "rdoc"
  end

  desc 'Clear out RDoc and generated packages'
  task :clean => [:clobber_rdoc, :clobber_package] do
    rm "#{spec.name}.gemspec"
  end
rescue LoadError => e
  warn e.message
end
