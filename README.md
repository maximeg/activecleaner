# ActiveCleaner

[![Gem Version](https://badge.fury.io/rb/activecleaner.svg)](https://rubygems.org/gems/activecleaner)
[![Build Status](https://travis-ci.org/maximeg/activecleaner.svg?branch=master)](https://travis-ci.org/maximeg/activecleaner)

`ActiveCleaner` is a set of helpers that helps you in cleaning user-typed content in your ActiveModel depending models (ActiveRecord, Mongoid...)

Extra spaces mean extra storage. And it could ruin your indexes and your sortings.

Tired of doing everywhere:

```ruby
before_validation :clean_title

def clean_title
  unless title.nil?
    self.title = title.squish
  end
  self.title = nil if title.blank?

  true
end
```

### Cleaners included

 * `:string` (StringCleaner, the default one) : cleans all the space characters. It turns `"   A  \n  \t title   \t  "` into `"A title"`.
 * `:text` (TextCleaner) : like `:string`, but preserves new lines (with a max of 2 successive new lines). useful when the field is rendered with the `simple_format` Rails helper.
 * `:markdown` (MarkdownCleaner) : like `:text`, but preserves spaces in the beginning of lines (the indentation). useful for... markdown!
 * `:utf8mb3` (Utf8mb3Cleaner) : removes all 4-bytes encoded chars in UTF8 strings that mess with the `utf8` encoding in MySQL (iOS6 emojis for example).



## Installation

Add the gem to your Gemfile:

    gem 'activecleaner'

Or install with RubyGems:

    $ gem install activecleaner



## Usage

### Basic usage

Add `include ActiveCleaner` in your model and also do:

```ruby
clean :field_1, :field_2 ... :field_n, options_1: :value, options_2: :value
```

### Options

 * `:as` (default is `:string`) : the symbol name of the cleaner.
 * `:nilify` (default is `false`) : set to `nil` when the field was or is cleaned to `""`.

### Example

```ruby
class Post
  include Mongoid::Document
  include ActiveCleaner

  field :title
  field :subtitle
  clean :title, :subtitle, nilify: true

  field :body
  clean :body, as: :text, nilify: true
end
```

## Contributing

Contributions and bug reports are welcome.

Clone the repository and run `bundle install` to setup the development environment.

Provide a case spec according to your changes/needs, taking example on existing ones (in `spec/cases`).

To run the specs:

    bundle exec rspec

You can also use `guard` to run the specs during dev.



## Credits

*   Maxime Garcia [emaxime.com](http://emaxime.com) [@maximegarcia](http://twitter.com/maximegarcia)


[License](https://github.com/maximeg/activecleaner/blob/master/LICENSE)
\- [Report a bug](https://github.com/maximeg/activecleaner/issues)
\- [Rubygems page](https://rubygems.org/gems/activecleaner)
