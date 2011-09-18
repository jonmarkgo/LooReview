require 'foursquare'
class FoursquareController < ApplicationController
	 skip_before_filter :verify_authenticity_token  
	def push
		@checkin = ActiveSupport::JSON.decode(params[:checkin])
		@shouttxt = @checkin['shout']
		@venue = @checkin['venue']

		if (@shouttxt.index('toilet') != nil)
			@toilet = Toilet.new
			@toilet.user_id = @checkin['user']['id']
			@toilet.checkin_id = @checkin['id']
		#	@toilet.photo_url = 'meh'
			@toilet.gender = @checkin['user']['gender']
			@toilet.venue_lat = @venue['location']['lat']
			@toilet.venue_lng = @venue['location']['lng']
			@toilet.venue_name = @venue['name']
			@toilet.venue_id = @venue['id']
			@puser = User.find_by_uid(@checkin['user']['id'])
		
						foursquare = Foursquare::Base.new(@puser['token'])
				
			@checkedin = foursquare.checkins.find(@checkin['id'])
		@meh = @checkedin.json['photos']['items'].first
	@meh = @meh['sizes']['items'].at(1)
	@toilet.photo_url = @meh['url']


			@toilet.save
			
		end
			render :status => :ok
	end

end