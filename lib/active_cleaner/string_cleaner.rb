# encoding: utf-8

module ActiveCleaner
  class StringCleaner < BaseCleaner

    def clean_value(old_value, record=nil)
      case old_value
      when String
        value = old_value.dup

        value.strip!
        value.gsub!(/\s+/, " ")

        value
      else
        old_value
      end
    end

  end
end
