# encoding: utf-8
require 'spec_helper'

describe ActiveCleaner::TextCleaner do

  before do
    @cleaner = ActiveCleaner::TextCleaner.new(:text)
  end

  describe "#clean_value" do

    it "doesn't touch legit value" do
      [
        "Lorem ipsum dolor sit amet.",
        "Lorem ipsum\ndolor sit amet.",
        "Lorem ipsum\n\ndolor sit amet.",
      ].each do |text|
        @cleaner.clean_value(text).should eq text
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
        @cleaner.clean_value(title).should eq ""
      end
    end

    it "cleans leading and trailing spaces" do
      @cleaner.clean_value(" Lorem ipsum\ndolor sit amet. ").should eq "Lorem ipsum\ndolor sit amet."
    end
    it "cleans leading and trailing tabs" do
      @cleaner.clean_value("\tLorem ipsum\ndolor sit amet.\t").should eq "Lorem ipsum\ndolor sit amet."
    end
    it "cleans leading and trailing lines" do
      @cleaner.clean_value("\nLorem ipsum\ndolor sit amet.\n").should eq "Lorem ipsum\ndolor sit amet."
    end

    it "cleans repeted spaces" do
      @cleaner.clean_value("Lorem   ipsum   \n   dolor   sit   amet.").should eq "Lorem ipsum\ndolor sit amet."
      @cleaner.clean_value("Lorem \t ipsum \t \n   dolor \t sit \t amet.").should eq "Lorem ipsum\ndolor sit amet."
    end

    it "keeps two max succeeding new line" do
      @cleaner.clean_value("Lorem ipsum\n\n\ndolor sit amet.").should eq "Lorem ipsum\n\ndolor sit amet."
      @cleaner.clean_value("Lorem ipsum\n\n\n\ndolor sit amet.").should eq "Lorem ipsum\n\ndolor sit amet."
    end

  end

end
