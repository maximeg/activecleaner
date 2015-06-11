# encoding: utf-8

module ActiveCleaner

  # = Utf8mb3Cleaner
  #
  # Cleans a string by removes all 4-bytes encoded chars in UTF8 strings that mess with
  # the +utf8mb3+ (also simply known as +utf8+) encoding in MySQL.
  #
  # Useful for user input that may contain iOS6 emojis for example (as they are only compatible
  # with +utf8mb4+ and cause string truncation, at best).
  #
  # It turns <tt>"String with emoticon 😀"</tt> into <tt>"String with emoticon"</tt>.
  #
  # == Options
  #
  # [:nilify]
  #   Whether or not set the field to +nil+ when the field was or is cleaned to <tt>""</tt>.
  #   Default to +false+.
  #
  # == Example
  #
  #   class Comment
  #     include ActiveCleaner
  #
  #     clean :body, as: :utf8mb3
  #   end
  #
  #   comment = Comment.new(body: "Nice! 😀")
  #   comment.save
  #   comment.body
  #   # => "Nice!"
  class Utf8mb3Cleaner < BaseCleaner

    # Cleans the value.
    def clean_value(old_value, _record = nil)
      case old_value
      when String
        old_value.each_char.select { |char| char.bytesize < 4 }.join
      else
        old_value
      end
    end

  end

end
