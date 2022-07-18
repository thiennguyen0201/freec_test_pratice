# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_reader :current_user
  include JsonWebToken

  private

  def authenticate_request!
    if user_id? && valid_token?
      @current_user = User.find_by(id: auth_token[:user_id])
    else
      return render json: { errors: 'Unauthorized' }, status: :unauthorized
    end
  rescue JWT::VerificationError, JWT::DecodeError
    render json: { errors: 'Unauthorized' }, status: :unauthorized
  end

  def http_token
      @http_token ||= if request.headers['Authorization'].present?
        request.headers['Authorization'].split(' ').last
      end
  end

  def auth_token
    @auth_token ||= jwt_decode(http_token)
  end

  def user_id?
    http_token && auth_token && auth_token[:user_id].to_i
  end

  def valid_token?
    !token_expired? # alive token and so on...
  end

  def token_expired?
    auth_token[:expired] <= Time.zone.now.to_i
  end
end
