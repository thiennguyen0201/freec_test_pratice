# frozen_string_literal: true

class User < ApplicationRecord
  require 'securerandom'

  has_secure_password

  enum role: { admin: 0, user: 1 }

  validates :name, :email, :password, presence: true
  validates :email, format: {with: URI::MailTo::EMAIL_REGEXP}

  before_save :downcase_email

  def downcase_email
    self.email = email.downcase
  end
end
