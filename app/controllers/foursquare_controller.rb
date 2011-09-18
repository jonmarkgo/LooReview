require 'foursquare'
class FoursquareController < ApplicationController
	 skip_before_filter :verify_authenticity_token  
	def push
		@checkin = ActiveSupport::JSON.decode(params[:checkin])
		@shouttxt = @checkin['shout']
		@venue = @checkin['venue']

#@photoless = Toilet.where('photo_url = \'meh\'')

#		@photoless.each do | pltoilet |
		#	@puser = pltoilet.user

	#	pltoilet.photo_url = @checkin.json['photos']['items'].at(1)['url']
#	@meh = @checkin.json['photos']['items'].first
#	@meh = @meh['sizes']['items'].at(1)
#	pltoilet.photo_url = @meh['url']
#		pltoilet.save
	#	puts pltoilet
		#end
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
			@puser = User.find_by_id(@checkin['user']['id'])
			puts "0"
			puts @puser.to_json
						foursquare = Foursquare::Base.new(@puser['account_token'])
						puts"1"
						puts foursquare
						puts "2"
						puts foursquare.to_json
			@checkedin = foursquare.checkins.find(@checkin['id'])
		@meh = @checkedin.json['photos']['items'].first
	@meh = @meh['sizes']['items'].at(1)
	@toilet.photo_url = @meh['url']
	puts "3"
	puts @meh.to_json
	puts "toilet"
	puts @toilet.to_json

			@toilet.save
		end
	end

end