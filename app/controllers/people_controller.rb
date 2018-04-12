class PeopleController < ApplicationController
  skip_before_action :auth

  def index
    render json: File.read(Rails.root.join 'config/people.json')
  end
end