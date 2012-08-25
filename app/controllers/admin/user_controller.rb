class Admin::UserController < Admin::AdminController

  def index

  end

  def show
    render :index
  end

  def create
    username = params[:admin_user][:username]
    password = params[:admin_user][:password]

    user = AdminUser.find_or_initialize_by_username(username)
    user.pass = password
    user.save!
    flash[:info] = "The user %{username} was saved properly"
  rescue
    flash[:error] = 'Could not save user'
  ensure
    redirect_to admin_user_index_path
  end

end
