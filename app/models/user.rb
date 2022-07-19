# frozen_string_literal: true

class User < ApplicationRecord
  require 'securerandom'

  has_secure_password

  enum role: { admin: 0, user: 1 }

  validates :name, :email, :password_digest, presence: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }

  before_save :downcase_email

  scope :by_name, ->(name) { where('name like ?', "%#{name}%") }
  scope :by_email, ->(email) { where('email like ?', "%#{email}%") }

  def downcase_email
    self.email = email.downcase
  end
end
