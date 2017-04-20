class AccessController < AdminAreaController

  layout 'admin'

  def menu
    # display text and links
    @user_name = session[:user_name]
  end

  def login
    # login form
  end

  def attempt_login
    if params[:user_name].present? && params[:password].present?
      found_user = User.where(:user_name => params[:user_name]).first
      if found_user
        authorized_user = found_user.authenticate(params[:password])
      end
    end

    if authorized_user
      session[:user_id] = authorized_user.id
      session[:user_name] = authorized_user.user_name
      flash[:notice] = "You are now logged in."
      redirect_to(admin_path)
    else
      # use instead of flash[:notice] since render wouldn't count as next action
      flash.now[:notice] = "Invalid username/password combination."
      render('login')
    end

  end

  def logout
    session[:user_id] = nil
    session[:user_name] = nil
    flash[:notice] = "Logged out"
    redirect_to(access_login_path)
  end

end
