class LocationsController < ApplicationController

  skip_before_action :auth

  def index
    @locations = JSON.parse(File.read("#{Rails.root}/lib/data/locations.json"))

    used = MainEntry.group(:location).count.keys

    @locations = @locations.each do |g|
      g['rooms'].each do |r|
        r['in_use'] = used.include?(r['id'])
      end
    end

    render json: @locations
  end
end