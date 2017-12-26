# frozen_string_literal: true

require "bundler"
Bundler.setup

require "rake"
require "rspec/core/rake_task"

$LOAD_PATH.unshift(File.expand_path("../lib", __FILE__))
require "active_cleaner/version"
VERSION = ActiveCleaner::Version::STRING

task gem: :build
task :build do
  system "gem build activecleaner.gemspec"
end

task release: :build do
  system "git tag -a #{VERSION} -m 'Version #{VERSION}'"
  system "git push --tags"
  system "gem push activecleaner-#{VERSION}.gem"
end

RSpec::Core::RakeTask.new("spec") do |spec|
  spec.pattern = "spec/**/*_spec.rb"
end

RSpec::Core::RakeTask.new("spec:progress") do |spec|
  spec.rspec_opts = %w[--format progress]
  spec.pattern = "spec/**/*_spec.rb"
end

task default: :spec

#
# Documentation
#
require "sdoc"
require "rdoc/task"

class MyRDocTask < RDoc::Task

  def option_list
    super.tap do |list|
      list << "--github"
    end
  end

end

MyRDocTask.new(rdoc: "doc", clobber_rdoc: "doc:clobber", rerdoc: "doc:force") do |rdoc|
  rdoc.generator = "sdoc"
  rdoc.template = "rails"

  rdoc.title = "ActiveCleaner API"

  rdoc.main = "README.md"
  rdoc.rdoc_dir = "doc"
  rdoc.rdoc_files.add("lib/**/*.rb", "*.md")
  rdoc.options << "--all"
end
