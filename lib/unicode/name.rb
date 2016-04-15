require_relative "name/constants"

module Unicode
  module Name
    # Don't overwrite Module.name
    def self.unicode_name(char) 
      codepoint = char.unpack("U")[0]
      require_relative "name/index" unless defined? ::Unicode::Name::INDEX
      INDEX[:NAMES][codepoint]
    end
    class << self; alias of unicode_name; end

    def self.correct(char)
      codepoint = char.unpack("U")[0]
      require_relative "name/index" unless defined? ::Unicode::Name::INDEX
      if correction = INDEX[:ALIASES][codepoint] && INDEX[:ALIASES][codepoint][:correction][-1]
        correction
      else
        INDEX[:NAMES][codepoint]
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

