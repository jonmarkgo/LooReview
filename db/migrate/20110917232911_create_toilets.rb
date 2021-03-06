class CreateToilets < ActiveRecord::Migration
  def self.up
    create_table :toilets do |t|
      t.string :user_id
      t.string :checkin_id
      t.string :photo_url
      t.string :gender
      t.float :venue_lat
      t.float :venue_lng
      t.string :venue_name
      t.string :venue_id
      t.string :shout
      t.integer :rating

      t.timestamps
    end
  end

  def self.down
    drop_table :toilets
  end
end
