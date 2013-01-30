# encoding: utf-8

module ActiveCleaner
  class TextCleaner < BaseCleaner

    def clean_value(old_value, record=nil)
      unless old_value.nil?
        value = old_value.dup

        value.strip!

        # clean the new lines mess among OS
        value.gsub!(/\r\n|\r/, "\n")

        # protect stuff to keep with a markup
        value.gsub!(/\n/, "__NEW_LINE__")

        value.gsub!(/\s+/, " ")
        value.gsub!(/ ?__NEW_LINE__ ?/, "__NEW_LINE__")
        value.gsub!(/(__NEW_LINE__){3,}/, "__NEW_LINE____NEW_LINE__")

        # reverse the safe markup
        value.gsub!(/__NEW_LINE__/, "\n")

        value
      end
    end

  end
end
