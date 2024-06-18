class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |table|
      table.string :name
      table.string :email
      table.timestamp :email_verified_at, null: true
      table.string :password_digest
      table.string :remember_token, null: true
      table.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
