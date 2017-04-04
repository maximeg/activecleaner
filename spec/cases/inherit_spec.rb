# encoding: utf-8
# frozen_string_literal: true

require "spec_helper"

#
# The case
#
# This is to demonstrate when we want to clean some simple fields
# in a common STI scenario.
#
class Ad

  include ActiveCleaner

  attr_accessor :title, :name

  clean :title
  clean :name, as: :string

end

class CarAd < Ad

  attr_accessor :body, :user_generated_content

  clean :body, as: :text
  clean :user_generated_content, as: :utf8mb3

end

#
# The specs
#
describe "Case: an ad and his inherited car ad" do
  describe Ad, "._cleaners" do
    subject { Ad._cleaners }

    it "has 2 cleaners" do
      expect(subject.length).to eq(2)
    end

    it "includes a StringCleaner for #title" do
      expect(subject[:title].first).to eq(ActiveCleaner::StringCleaner.new(:title))
    end

    it "includes a StringCleaner for #name" do
      expect(subject[:name].first).to eq(ActiveCleaner::StringCleaner.new(:name))
    end
  end # describe

  describe CarAd, "._cleaners" do
    subject { CarAd._cleaners }

    it "has 4 cleaners" do
      expect(subject.length).to eq(4)
    end

    it "includes a StringCleaner for #title" do
      expect(subject[:title].first).to eq(ActiveCleaner::StringCleaner.new(:title))
    end

    it "includes a StringCleaner for #name" do
      expect(subject[:name].first).to eq(ActiveCleaner::StringCleaner.new(:name))
    end

    it "includes a TextCleaner for #body" do
      expect(subject[:body].first).to eq(ActiveCleaner::TextCleaner.new(:body))
    end

    it "includes a Utf8mb3Cleaner for #user_generated_content" do
      expect(subject[:user_generated_content].first).to eq(ActiveCleaner::Utf8mb3Cleaner.new(:user_generated_content))
    end
  end # describe

  context "considering a car ad" do
    let(:subject) { CarAd.new }

    describe "#title, marked as to clean with no type" do
      it "is untouched when legit" do
        subject.title = "A good title!"
        subject.valid?
        expect(subject.title).to eq("A good title!")
      end

      it "is cleaned as a string" do
        subject.title = "  A  \n good  \t title!  "
        subject.valid?
        expect(subject.title).to eq("A good title!")
      end
    end # describe

    describe "#name, marked as to clean as a string" do
      it "is untouched when legit" do
        subject.name = "John Doe"
        subject.valid?
        expect(subject.name).to eq("John Doe")
      end

      it "is cleaned as a string" do
        subject.name = "  \t  John  \n  Doe     "
        subject.valid?
        expect(subject.name).to eq("John Doe")
      end
    end # describe

    describe "#body, marked as to clean as a text" do
      it "is untouched when legit" do
        subject.body = "Lorem ipsum\ndolor sit amet.\n\nLorem."
        subject.valid?
        expect(subject.body).to eq("Lorem ipsum\ndolor sit amet.\n\nLorem.")
      end

      it "is cleaned as a text" do
        subject.body = "Lorem \t ipsum \t \n   dolor \t sit \t amet.\n\n\nLorem."
        subject.valid?
        expect(subject.body).to eq("Lorem ipsum\ndolor sit amet.\n\nLorem.")
      end
    end # describe

    describe "#user_generated_content, marked as to clean as utf8mb3" do
      it "is untouched when legit" do
        subject.user_generated_content = "A good user generated content!"
        subject.valid?
        expect(subject.user_generated_content).to eq("A good user generated content!")
      end

      it "is cleaned as an utf8mb3" do
        subject.user_generated_content = "A good 😀 user generated content!"
        subject.valid?
        expect(subject.user_generated_content).to eq("A good  user generated content!")
      end
    end # describe
  end # context
end # describe
