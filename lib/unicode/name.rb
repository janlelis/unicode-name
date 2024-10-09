require_relative "name/constants"

module Unicode
  module Name
    HANGUL_START = 44032
    HANGUL_END = 55203
    HANGUL_MEDIAL_MAX = 588
    HANGUL_FINAL_MAX = 28

    # Don't overwrite Module.name
    def self.unicode_name(char) 
      codepoint = char.unpack("U")[0]
      require_relative "name/index" unless defined? ::Unicode::Name::INDEX

      if res = INDEX[:NAMES][codepoint]
        return insert_words(res)
      end

      INDEX[:CP_RANGES].each{|prefix, range|
        if range.any?{ |range| codepoint >= range[0] && codepoint <= range[1] }
          return "%s%.4X" %[prefix, codepoint]
        end
      }

      if codepoint >= HANGUL_START && codepoint <= HANGUL_END
        "HANGUL SYLLABLE %s" % hangul_decomposition(codepoint)
      else
        nil
      end
    end
    class << self; alias of unicode_name; end

    def self.correct(char)
      codepoint = char.unpack("U")[0]
      require_relative "name/index" unless defined? ::Unicode::Name::INDEX
      if correction = INDEX[:ALIASES][codepoint] &&
                      INDEX[:ALIASES][codepoint][:correction] &&
                      INDEX[:ALIASES][codepoint][:correction][-1]
        correction
      else
        unicode_name(char)
      end
    end

    def self.aliases(char)
      codepoint = char.unpack("U")[0]
      require_relative "name/index" unless defined? ::Unicode::Name::INDEX
      INDEX[:ALIASES][codepoint]
    end

    def self.label(char)
      codepoint = char.unpack("U")[0]
      codepoint_pretty = "%.4X" % codepoint
      require_relative "name/index" unless defined? ::Unicode::Name::INDEX
      require "unicode/types" unless defined? ::Unicode::Types
      case Unicode::Types.type(char)
      when "Graphic", "Format"
        nil
      when "Control"
        "<control-#{codepoint_pretty}>"
      when "Private-use"
        "<private-use-#{codepoint_pretty}>"
      when "Surrogate"
        "<surrogate-#{codepoint_pretty}>"
      when "Noncharacter"
        "<noncharacter-#{codepoint_pretty}>"
      when "Reserved"
        "<reserved-#{codepoint_pretty}>"
      end
    end

    def self.readable(char)
      correct(char) ||
      ( as = aliases(char) ) &&
      ( as[:control]      && as[:control][0]      ||
        as[:figment]      && as[:figment][0]      ||
        as[:alternate]    && as[:alternate][0]    ||
        as[:abbreviation] && as[:abbreviation][0]  ) ||
      label(char)
    end

    # See https://en.wikipedia.org/wiki/Korean_language_and_computers#Hangul_Syllables_Area
    def self.hangul_decomposition(codepoint)
      base = codepoint - HANGUL_START
      final = base % HANGUL_FINAL_MAX
      medial = (base % HANGUL_MEDIAL_MAX) / HANGUL_FINAL_MAX
      initial = base / HANGUL_MEDIAL_MAX
      "#{INDEX[:JAMO][:INITIAL][initial]}#{INDEX[:JAMO][:MEDIAL][medial]}#{INDEX[:JAMO][:FINAL][final]}"
    end

    def self.insert_words(raw_name)
      raw_name.chars.map{ |char|
        codepoint = char.ord
        if codepoint < INDEX[:REPLACE_BASE]
          char
        else
          "#{INDEX[:COMMON_WORDS][codepoint - INDEX[:REPLACE_BASE]]} "
        end
      }.join.chomp
    end

    class << self
      private :hangul_decomposition
      private :insert_words
    end
  end
end

