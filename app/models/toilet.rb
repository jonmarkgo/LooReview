class Toilet < ActiveRecord::Base
	belongs_to :user
reverse_geocoded_by :venue_lat, :venue_lng
after_validation :reverse_geocode 
end
