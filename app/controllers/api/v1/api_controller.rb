class Api::V1::APIController < ActionController::API
  class AuthenticationError < StandardError; end

  before_action :authenticate

  def current_user 
    @poe_auth_user
  end

  private
  def authenticate
    if params[:poe_auth_token]
      @poe_auth_user = User.where(token: params[:poe_auth_token]).first
      raise AuthenticationError.new("Invalid auth token") unless @poe_auth_user
    else
      raise AuthenticationError.new("Need to provide auth token")
    end
  end
end
