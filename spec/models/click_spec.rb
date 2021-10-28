require 'rails_helper'

RSpec.describe Click, type: :model do

  it "creates instance" do
    link = Link.create(
      original_url: "https://www.url.com",
      lookup_code: "1234567"
    )
    location = "location"
    click = link.clicks.create(geolocation: location)
    
    expect(click).to be_a Click
    expect(link.clicks.count).to eq(1)
  end

end
