class ApplicationController < ActionController::Base
  protect_from_forgery

  rescue_from(ActionController::RoutingError, ActiveRecord::RecordNotFound) do |e|
    render :file => "#{Rails.root}/public/404.html", :status => :not_found
  end

protected
  def not_found
    raise ActionController::RoutingError.new('Not Found')
  end
end
