# encoding: utf-8
require 'spec_helper'

describe ActiveCleaner::StringCleaner do

  before do
    @cleaner = ActiveCleaner::StringCleaner.new(:title)
  end

  describe "#clean_value" do

    it "doesn't touch legit value" do
      @cleaner.clean_value("A good title!").should eq "A good title!"
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
      @cleaner.clean_value("  A good title!  ").should eq "A good title!"
    end
    it "cleans leading and trailing tabs" do
      @cleaner.clean_value("\tA good title!\t").should eq "A good title!"
    end
    it "cleans leading and trailing lines" do
      @cleaner.clean_value("\nA good title!\n").should eq "A good title!"
    end

    it "cleans repeted spaces" do
      @cleaner.clean_value("A    good    title!").should eq "A good title!"
      @cleaner.clean_value("A  \n good  \t title!").should eq "A good title!"
    end

  end

end
