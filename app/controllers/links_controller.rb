class LinksController < ApplicationController

  CHARACTER_SIZE = 7

  def show
    lookup_code = params[:lookup_code]
    
    if lookup_code.length == CHARACTER_SIZE 
      link = cached_link(lookup_code)
    end
        
    if link
      location = Geocoder.search(get_ip_address)
      if location
        coordinates =  location.first.coordinates.join(', ')
      else
        coordinates = "Not Available"
      end
      link.clicks.create(geolocation: coordinates)
      redirect_to link.original_url
    else
      page_not_found
    end

  end

  def create
    shortener = Shortener.new(link_params[:original_url])
    @link = shortener.generate_short_link

    if @link.persisted?
      respond_to :js
    else
      render 'error.js.erb'
    end

  end

  private

  def link_params
    params.require(:link).permit(:original_url)
  end

  def get_ip_address
    if Rails.env.production?
      request.remote_ip
    else
      Net::HTTP.get(URI.parse('http://checkip.amazonaws.com/')).squish
    end
  end

  def cached_link(lookup_code)
    Rails.cache.fetch("/links/#{lookup_code}", :expires_in => 5.minutes) do
      Link.find_by(lookup_code: lookup_code)
    end
  end

end
