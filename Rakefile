# frozen_string_literal: true

require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "rubocop/rake_task"

RSpec::Core::RakeTask.new(:spec)
RuboCop::RakeTask.new

task default: :spec

task ci: %i[spec rubocop]

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
