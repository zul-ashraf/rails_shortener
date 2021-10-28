class Link < ApplicationRecord
  has_many :clicks, dependent: :destroy

  validates_presence_of :lookup_code, :original_url
  validates_uniqueness_of :lookup_code
  validate :original_url_format

  def original_url_format
    uri = URI.parse(original_url.nil? ? "" : original_url)
    if uri.host.nil?
      errors.add(:original_url, "Invalid URL format")
    end
  end

  # def shortened_url(host_url = "http://localhost:3000/")
  #   url = host_url + lookup_code
  #   return url
  # end
end
