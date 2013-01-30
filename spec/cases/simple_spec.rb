# encoding: utf-8
require "spec_helper"

#
# The case
#
# This is to demonstrate when we want to clean some simple fields
#
class Post
  include ActiveCleaner

  attr_accessor :title, :name, :body

  clean :title
  clean :name, as: :string
  clean :body, as: :text
end


#
# The specs
#
describe "Case: a simple post" do

  describe Post, "._cleaners" do

    subject { Post._cleaners }

    it { should have(3).fields_to_clean }

    it "includes a StringCleaner for #title" do
      subject[:title].first.should eq(ActiveCleaner::StringCleaner.new(:title))
    end

    it "includes a StringCleaner for #name" do
      subject[:name].first.should eq(ActiveCleaner::StringCleaner.new(:name))
    end

    it "includes a TextCleaner for #body" do
      subject[:body].first.should eq(ActiveCleaner::TextCleaner.new(:body))
    end

  end # describe

  context "considering a post" do

    before do
      @post = Post.new
    end

    describe "#title, marked as to clean with no type" do

      it "is untouched when legit" do
        @post.title = "A good title!"
        @post.valid?
        @post.title.should eq "A good title!"
      end

      it "is cleaned as a string" do
        @post.title = "  A  \n good  \t title!  "
        @post.valid?
        @post.title.should eq "A good title!"
      end

    end # describe

    describe "#name, marked as to clean as a string" do

      it "is untouched when legit" do
        @post.name = "John Doe"
        @post.valid?
        @post.name.should eq "John Doe"
      end

      it "is cleaned as a string" do
        @post.name = "  \t  John  \n  Doe     "
        @post.valid?
        @post.name.should eq "John Doe"
      end

    end # describe

    describe "#body, marked as to clean as a text" do

      it "is untouched when legit" do
        @post.body = "Lorem ipsum\ndolor sit amet.\n\nLorem."
        @post.valid?
        @post.body.should eq "Lorem ipsum\ndolor sit amet.\n\nLorem."
      end

      it "is cleaned as a text" do
        @post.body = "Lorem \t ipsum \t \n   dolor \t sit \t amet.\n\n\nLorem."
        @post.valid?
        @post.body.should eq "Lorem ipsum\ndolor sit amet.\n\nLorem."
      end

    end # describe

  end # context

end # describe
