# encoding: utf-8

module ActiveCleaner

  # = TextCleaner
  #
  # Cleans a string by squishing all the extra space characters, but preserves new lines
  # (with a max of 2 successive new lines).
  #
  # Useful when the field is rendered with the +simple_format+ Rails helper.
  #
  # It turns <tt>"   My first line \n My second line   \t  "</tt> into <tt>"My first line\nMy second line"</tt>.
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
  #     clean :body, as: :text
  #   end
  #
  #   article = Article.new(body: "   My first paragraph \n   \n  \t \n My second paragraph,  \n longer.  \t  ")
  #   article.save
  #   article.body
  #   # => "My first paragraph\n\nMy second paragraph,\nlonger."
  class TextCleaner < BaseCleaner

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

        value.gsub!(/\s+/, " ")
        value.gsub!(/ ?__NEW_LINE__ ?/, "__NEW_LINE__")
        value.gsub!(/(__NEW_LINE__){3,}/, "__NEW_LINE____NEW_LINE__")

        # reverse the safe markup
        value.gsub!(/__NEW_LINE__/, "\n")

        value
      else
        old_value
      end
    end

  end

end
