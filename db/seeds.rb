# frozen_string_literal: true

User.create(
  name: 'Default Admin',
  email: 'admin@example.com',
  password: '123456',
  role: 'admin'
)
