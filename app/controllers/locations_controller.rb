class LocationsController < ApplicationController

  skip_before_action :auth

  def index
    render json: File.read("#{Rails.root}/lib/data/locations.json")
  end
end