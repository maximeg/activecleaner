# frozen_string_literal: true

$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "active_cleaner/version"

Gem::Specification.new do |s|
  s.name        = "activecleaner"
  s.version     = ActiveCleaner::Version::STRING
  s.date        = Time.now.strftime("%Y-%m-%d")

  s.authors     = ["Maxime Garcia"]
  s.email       = ["maxime.garcia@gmail.com"]

  s.summary     = "Clean the fields in your models"
  s.homepage    = "http://github.com/maximeg/activecleaner"

  s.license     = "MIT"

  s.files       = %w[README.md LICENSE]
  s.files += Dir.glob("lib/**/*")
  s.require_paths = ["lib"]
  s.test_files  = Dir.glob("spec/**/*")
  s.has_rdoc    = false

  s.required_ruby_version = ">= 2.1.0"

  s.add_runtime_dependency "activemodel", ">= 4.1", "< 5.1"
  s.add_runtime_dependency "activesupport", ">= 4.1", "< 5.1"

  s.add_development_dependency "rspec", "~> 3.4"
  s.add_development_dependency "rubocop", "0.48.1"

  s.description = <<-TXT
    ActiveCleaner is a set of helpers that helps you in cleaning user-typed content in your ActiveModel depending models (ActiveRecord, Mongoid...)
  TXT
end
