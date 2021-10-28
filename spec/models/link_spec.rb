require 'rails_helper'

RSpec.describe Link, type: :model do


  it "is valid when it has original URL and a lookup code" do
    link = Link.new(
      original_url: "https://website.com",
      lookup_code: "1234567"
    )
    expect(link.valid?).to be(true)
  end

  describe "error" do
    it "is invalid when URL is not formatted" do
      link = Link.new(
        original_url: "hasdfsafasdf",
        lookup_code: "1234567"
      )
      expect(link.valid?).to be(false)
    end
  
    it "is invalid when there is no lookup_code" do
      link = Link.new(
        original_url: "https://website.com",
      )
      expect(link.valid?).to be(false)
    end
  
    it "is invalid when there is no url" do
      link = Link.new(
        lookup_code: "1234567"
      )
      expect(link.valid?).to be(false)
    end
  
    it "is invalid when lookup code already exist" do
      link1 = Link.new(
        original_url: "https://website1.com",
        lookup_code: "1234567"
      )
      link1.save
  
      link2 = Link.new(
        original_url: "https://website2.com",
        lookup_code: "1234567"
      )
      expect(link2.valid?).to be(false)
    end
      
  end

end


