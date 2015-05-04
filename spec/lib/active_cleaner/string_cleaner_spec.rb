# encoding: utf-8
require "spec_helper"

describe ActiveCleaner::StringCleaner do
  let(:cleaner) { ActiveCleaner::StringCleaner.new(:title) }

  describe "#clean_value" do
    it "doesn't touch non string value" do
      expect(cleaner.clean_value(nil)).to eq(nil)
      expect(cleaner.clean_value(true)).to eq(true)
      expect(cleaner.clean_value(false)).to eq(false)
      expect(cleaner.clean_value(10)).to eq(10)
    end

    it "doesn't touch legit value" do
      expect(cleaner.clean_value("A good title!")).to eq("A good title!")
    end

    it "empties string full of spaces" do
      [
        "",
        " ",
        "\t",
        "\n",
        " \t\n \t\n \t\n \t\n",
      ].each do |title|
        expect(cleaner.clean_value(title)).to eq("")
      end
    end

    it "cleans leading and trailing spaces" do
      expect(cleaner.clean_value("  A good title!  ")).to eq("A good title!")
    end
    it "cleans leading and trailing tabs" do
      expect(cleaner.clean_value("\tA good title!\t")).to eq("A good title!")
    end
    it "cleans leading and trailing lines" do
      expect(cleaner.clean_value("\nA good title!\n")).to eq("A good title!")
    end

    it "cleans repeted spaces" do
      expect(cleaner.clean_value("A    good    title!")).to eq("A good title!")
      expect(cleaner.clean_value("A  \n good  \t title!")).to eq("A good title!")
    end
  end
end
