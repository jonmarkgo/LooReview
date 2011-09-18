class UpdateToilets < ActiveRecord::Migration
  def self.up
  	add_column :toilets, :shout, :text
  	add_column :toilets, :rating, :integer
  end

  def self.down
  	remove_column :toilets, :shout
  	remove_column :toilets, :rating
  end
end
