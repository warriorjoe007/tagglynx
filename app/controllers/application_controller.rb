class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate, :except => ['login']
  
  def authenticate
    if session[:user_id].nil?
      #puts params.inspect
      session[:url] = params[:url].to_s 
      session[:title] = params[:title].to_s
      puts "crt_url is" + session[:url]
      puts "crt_title is" + session[:title]
      flash[:alert] = 'You need to login.'
      redirect_to :controller => 'admin', :action => 'login'
    end
  end
  
end
