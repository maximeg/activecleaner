# encoding: utf-8

module ActiveCleaner

  class Utf8mb3Cleaner < BaseCleaner

    def clean_value(old_value, _record = nil)
      case old_value
      when String
        old_value.each_char.select { |char| char.bytesize < 4 }.join("")
      else
        old_value
      end
    end

  end

end
