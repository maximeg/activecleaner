# encoding: utf-8

module ActiveCleaner

  class BaseCleaner

    attr_reader :attr_name, :options

    # Accepts options that will be made available through the +options+ reader.
    def initialize(attr_name, options = {})
      @attr_name = attr_name
      @options = {
        nilify: false,
      }.merge(options).freeze
    end

    def self.kind
      @kind ||= name.split("::").last.underscore.sub(/_cleaner$/, "").to_sym
    end

    def kind
      self.class.kind
    end

    def clean(record)
      value = record.read_attribute_for_cleaning(attr_name)

      new_value = clean_value(value, record)

      new_value = nil if @options[:nilify] && nilify_value?(new_value, record)

      record.write_attribute_after_cleaning(attr_name, new_value) unless new_value == value
    end

    def clean_value(_value, _record = nil)
      raise NotImplementedError, "Subclasses must implement a clean(value, record=nil) method."
    end

    # feel free to subclass for your custom cleaner
    def nilify_value?(value, _record = nil)
      value == ""
    end

    def ==(other)
      kind == other.kind && attr_name == other.attr_name && options == other.options
    end

  end

end
