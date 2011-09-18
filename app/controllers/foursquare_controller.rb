require 'foursquare'
class FoursquareController < ApplicationController
	 skip_before_filter :verify_authenticity_token  
	def push
		@checkin = ActiveSupport::JSON.decode(params[:checkin])
		@shouttxt = @checkin['shout']
		@venue = @checkin['venue']
	#	@photoless = Toilet.find_by_photo_url('')
	#	@photoless.each do | pltoilet |
	#		@checkin = foursquare.checkins.find(pltoilet[:checkin_id])
	#		pltoilet.photo_url = @checkin['photos']['items'].first['url']
	#		pltoilet.save
	#		puts pltoilet
	#	end
		if (@shouttxt.index('toilet') != nil)
			@toilet = Toilet.new
			@toilet.user_id = @checkin['user']['id']
			@toilet.checkin_id = @checkin['id']
			@toilet.photo_url = 'meh'
			@toilet.gender = @checkin['user']['gender']
			@toilet.venue_lat = @venue['location']['lat']
			@toilet.venue_lng = @venue['location']['lng']
			@toilet.venue_name = @venue['name']
			@toilet.venue_id = @venue['id']
			@toilet.save
			puts @toilet.to_json
		end
	end
def lol
@photoless = Toilet.where('photo_url = \'meh\'')
		@photoless.each do | pltoilet |
			@myt = pltoilet['toilet']
puts @myt.to_json
			@checkin = foursquare.checkins.find(@myt['checkin_id'])
			puts @checkin.to_json
		pltoilet.photo_url = @checkin['photos']['items'].first['url']
		pltoilet.save
			#puts pltoilet
		end
end
end