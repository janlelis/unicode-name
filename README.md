# Unicode::Name [![[version]](https://badge.fury.io/rb/unicode-name.svg)](https://badge.fury.io/rb/unicode-name)  [![[ci]](https://github.com/janlelis/unicode-name/workflows/Test/badge.svg)](https://github.com/janlelis/unicode-name/actions?query=workflow%3ATest)

Return Unicode codepoint names, aliases, and labels.

Unicode version: **15.1.0** (September 2023)

Supported Rubies: **3.2**, **3.1**, **3.0**

Old Rubies that might still work: **2.X**

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

- Copyright (C) 2016-2023 Jan Lelis <https://janlelis.com>. Released under the MIT license.
- Unicode data: https://www.unicode.org/copyright.html#Exhibit1
