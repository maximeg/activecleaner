# encoding: utf-8
require 'spec_helper'

describe ActiveCleaner::MarkdownCleaner do

  before do
    @cleaner = ActiveCleaner::MarkdownCleaner.new(:body)
  end

  describe "#clean_value" do

    it "doesn't touch legit value" do
      body = ""
      body << "= Title =\n"
      body << "\n"
      body << "A first paragraph.\n"
      body << "\n"
      body << "A **second** one, with a\n"
      body << "line break.\n"
      body << "\n"
      body << " * first item\n"
      body << " * second item\n"
      body << "\n"
      body << "    <div id=\"test\">\n"
      body << "      <p>Text</p>\n"
      body << "    </div>\n"
      body << "\n"
      body << "A third paragraph."

      @cleaner.clean_value(body).should eq body
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

    it "cleans repeted spaces" do
      @cleaner.clean_value("Lorem   ipsum   \ndolor   sit   amet.").should eq "Lorem ipsum\ndolor sit amet."
      @cleaner.clean_value("Lorem \t ipsum \t \ndolor \t sit \t amet.").should eq "Lorem ipsum\ndolor sit amet."
    end

    context "considering the spaces in the beggining of lines" do
      it "preserves them" do
        @cleaner.clean_value("Lorem ipsum\n   dolor sit amet.").should eq "Lorem ipsum\n   dolor sit amet."
      end
      it "clears line full of spaces" do
        @cleaner.clean_value("Lorem ipsum   \n   \n   dolor sit amet.").should eq "Lorem ipsum\n\n   dolor sit amet."
      end
    end

    it "keeps two max succeeding new line" do
      @cleaner.clean_value("Lorem ipsum\n\n\ndolor sit amet.").should eq "Lorem ipsum\n\ndolor sit amet."
      @cleaner.clean_value("Lorem ipsum\n\n\n\ndolor sit amet.").should eq "Lorem ipsum\n\ndolor sit amet."
      @cleaner.clean_value("Lorem ipsum\n  \n  \n  \ndolor sit amet.").should eq "Lorem ipsum\n\ndolor sit amet."
    end

  end

end
