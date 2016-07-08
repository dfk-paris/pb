class ApplicationController < ActionController::API

  helper_method :current_user

  before_action :auth

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
