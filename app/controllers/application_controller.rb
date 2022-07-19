# frozen_string_literal: true

class ApplicationController < ActionController::API
  include JsonWebToken
  include Pundit::Authorization

  attr_reader :current_user

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  protected

  def authenticate_request!
    if user_id? && valid_token?
      @current_user = User.find(auth_token[:user_id])
    else
      render json: { error: 'Unauthorized' }, status: :unauthorized
    end
  rescue JWT::VerificationError, JWT::DecodeError, ActiveRecord::RecordNotFound
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

  private

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

  def user_not_authorized
    render json: { error: 'You are not allowed to take action on this user' },
           status: :unauthorized

    return
  end

  # Pagination
  def pagination(data)
    {
      current_page: data.current_page,
      prev_page: data.prev_page,
      next_page: data.next_page,
      max_page: data.total_pages,
      total: data.total_count
    }
  end
end
