# encoding: utf-8
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
  attr_accessor :body

  clean :body, as: :text
end

#
# The specs
#
describe "Case: an ad and his inherited car ad" do

  describe Ad, "._cleaners" do

    subject { Ad._cleaners }

    it { should have(2).fields_to_clean }

    it "includes a StringCleaner for #title" do
      subject[:title].first.should eq(ActiveCleaner::StringCleaner.new(:title))
    end

    it "includes a StringCleaner for #name" do
      subject[:name].first.should eq(ActiveCleaner::StringCleaner.new(:name))
    end

  end # describe

  describe CarAd, "._cleaners" do

    subject { CarAd._cleaners }

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

  context "considering a car ad" do

    before do
      @car_ad = CarAd.new
    end

    describe "#title, marked as to clean with no type" do

      it "is untouched when legit" do
        @car_ad.title = "A good title!"
        @car_ad.valid?
        @car_ad.title.should eq "A good title!"
      end

      it "is cleaned as a string" do
        @car_ad.title = "  A  \n good  \t title!  "
        @car_ad.valid?
        @car_ad.title.should eq "A good title!"
      end

    end # describe

    describe "#name, marked as to clean as a string" do

      it "is untouched when legit" do
        @car_ad.name = "John Doe"
        @car_ad.valid?
        @car_ad.name.should eq "John Doe"
      end

      it "is cleaned as a string" do
        @car_ad.name = "  \t  John  \n  Doe     "
        @car_ad.valid?
        @car_ad.name.should eq "John Doe"
      end

    end # describe

    describe "#body, marked as to clean as a text" do

      it "is untouched when legit" do
        @car_ad.body = "Lorem ipsum\ndolor sit amet.\n\nLorem."
        @car_ad.valid?
        @car_ad.body.should eq "Lorem ipsum\ndolor sit amet.\n\nLorem."
      end

      it "is cleaned as a text" do
        @car_ad.body = "Lorem \t ipsum \t \n   dolor \t sit \t amet.\n\n\nLorem."
        @car_ad.valid?
        @car_ad.body.should eq "Lorem ipsum\ndolor sit amet.\n\nLorem."
      end

    end # describe

  end # context

end # describe
