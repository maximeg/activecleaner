# encoding: utf-8
require "spec_helper"

#
# The case
#
# This is to demonstrate when we want to clean some simple fields and nulify them
#
class OptimizedPost
  include ActiveCleaner

  attr_accessor :title, :name, :body, :user_generated_content

  clean :title, nilify: true
  clean :name, as: :string, nilify: true
  clean :body, as: :text, nilify: true
  clean :user_generated_content, as: :utf8mb3, nilify: true
end


#
# The specs
#
describe "Case: a simple post with nulify" do

  describe OptimizedPost, "._cleaners" do

    subject { OptimizedPost._cleaners }

    it "has 4 cleaners" do
      expect(subject.length).to eq(4)
    end

    it "includes a StringCleaner for #title" do
      expect(subject[:title].first).to eq(ActiveCleaner::StringCleaner.new(:title, nilify: true))
    end

    it "includes a StringCleaner for #name" do
      expect(subject[:name].first).to eq(ActiveCleaner::StringCleaner.new(:name, nilify: true))
    end

    it "includes a TextCleaner for #body" do
      expect(subject[:body].first).to eq(ActiveCleaner::TextCleaner.new(:body, nilify: true))
    end

    it "includes a Utf8mb3Cleaner for #user_generated_content" do
      expect(subject[:user_generated_content].first).to eq(ActiveCleaner::Utf8mb3Cleaner.new(:user_generated_content, nilify: true))
    end

  end # describe

  context "considering a post" do

    let(:subject) { OptimizedPost.new }

    describe "#title, marked as to clean with no type" do

      it "is untouched when legit" do
        subject.title = "A good title!"
        subject.valid?
        expect(subject.title).to eq("A good title!")
      end

      it "is nulified" do
        subject.title = " \n \t "
        subject.valid?
        expect(subject.title).to be_nil
      end

    end # describe

    describe "#name, marked as to clean as a string" do

      it "is untouched when legit" do
        subject.name = "John Doe"
        subject.valid?
        expect(subject.name).to eq("John Doe")
      end

      it "is nulified" do
        subject.title = " \n \t "
        subject.valid?
        expect(subject.title).to be_nil
      end

    end # describe

    describe "#body, marked as to clean as a text" do

      it "is untouched when legit" do
        subject.body = "Lorem ipsum\ndolor sit amet.\n\nLorem."
        subject.valid?
        expect(subject.body).to eq("Lorem ipsum\ndolor sit amet.\n\nLorem.")
      end

      it "is nulified" do
        subject.title = " \n \t "
        subject.valid?
        expect(subject.title).to be_nil
      end

    end # describe

    describe "#user_generated_content, marked as to clean as utf8mb3" do

      it "is untouched when legit" do
        subject.user_generated_content = "A good user generated content!"
        subject.valid?
        expect(subject.user_generated_content).to eq("A good user generated content!")
      end

      it "is nulified" do
        subject.user_generated_content = "😀"
        subject.valid?
        expect(subject.user_generated_content).to be_nil
      end

    end # describe

  end # context

end # describe
