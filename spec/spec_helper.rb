# frozen_string_literal: true

require "rubygems"
require "rspec"
require "active_cleaner"

RSpec.configure do |_config|
  puts "Ruby: #{RUBY_VERSION}"
  puts "Rails: #{Gem.loaded_specs["rails"].version.to_s}"
end
