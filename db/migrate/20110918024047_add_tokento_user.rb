class AddTokentoUser < ActiveRecord::Migration
  def self.up
  	add_column :users, :access_token, :string
  end

  def self.down
  	emove_column :users, :access_token
  end
end
