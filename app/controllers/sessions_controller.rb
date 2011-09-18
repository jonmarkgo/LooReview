class SessionsController < ApplicationController

  def new
    return redirect_to examples_path if current_user
    @authorize_url = foursquare.authorize_url(callback_session_url)
  end
  
  def callback
    code = params[:code]
    @access_token = foursquare.access_token(code, callback_session_url)
   
    session[:access_token] = @access_token
     puts "a"
    puts current_user
    puts "c"
    puts self.current_user
    puts "b"
    puts @access_token
    if (current_user)
      current_user.access_token = @access_token
      puts @access_token
      current_user.save
    end
    redirect_to examples_path
  end
  
end