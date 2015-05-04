# encoding: utf-8

module ActiveCleaner

  class MarkdownCleaner < BaseCleaner

    def clean_value(old_value, _record = nil)
      case old_value
      when String
        value = old_value.dup

        value.strip!

        # clean the new lines mess among OS
        value.gsub!(/\r\n|\r/, "\n")

        # protect stuff to keep with a markup
        value.gsub!(/\n/, "__NEW_LINE__")
        value.gsub!(/(?<=__NEW_LINE__)\s+/) { |match| match.gsub(/\s/, "__SPACE__") }

        value.gsub!(/\s+/, " ")
        value.gsub!(/(__SPACE__|\s)*__NEW_LINE__\s*/, "__NEW_LINE__")
        value.gsub!(/(__NEW_LINE__){3,}/, "__NEW_LINE____NEW_LINE__")

        # reverse the safe markup
        value.gsub!(/__NEW_LINE__/, "\n")
        value.gsub!(/__SPACE__/, " ")

        value
      else
        old_value
      end
    end

  end

end
