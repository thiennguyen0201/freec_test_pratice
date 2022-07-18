# frozen_string_literal: true

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :email, uniqueness: true
      t.string :password_digest
      t.integer :role, default: 1 # default is user

      t.timestamps
    end

    add_index :users, :email, unique: true
    add_index :users, :name
  end
end
