# frozen_string_literal: true

$LOAD_PATH.unshift(File.expand_path("lib", __dir__))
require "active_cleaner/version"

Gem::Specification.new do |s|
  s.name = "activecleaner"
  s.version = ActiveCleaner::Version::STRING
  s.date = Time.now.strftime("%Y-%m-%d")

  s.authors = ["Maxime Garcia"]
  s.email = ["maxime.garcia@gmail.com"]

  s.summary = "Clean the fields in your models"
  s.homepage = "http://github.com/maximeg/activecleaner"

  s.license = "MIT"

  s.files = %w[README.md LICENSE]
  s.files += Dir.glob("lib/**/*")
  s.require_paths = ["lib"]
  s.test_files = Dir.glob("spec/**/*")

  s.required_ruby_version = ">= 2.3.0"

  s.add_runtime_dependency("activemodel", ">= 4.2", "< 6.1")
  s.add_runtime_dependency("activesupport", ">= 4.2", "< 6.1")

  s.add_development_dependency("appraisal", "~> 2.2")
  s.add_development_dependency("rspec", "~> 3.4")
  s.add_development_dependency("rubocop", "0.75.0")
  s.add_development_dependency("rubocop-performance", "1.5.0")

  s.description = <<-TXT
    ActiveCleaner is a set of helpers that helps you in cleaning user-typed content in your ActiveModel depending models (ActiveRecord, Mongoid...)
  TXT
end
