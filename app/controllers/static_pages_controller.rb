class StaticPagesController < ApplicationController

  def feed
    flickr_setup
    id = id_params['id']
    @person_id = id
    person = Flickr.people.find(id)
    begin
      @photos = person.public_photos(sizes: true).map(&:medium500!)
    rescue
      puts 'BORKEKPE'
      @error = 'no user found'
      @photos = Flickr.people.find('66956608@N06').public_photos(sizes: true).map(&:medium500!)
    end
  end

  private

  def flickr_setup
    Flickr.configure do |config|
      config.api_key       = ENV['FLICKR_API_KEY']
      config.shared_secret = ENV['FLICKR_SHARED_SECRET']
    end
  end

  def id_params
    params.permit(:id)
  end
end
