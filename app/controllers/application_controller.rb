class ApplicationController < ActionController::API

  include ActionController::HttpAuthentication::Basic::ControllerMethods

  helper_method :current_user

  before_action :auth, if: -> {Rails.env.production?}

  def auth
    unless current_user
      request_http_basic_authentication
    end
  end

  def current_user
    @current_user ||= authenticate_with_http_basic do |u, p|
      User.authenticate(u, p)
    end
  end

end
