class Admin::UserController < ApplicationController

  def index

  end

  def show
    render :index
  end

  def create
    username = params[:username]
    password = params[:password]

    user = find_or_initialize_by_username(username)
    user.password=password
    user.save!
    flash[:info] = "The user %{username} was saved properly"
  rescue
    flash[:error] = 'Could not save user'
  ensure
    redirect_to admin_user_path
  end

end
