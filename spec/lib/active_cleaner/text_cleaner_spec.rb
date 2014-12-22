# encoding: utf-8
require 'spec_helper'

describe ActiveCleaner::TextCleaner do

  let(:cleaner) { ActiveCleaner::TextCleaner.new(:text) }

  describe "#clean_value" do

    it "doesn't touch non string value" do
      expect(cleaner.clean_value(nil)).to eq(nil)
      expect(cleaner.clean_value(true)).to eq(true)
      expect(cleaner.clean_value(false)).to eq(false)
      expect(cleaner.clean_value(10)).to eq(10)
    end

    it "doesn't touch legit value" do
      [
        "Lorem ipsum dolor sit amet.",
        "Lorem ipsum\ndolor sit amet.",
        "Lorem ipsum\n\ndolor sit amet.",
      ].each do |text|
        expect(cleaner.clean_value(text)).to eq(text)
      end
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
      expect(cleaner.clean_value(" Lorem ipsum\ndolor sit amet. ")).to eq("Lorem ipsum\ndolor sit amet.")
    end
    it "cleans leading and trailing tabs" do
      expect(cleaner.clean_value("\tLorem ipsum\ndolor sit amet.\t")).to eq("Lorem ipsum\ndolor sit amet.")
    end
    it "cleans leading and trailing lines" do
      expect(cleaner.clean_value("\nLorem ipsum\ndolor sit amet.\n")).to eq("Lorem ipsum\ndolor sit amet.")
    end

    it "cleans repeted spaces" do
      expect(cleaner.clean_value("Lorem   ipsum   \n   dolor   sit   amet.")).to eq("Lorem ipsum\ndolor sit amet.")
      expect(cleaner.clean_value("Lorem \t ipsum \t \n   dolor \t sit \t amet.")).to eq("Lorem ipsum\ndolor sit amet.")
    end

    it "keeps two max succeeding new line" do
      expect(cleaner.clean_value("Lorem ipsum\n\n\ndolor sit amet.")).to eq("Lorem ipsum\n\ndolor sit amet.")
      expect(cleaner.clean_value("Lorem ipsum\n\n\n\ndolor sit amet.")).to eq("Lorem ipsum\n\ndolor sit amet.")
    end

  end

end
