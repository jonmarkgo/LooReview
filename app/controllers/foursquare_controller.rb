require 'foursquare'
require 'rest_client'
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
			@toilet.shout = @checkin['shout']
			@puser = User.find_by_uid(@checkin['user']['id'])
		
						foursquare = Foursquare::Base.new(@puser['token'])
				
			@checkedin = foursquare.checkins.find(@checkin['id'])
		@meh = @checkedin.json['photos']['items'].first
	@meh = @meh['sizes']['items'].at(1)
	@toilet.photo_url = @meh['url']

@surl = @meh['url'].sub('https://','http://')
@rating = ''
response = RestClient.get 'http://mkweb.bcgsc.ca/color_summarizer/?xml=1&url='+@surl+'&precision=extreme'
response = Crack::XML.parse(response)
response['imgdata']['variable'].each do |stat|
	
	if (stat['name'] == "s")
stat['statistic'].each do | val|

	if (val['name'] == "avg")
		@rating = val['value']
		break
	end
end
	end
end
@rating = @rating.to_i
if (@rating > 0 and @rating <= 20)
	@toilet.rating = 5
else if (@rating > 20 and @rating <= 40)
	@toilet.rating = 4
else if (@rating > 40 and @rating <= 50)
	@toilet.rating = 3
else if (@rating > 50 and @rating <= 60)
	@toilet.rating = 2
else if (@rating > 60)
	@toilet.rating = 1
end
puts @toilet.rating
			@toilet.save
			
		end
			render :status => :ok
	end

end