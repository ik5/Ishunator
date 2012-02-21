class Admin::AdminController < ApplicationController
  REALM = 'ISHUNATOR'
  
  before_filter(:authenticate)
  
private
  def authenticate
    unless session[:admin]
      success = authenticate_or_request_with_http_digest(REALM) do |username|
        env = ENV[ [REALM, username].join('_').upcase ]
        return (Rails.env.development? ? 'password' : (env || false)) 
      end
      
      if success
        return (session[:admin] = true)
      else
        redirect_to(root_path)
      end
    end
  end
end