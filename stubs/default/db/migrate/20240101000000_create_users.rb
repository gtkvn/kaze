class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |table|
      table.string :name, null: false
      table.string :email, null: false
      table.timestamp :email_verified_at
      table.string :password_digest, null: false
      table.string :remember_token
      table.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
