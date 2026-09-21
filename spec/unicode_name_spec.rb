require_relative "../lib/unicode/name"
require "minitest/autorun"

describe Unicode::Name do
  describe ".name (alias .of)" do
    it "will return name for that character" do
      assert_equal "LATIN CAPITAL LETTER A", Unicode::Name.of("A")
      assert_equal "AERIAL TRAMWAY", Unicode::Name.of("🚡")
      assert_equal "REPLACEMENT CHARACTER", Unicode::Name.of("�")
    end

    it "works for CJK unified ideographs" do
      assert_equal "CJK UNIFIED IDEOGRAPH-4E01", Unicode::Name.of("丁")
      assert_equal "SQUARED CJK UNIFIED IDEOGRAPH-6709", Unicode::Name.of("🈶")
    end

    it "works for Hangul syllables" do
      assert_equal "HANGUL SYLLABLE HAN", Unicode::Name.of("한")
      assert_equal "HANGUL SYLLABLE GAG", Unicode::Name.of("각")
      assert_equal "HANGUL SYLLABLE GAE", Unicode::Name.of("개")
      assert_equal "HANGUL SYLLABLE GAENG", Unicode::Name.of("갱")
      assert_equal "HANGUL SYLLABLE DWALB", Unicode::Name.of("돫")
    end

    it "works with some ranges that have the codepoint embedded" do
      assert_equal "EGYPTIAN HIEROGLYPH-143F5", Unicode::Name.of("𔏵")
      assert_equal "KHITAN SMALL SCRIPT CHARACTER-18C12", Unicode::Name.of("𘰒")
      assert_equal "TANGUT IDEOGRAPH-18D00", Unicode::Name.of("𘴀")
      assert_equal "SEAL CHARACTER-3D001", Unicode::Name.of("𽀁")
      assert_equal "NUSHU CHARACTER-1B171", Unicode::Name.of("𛅱")
      assert_equal "CJK COMPATIBILITY IDEOGRAPH-2F9B1", Unicode::Name.of("𧃒")
      assert_equal "CJK COMPATIBILITY IDEOGRAPH-F978", Unicode::Name.of("兩")
    end

    it "will return nil for characters without name" do
      assert_nil Unicode::Name.of("\u{10c50}")
      assert_nil Unicode::Name.of("\0")
    end

    it "works with recent Unicode characters" do
      assert_equal "MUSICAL SYMBOL G CLEF OTTAVA BASSA WITH C CLEF", Unicode::Name.of("𝉷") # Unicode 18.0
      assert_equal "TOLONG SIKI LETTER I", Unicode::Name.of("𑶰") # Unicode 17.0
      assert_equal "SQUARE SPIRAL FROM TOP LEFT", Unicode::Name.of("𜱼") # Unicode 16.0
      assert_equal "ALCHEMICAL SYMBOL FOR QUICK LIME", Unicode::Name.of("🝁") # Unicode 15.1
      assert_equal "KAKTOVIK NUMERAL ZERO", Unicode::Name.of("𝋀") # Unicode 15.0
      assert_equal "ETHIOPIC SYLLABLE HHYAA", Unicode::Name.of("𞟣") # Unicode 14.0
    end
  end

  describe ".correct" do
    it "usually just returns name" do
      assert_equal "LATIN CAPITAL LETTER A", Unicode::Name.correct("A")
    end

    it "returns nothing if no name or correction alias exsits" do
      assert_nil Unicode::Name.correct("\0")
    end

    it "will return corrected name, if one exists" do
      assert_equal "LATIN CAPITAL LETTER GHA", Unicode::Name.correct("Ƣ")
    end
  end

  describe ".aliases" do
    it "will return nil if no alias available" do
      assert_nil Unicode::Name.aliases("A")
    end

    it "will always return a Hash" do
      assert_equal Hash, Unicode::Name.aliases("\0").class
    end

    it "will return aliases grouped by type" do
      assert_equal ["NULL"], Unicode::Name.aliases("\0")[:control]
      assert_equal ["NUL"], Unicode::Name.aliases("\0")[:abbreviation]
    end
  end

  describe ".label" do
    it "will return nil for usual (graphic) characters" do
      assert_nil Unicode::Name.label("A")
    end

    it "will return <control-hhhh> for control characters" do
      assert_equal "<control-0000>", Unicode::Name.label("\0")
    end

    it "will return <private-use> for private use characters" do
      assert_equal "<private-use-FFFFD>", Unicode::Name.label("\u{FFFFD}")
    end

    it "will return <surrogate-hhhh> for codepoints in surrogate area" do
      assert_equal "<surrogate-D800>", Unicode::Name.label("\xED\xA0\x80")
    end

    it "will return <noncharacter-hhhh> for codepoints defined as noncharacter" do
      assert_equal "<noncharacter-FFFFF>", Unicode::Name.label("\u{FFFFF}")
    end

    it "will return <reserved-hhhh> for unassigned codepoints" do
      assert_equal "<reserved-10C50>", Unicode::Name.label("\u{10C50}")
    end
  end

  describe ".readable" do
    it "will return best readable representation of a codepoint" do
      assert_equal "LATIN CAPITAL LETTER A", Unicode::Name.readable("A")
      assert_equal "LATIN CAPITAL LETTER GHA", Unicode::Name.readable("Ƣ")
      assert_equal "NULL", Unicode::Name.readable("\0")
      assert_equal "<noncharacter-FFFFF>", Unicode::Name.readable("\u{FFFFF}")
      assert_equal "<reserved-10C50>", Unicode::Name.readable("\u{10C50}")
      assert_equal "<private-use-FFFFD>", Unicode::Name.readable("\u{FFFFD}")
    end
  end
end

