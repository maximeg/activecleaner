# encoding: utf-8

module ActiveCleaner
  class StringCleaner < BaseCleaner

    def clean_value(old_value, record=nil)
      unless old_value.nil?
        value = old_value.dup

        value.strip!
        value.gsub!(/\s+/, " ")

        value
      end
    end

  end
end
