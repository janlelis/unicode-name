# Unicode::Name [![[version]](https://badge.fury.io/rb/unicode-name.svg)](https://badge.fury.io/rb/unicode-name)  [![[travis]](https://travis-ci.org/janlelis/unicode-name.png)](https://travis-ci.org/janlelis/unicode-name)

Return Unicode codepoint names, aliases, and labels.

Unicode version: **13.0.0** (March 2020)

Supported Rubies: **2.7**, **2.6**, **2.5**

Old Rubies that might still work: **2.4**, **2.3**, **2.2**, **2.1**, **2.0**

## Usage

```ruby
require "unicode/name"

# Name
Unicode::Name.of "A" # => "LATIN CAPITAL LETTER A"
Unicode::Name.of "🚡" # => "AERIAL TRAMWAY"
Unicode::Name.of "丁" # => "CJK UNIFIED IDEOGRAPH-4E01"
Unicode::Name.of "한" # => "HANGUL SYLLABLE HAN"

# Aliases, by type
Unicode::Name.aliases "\t" # => {:control=>["CHARACTER TABULATION", "HORIZONTAL TABULATION"],
                                 :abbreviation=>["HT", "TAB"]}

# Corrections (via .aliases[:correction], then name)
Unicode::Name.correct "A" # => "LATIN CAPITAL LETTER A"
Unicode::Name.correct "Ƣ" # => "LATIN CAPITAL LETTER GHA"

# Codepoint labels
Unicode::Name.label("\0") # => "<control-0000>"
Unicode::Name.label("\u{D800}") # => "<surrogate-D800>"
Unicode::Name.label("\u{FFFFF}") # => "<noncharacter-FFFFF>"
Unicode::Name.label("\u{10C50}") # => "<reserved-10C50>"

# Best readable representation
Unicode::Name.readable("A") # => "LATIN CAPITAL LETTER A"
Unicode::Name.readable("\0") # => "NULL"
Unicode::Name.readable("\u{FFFFD}") # => "<private-use-FFFFD>"
```

See [unicode-sequence_names](https://github.com/janlelis/unicode-sequence_name) for character names of more complex codepoint sequences.

See [unicode-x](https://github.com/janlelis/unicode-x) for more Unicode related micro libraries.

## MIT License

- Copyright (C) 2016-2020 Jan Lelis <https://janlelis.com>. Released under the MIT license.
- Unicode data: https://www.unicode.org/copyright.html#Exhibit1
