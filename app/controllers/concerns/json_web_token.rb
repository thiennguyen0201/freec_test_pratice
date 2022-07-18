# frozen_string_literal: true

require 'jwt'

module JsonWebToken
  extend ActiveSupport::Concern

  SECRET_KEY = Rails.application.secret_key_base

  def jwt_encode(payload, expired = 7.days.from_now)
    payload[:expired] = expired.to_i

    JWT.encode(payload, SECRET_KEY)
  end

  def jwt_decode(token)
    decoded = JWT.decode(token, SECRET_KEY).first

    ActiveSupport::HashWithIndifferentAccess.new(decoded)
  end
end
