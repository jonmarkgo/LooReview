require 'foursquare'
class FoursquareController < ApplicationController
	 skip_before_filter :verify_authenticity_token  
	def push
		@checkin = ActiveSupport::JSON.decode(params[:checkin])
		@shouttxt = @checkin['shout']
		@venue = @checkin['venue']
	#	@photoless = Toilet.find_by_photo_url('')
	#	@photoless.each do | pltoilet |
	#		pltoilet.photo_url = 'abc'

	#	end
		if (@shouttxt.index('toilet') != nil)
			@toilet = Toilet.new
			@user = Authorization.find_by_uid(@checkin['user']['id'])
			@toilet.user_id = @user.user.id
			@toilet.checkin_id = @checkin['id']
			@toilet.photo_url = ''
			@toilet.gender = @checkin['user']['gender']
			@toilet.venue_lat = @venue['location']['lat']
			@toilet.venue_lng = @venue['location']['lng']
			@toilet.venue_name = @venue['name']
			@toilet.venue_id = @venue['id']
			@toilet.save
			puts @toilet.to_json
		end
	end

end