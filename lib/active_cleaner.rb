# encoding: utf-8

require 'active_support'
#require 'active_support/rails'
require 'active_model'

require 'active_cleaner/helper_methods'

require 'active_cleaner/base_cleaner'
require 'active_cleaner/string_cleaner'
require 'active_cleaner/text_cleaner'
require 'active_cleaner/markdown_cleaner'
require 'active_cleaner/utf8mb3_cleaner'

require 'active_cleaner/version'

module ActiveCleaner
  extend ActiveSupport::Concern

  included do

    include ActiveModel::Validations

    extend HelperMethods
    include HelperMethods

    define_callbacks :cleaning, :scope => :name

    class_attribute :_cleaners
    self._cleaners = Hash.new { |h,k| h[k] = [] }

    set_callback :validate, :before, :run_cleaners!

  end # included


  module ClassMethods

    def inherited(base) #:nodoc:
      dup = _cleaners.dup
      base._cleaners = dup.each { |k, v| dup[k] = v.dup }
      super
    end

  end # ClassMethods


  def run_cleaners!
    self._cleaners.each do |attr_name, cleaners|
      cleaners.each do |cleaner|
        cleaner.clean(self)
      end
    end

    true
  end

  def read_attribute_for_cleaning(attr_name)
    send(attr_name)
  end
  def write_attribute_after_cleaning(attr_name, value)
    send(:"#{attr_name}=", value)
  end

end
