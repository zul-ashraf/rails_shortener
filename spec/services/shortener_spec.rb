require "rails_helper"

RSpec.describe Shortener do

  it "it shorten a given URL to a 7 character lookup code" do
    url = "https://google.com"
    shortener = Shortener.new(url)
    expect(shortener.lookup_code.length).to eq(7)
  end

  it "it gives each URL its own lookup code" do
    url = "https://url1.com"
    shortener = Shortener.new(url)
    code_1 = shortener.lookup_code
    

    url = "https://url2.com"
    shortener = Shortener.new(url)
    code_2 = shortener.lookup_code

    expect(code_2).not_to eq(code_1)
  end

  it "it gives different lookup code even for the same url" do
    url = "https://url1.com"
    shortener = Shortener.new(url)
    code_1 = shortener.lookup_code
    

    url = "https://url1.com"
    shortener = Shortener.new(url)
    code_2 = shortener.lookup_code

    expect(code_2).not_to eq(code_1)
  end

  it "generates a Link record with a unique lookup code" do
    url = "https://url.com"
    shortener = Shortener.new(url)
    link = shortener.generate_short_link
    expect(link.valid?).to eq(true)
  end

end