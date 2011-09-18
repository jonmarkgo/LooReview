class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  helper_method :current_user
  
  private
  
    def require_user
      unless current_user
        redirect_to root_path
      end
    end
  
    def current_user
      return nil if session[:access_token].blank?
      begin
        foursquare = Foursquare::Base.new(session[:access_token])
        @current_user ||= foursquare.users.find("self")
        puts "wee"
         puts @current_user.to_json
      @puser = User.find_by_uid(@current_user.uid)
      #@puseraccess_token = @access_token
     # puts @access_token
      puts "eheh"
      puts @puser.to_json
      #@puser.save
   
      rescue Foursquare::InvalidAuth
        nil
      end
    end
    
    def foursquare
      unless current_user
        @foursquare ||= Foursquare::Base.new(Settings.app_id, Settings.app_secret)
      else
        @foursquare ||= Foursquare::Base.new(session[:access_token])
      end
    end
end
