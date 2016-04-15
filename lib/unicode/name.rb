require_relative "name/constants"

module Unicode
  module Name
    # Don't overwrite Module.name
    def self.unicode_name(char) 
      codepoint = char.unpack("U")[0]
      require_relative "name/index" unless defined? ::Unicode::Name::INDEX
      if res = INDEX[:NAMES][codepoint]
        res
      elsif INDEX[:CJK].any?{ |cjk_range| codepoint >= cjk_range[0] && codepoint <= cjk_range[1] }
        "CJK UNIFIED IDEOGRAPH-%.4X" % codepoint
      elsif codepoint >= INDEX[:HANGUL][0][0] && codepoint <= INDEX[:HANGUL][0][1]
        "HANGUL SYLLABLE-%.4X" % codepoint
      else
        nil
      end
    end
    class << self; alias of unicode_name; end

    def self.correct(char)
      codepoint = char.unpack("U")[0]
      require_relative "name/index" unless defined? ::Unicode::Name::INDEX
      if correction = INDEX[:ALIASES][codepoint] && INDEX[:ALIASES][codepoint][:correction][-1]
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
      unicode_name(char) ||
      ( as = aliases(char) ) &&
      ( as[:control]      && as[:control][0]      ||
        as[:figment]      && as[:figment][0]      ||
        as[:alternate]    && as[:alternate][0]    ||
        as[:abbreviation] && as[:abbreviation][0]  ) ||
      label(char)
    end
  end
end

