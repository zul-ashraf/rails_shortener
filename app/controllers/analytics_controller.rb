class AnalyticsController < ApplicationController


  CHARACTER_SIZE = 7

  def index
    @links = cached_links.reverse
  end

  def show
    lookup_code = params[:lookup_code]
    
    if lookup_code.length == CHARACTER_SIZE 
      link = Link.find_by(lookup_code: params[:lookup_code])
    end
        
    
    if link
      @link = link
    else
      page_not_found
    end

  end

  private

  def cached_links
    Rails.cache.fetch("links", :expires_in => 1.minutes) do
      Link.all
    end
  end
  
end
