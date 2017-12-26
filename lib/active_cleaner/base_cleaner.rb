# frozen_string_literal: true

module ActiveCleaner
  # = The base cleaner.
  #
  # Every cleaner inherit from it.
  #
  #   class MyCleaner < ActiveCleaner::BaseCleaner
  #
  #     def clean_value(old_value, record = nil)
  #       old_value.gsub("foo", "bar")
  #     end
  #
  #   end
  class BaseCleaner

    # Attribute name
    attr_reader :attr_name

    # Options given to the cleaner.
    attr_reader :options

    # Accepts options that will be made available through the +options+ reader.
    def initialize(attr_name, options = {})
      @attr_name = attr_name
      @options = {
        nilify: false,
      }.merge(options).freeze
    end

    # The kind of the cleaner.
    def self.kind
      @kind ||= name.split("::").last.underscore.sub(/_cleaner$/, "").to_sym
    end

    # The kind of the cleaner.
    def kind
      self.class.kind
    end

    # Cleans the record by extracting the value of the field, cleaning it, and setting it back.
    def clean(record)
      value = record.read_attribute_for_cleaning(attr_name)

      new_value = clean_value(value, record)

      new_value = nil if @options[:nilify] && nilify_value?(new_value, record)

      record.write_attribute_after_cleaning(attr_name, new_value) unless new_value == value
    end

    # Cleans the value.
    #
    # It is expected that the returned value is the cleaned value.
    #
    # The method needs to be implemented in the subclasses.
    def clean_value(_old_value, _record = nil)
      raise NotImplementedError, "Subclasses must implement a clean(value, record=nil) method."
    end

    # Tests whether or not the value should be nilified.
    #
    # This can be changed in the subclasses.
    def nilify_value?(value, _record = nil)
      value == ""
    end

    # Test whether or not two cleaners are equal.
    def ==(other)
      kind == other.kind && attr_name == other.attr_name && options == other.options
    end

  end
end
