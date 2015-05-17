# encoding: utf-8

module ActiveCleaner

  # = StringCleaner
  #
  # Cleans a string by squishing all the extra space characters.
  #
  # It turns <tt>"   A  \n  \t title   \t  "</tt> into <tt>"A title"</tt>.
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
  #     clean :title, as: :string
  #   end
  #
  #   article = Article.new(title: "   My  \n  \t Title   \t  ")
  #   article.save
  #   article.title
  #   # => "My Title"
  class StringCleaner < BaseCleaner

    # Cleans the value.
    def clean_value(old_value, _record = nil)
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
