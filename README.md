# Unicode::Name [![[version]](https://badge.fury.io/rb/unicode-name.svg)](http://badge.fury.io/rb/unicode-name)  [![[travis]](https://travis-ci.org/janlelis/unicode-name.png)](https://travis-ci.org/janlelis/unicode-name)

Return Unicode character names and aliases.

Unicode version: **8.0.0**

Supported Rubies: **2.3**, **2.2**, **2.1**

## Usage

```ruby
require "unicode/name"

# Name
Unicode::Name.of "A" # => "LATIN CAPITAL LETTER A"
Unicode::Name.of "🚡" # => "AERIAL TRAMWAY"

# Aliases, by type
Unicode::Name.aliases "\t" # => {:control=>["CHARACTER TABULATION", "HORIZONTAL TABULATION"],
                                 :abbreviation=>["HT", "TAB"]} 

# Corrections (via .aliases[:correction], then name)
Unicode::Name.correct "A" # => "LATIN CAPITAL LETTER A"
Unicode::Name.correct "Ƣ" # => "LATIN CAPITAL LETTER GHA"
```

## MIT License

- Copyright (C) 2016 Jan Lelis <http://janlelis.com>. Released under the MIT license.
- Unicode data: http://www.unicode.org/copyright.html#Exhibit1
