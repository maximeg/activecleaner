# encoding: utf-8

module ActiveCleaner
  class Utf8mb3Cleaner < BaseCleaner

    def clean_value(old_value, record=nil)
      unless old_value.nil?
        old_value.each_char.select { |char| char.bytes.length < 4 }.join('')
      end
    end

  end
end
