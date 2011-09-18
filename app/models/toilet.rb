class Toilet < ActiveRecord::Base
	belongs_to :user
	reverse_geocoded_by :venue_lat, :venue_lng do |obj,results|
  if geo = results.first
    obj.city    = geo.city
    obj.zipcode = geo.postal_code
    obj.country = geo.country_code
  end
end
after_validation :reverse_geocode 
end
