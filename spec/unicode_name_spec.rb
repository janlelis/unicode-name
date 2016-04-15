require_relative "../lib/unicode/name"
require "minitest/autorun"

describe Unicode::Name do
  describe ".name (alias .of)" do
    it "will return name for that character" do
      assert_equal "LATIN CAPITAL LETTER A", Unicode::Name.of("A")
      assert_equal "AERIAL TRAMWAY", Unicode::Name.of("🚡")
      assert_equal "REPLACEMENT CHARACTER", Unicode::Name.of("�")
    end

    it "works for CJK Ideographs" do
      assert_equal "CJK UNIFIED IDEOGRAPH-4E01", Unicode::Name.of("丁")
    end

    # it "works for Hangul Syllables" do
    #   assert_equal "HANGUL SYLLABLE GAG", Unicode::Name.of("각")
    # end

    it "will return nil for characters without name" do
      assert_equal nil, Unicode::Name.of("\u{10c50}")
      assert_equal nil, Unicode::Name.of("\0")
    end
  end

  describe ".correct" do
    it "usually just returns name" do
      assert_equal "LATIN CAPITAL LETTER A", Unicode::Name.correct("A")
    end

    it "will return corrected name, if one exists" do
      assert_equal "LATIN CAPITAL LETTER GHA", Unicode::Name.correct("Ƣ")
    end
  end

  describe ".aliases" do
    it "will return nil if no alias available" do
      assert_equal nil, Unicode::Name.aliases("A")
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
      assert_equal nil, Unicode::Name.label("A")
    end

    it "will return <control-hhhh> for control characters" do
      assert_equal "<control-0000>", Unicode::Name.label("\0")
    end

    it "will return <private-use> for private use characters" do
      assert_equal "<private-use-FFFFD>", Unicode::Name.label("\u{FFFFD}")
    end

    it "will return <surrogate-hhhh> for codepoints in surrogate area" do
      assert_equal "<surrogate-D800>", Unicode::Name.label("\u{D800}")
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
      assert_equal "NULL", Unicode::Name.readable("\0")
      assert_equal "<noncharacter-FFFFF>", Unicode::Name.readable("\u{FFFFF}")
      assert_equal "<reserved-10C50>", Unicode::Name.readable("\u{10C50}")
      assert_equal "<private-use-FFFFD>", Unicode::Name.readable("\u{FFFFD}")
    end
  end
end

