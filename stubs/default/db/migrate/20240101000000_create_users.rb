class CreateUsers < ActiveRecord::Migration
  def self.up
    create_table :users do |table|
      table.string :name
      table.string :email
      table.string :password_digest
      table.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end
