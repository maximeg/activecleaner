$LOAD_PATH.unshift File.expand_path("../lib", __FILE__)
require "active_cleaner/version"

Gem::Specification.new do |s|
  s.name        = "activecleaner"
  s.version     = ActiveCleaner::Version::STRING
  s.date        = Time.now.strftime("%Y-%m-%d")

  s.authors     = ["Maxime Garcia"]
  s.email       = ["maxime.garcia@free.fr"]

  s.summary     = "Clean the fields in your models"
  s.homepage    = "http://github.com/maximeg/activecleaner"

  s.files       = %w( README.md LICENSE )
  s.files      += Dir.glob("lib/**/*")
  s.require_paths = ["lib"]
  s.test_files  = Dir.glob("spec/**/*")
  s.has_rdoc    = false

  s.add_dependency "activemodel", "~> 3.1"
  s.add_dependency "activesupport", "~> 3.1"

  s.add_development_dependency "rspec"

  s.description = <<description
    ActiveCleaner is a set of helpers that helps you in cleaning user-typed content in your ActiveModel depending models (ActiveRecord, Mongoid...)
description
end
