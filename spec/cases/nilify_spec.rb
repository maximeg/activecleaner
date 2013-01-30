# encoding: utf-8
require "spec_helper"

#
# The case
#
# This is to demonstrate when we want to clean some simple fields and nulify them
#
class OptimizedPost
  include ActiveCleaner

  attr_accessor :title, :name, :body

  clean :title, nilify: true
  clean :name, as: :string, nilify: true
  clean :body, as: :text, nilify: true
end


#
# The specs
#
describe "Case: a simple post with nulify" do

  describe OptimizedPost, "._cleaners" do

    subject { OptimizedPost._cleaners }

    it { should have(3).fields_to_clean }

    it "includes a StringCleaner for #title" do
      subject[:title].first.should eq(ActiveCleaner::StringCleaner.new(:title, nilify: true))
    end

    it "includes a StringCleaner for #name" do
      subject[:name].first.should eq(ActiveCleaner::StringCleaner.new(:name, nilify: true))
    end

    it "includes a TextCleaner for #body" do
      subject[:body].first.should eq(ActiveCleaner::TextCleaner.new(:body, nilify: true))
    end

  end # describe

  context "considering a post" do

    before do
      @post = OptimizedPost.new
    end

    describe "#title, marked as to clean with no type" do

      it "is untouched when legit" do
        @post.title = "A good title!"
        @post.valid?
        @post.title.should eq "A good title!"
      end

      it "is nulified" do
        @post.title = " \n \t "
        @post.valid?
        @post.title.should be_nil
      end

    end # describe

    describe "#name, marked as to clean as a string" do

      it "is untouched when legit" do
        @post.name = "John Doe"
        @post.valid?
        @post.name.should eq "John Doe"
      end

      it "is nulified" do
        @post.title = " \n \t "
        @post.valid?
        @post.title.should be_nil
      end

    end # describe

    describe "#body, marked as to clean as a text" do

      it "is untouched when legit" do
        @post.body = "Lorem ipsum\ndolor sit amet.\n\nLorem."
        @post.valid?
        @post.body.should eq "Lorem ipsum\ndolor sit amet.\n\nLorem."
      end

      it "is nulified" do
        @post.title = " \n \t "
        @post.valid?
        @post.title.should be_nil
      end

    end # describe

  end # context

end # describe
