class Admin::AdminController < ApplicationController
  REALM = 'ISHUNATOR'

  before_filter(:authenticate)

private
  def authenticate
    unless session[:admin]
      success = authenticate_with_http_basic do |username, password|
          env = ENV[ [REALM, username].join('_').upcase ]
          compare = Rails.env.development? ? 'password' : (env || false)

          return password if compare == password
      end

      if success
        session[:admin] = true
        return true
      else
        request_http_basic_authentication
      end
    end
  end
end