# encoding: utf-8

module ActiveCleaner
  module HelperMethods

    def clean(*attr_names)
      options = attr_names.extract_options!.symbolize_keys
      attr_names.flatten!

      options[:as] ||= :string

      cleaner = "active_cleaner/#{options.delete(:as)}_cleaner".camelize.constantize

      attr_names.each do |attr_name|
        clean_with cleaner.new(attr_name, options)
      end
    end

    def clean_with(cleaner)
      self._cleaners[cleaner.attr_name] << cleaner
    end

  end
end
