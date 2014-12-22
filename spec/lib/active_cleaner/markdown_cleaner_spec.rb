# encoding: utf-8
require 'spec_helper'

describe ActiveCleaner::MarkdownCleaner do

  let(:cleaner) { ActiveCleaner::MarkdownCleaner.new(:body) }

  describe "#clean_value" do

    it "doesn't touch non string value" do
      expect(cleaner.clean_value(nil)).to eq(nil)
      expect(cleaner.clean_value(true)).to eq(true)
      expect(cleaner.clean_value(false)).to eq(false)
      expect(cleaner.clean_value(10)).to eq(10)
    end

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

      expect(cleaner.clean_value(body)).to eq(body)
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

    it "cleans repeted spaces" do
      expect(cleaner.clean_value("Lorem   ipsum   \ndolor   sit   amet.")).to eq("Lorem ipsum\ndolor sit amet.")
      expect(cleaner.clean_value("Lorem \t ipsum \t \ndolor \t sit \t amet.")).to eq("Lorem ipsum\ndolor sit amet.")
    end

    context "considering the spaces in the beggining of lines" do
      it "preserves them" do
        expect(cleaner.clean_value("Lorem ipsum\n   dolor sit amet.")).to eq("Lorem ipsum\n   dolor sit amet.")
      end
      it "clears line full of spaces" do
        expect(cleaner.clean_value("Lorem ipsum   \n   \n   dolor sit amet.")).to eq("Lorem ipsum\n\n   dolor sit amet.")
      end
    end

    it "keeps two max succeeding new line" do
      expect(cleaner.clean_value("Lorem ipsum\n\n\ndolor sit amet.")).to eq("Lorem ipsum\n\ndolor sit amet.")
      expect(cleaner.clean_value("Lorem ipsum\n\n\n\ndolor sit amet.")).to eq("Lorem ipsum\n\ndolor sit amet.")
      expect(cleaner.clean_value("Lorem ipsum\n  \n  \n  \ndolor sit amet.")).to eq("Lorem ipsum\n\ndolor sit amet.")
    end

  end

end
