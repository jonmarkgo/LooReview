class SessionsController < ApplicationController

  def new
    return redirect_to examples_path if current_user
    @authorize_url = foursquare.authorize_url(callback_session_url)
  end
  
  def callback
    code = params[:code]
    @access_token = foursquare.access_token(code, callback_session_url)
   
  session[:access_token] = @access_token
    if (current_user)
      @puser = User.find_by_uid(current_user.id)
      if (@puser.nil?)
        @puser = User.new
        @puser.uid = current_user.id
        @puser.token = @access_token
      #@puseraccess_token = @access_token
     # puts @access_token
      puts "eheh"
      puts @puser.to_json
      #@puser.save
    end
    redirect_to examples_path
  end
  
end