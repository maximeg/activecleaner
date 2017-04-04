# encoding: utf-8
# frozen_string_literal: true

module ActiveCleaner

  # Defines the DSL methods available in your model.
  module HelperMethods

    # Registers a cleaner to a bunch of fields by its name.
    #
    # === Options
    #
    # [:as]
    #   the kind of the cleaner. Default to +:string+
    #
    # Extra options are passed to the cleaner.
    #
    # === Example
    #
    #   class MyModel
    #     include ActiveCleaner
    #
    #     clean :name, nilify: false
    #     clean :firstname, :lastname, nilify: false
    #     clean :resume, as: :markdown
    #   end
    def clean(*attr_names)
      options = attr_names.extract_options!.symbolize_keys
      attr_names.flatten!

      options[:as] ||= :string

      cleaner = "active_cleaner/#{options.delete(:as)}_cleaner".camelize.constantize

      attr_names.each do |attr_name|
        clean_with cleaner.new(attr_name, options)
      end
    end

    # Registers a cleaner by an instance of it.
    #
    #   class MyModel
    #     include ActiveCleaner
    #
    #     clean_with ActiveCleaner::StringCleaner.new(:name, nilify: false)
    #   end
    def clean_with(cleaner)
      _cleaners[cleaner.attr_name] << cleaner
    end

  end

end
