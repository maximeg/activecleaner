# frozen_string_literal: true

module ActiveCleaner
  # = MarkdownCleaner
  #
  # Cleans a string by squishing all the extra space characters, but preserves new lines
  # (with a max of 2 successive new lines) and spaces in the beginning of lines (the indentation).
  #
  # Useful for Markdown.
  #
  # It turns <tt>"   My todo \n * todo 1 \n * todo 2   \t  "</tt> into <tt>"My todo\n * todo 1\n * todo 2"</tt>.
  #
  # == Options
  #
  # [:nilify]
  #   Whether or not set the field to +nil+ when the field was or is cleaned to <tt>""</tt>.
  #   Default to +false+.
  #
  # == Example
  #
  #   class Article
  #     include ActiveCleaner
  #
  #     clean :body, as: :markdown
  #   end
  #
  #   article = Article.new(body: "   My todo \n * todo 1 \n * todo 2   \t  ")
  #   article.save
  #   article.body
  #   # => "My todo\n * todo 1\n * todo 2"
  class MarkdownCleaner < BaseCleaner

    # Cleans the value.
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
