require_relative "../lib/unicode/name"
require "minitest/autorun"

describe Unicode::Name do
  describe ".name (alias .of)" do
    it "will return name for that character" do
      assert_equal "LATIN CAPITAL LETTER A", Unicode::Name.of("A")
      assert_equal "AERIAL TRAMWAY", Unicode::Name.of("🚡")
      assert_equal "REPLACEMENT CHARACTER", Unicode::Name.of("�")
    end

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
end

