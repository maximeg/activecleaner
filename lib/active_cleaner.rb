# frozen_string_literal: true

require "active_support"
require "active_model"

require "active_cleaner/helper_methods"

require "active_cleaner/base_cleaner"
require "active_cleaner/string_cleaner"
require "active_cleaner/text_cleaner"
require "active_cleaner/markdown_cleaner"
require "active_cleaner/utf8mb3_cleaner"

require "active_cleaner/version"

# = ActiveCleaner
#
# See HelperMethods for the DSL.
#
# == Example
#
#   class Post
#     include Mongoid::Document
#     include ActiveCleaner
#
#     field :title
#     field :subtitle
#     clean :title, :subtitle, nilify: true
#
#     field :body
#     clean :body, as: :text, nilify: true
#   end
module ActiveCleaner

  extend ActiveSupport::Concern

  included do
    include ActiveModel::Validations

    extend HelperMethods
    include HelperMethods

    define_callbacks :cleaning, scope: :name

    class_attribute :_cleaners
    self._cleaners = Hash.new { |h, k| h[k] = [] }

    set_callback :validate, :before, :run_cleaners!
  end

  module ClassMethods

    def inherited(base)
      dup = _cleaners.dup
      base._cleaners =
        dup.each do |attr_name, cleaner|
          dup[attr_name] = cleaner.dup
        end
      super
    end

  end

  # Do run the cleaners
  def run_cleaners!
    _cleaners.each do |_attr_name, cleaners|
      cleaners.each do |cleaner|
        cleaner.clean(self)
      end
    end

    true
  end

  # Method used by the cleaners to read the value of an attribute.
  def read_attribute_for_cleaning(attr_name)
    send(attr_name)
  end

  # Method used by the cleaners to write the value of an attribute.
  def write_attribute_after_cleaning(attr_name, value)
    send(:"#{attr_name}=", value)
  end

end
