class UsersController < AdminAreaController

  layout 'admin'

  def index
    @users = User.sorted
  end

  def new
    @user = User.new
  end

  def create
    # Instantiate the new object using form params
    @user = User.new(user_params)
    # save object
    if @user.save
      # if save succeeds rediriect to the index action
      flash[:notice] = "User created successfully."
      redirect_to(users_path)
    else
      # if save fails display again using render so form data remains
      render('new')
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    # Find a new object using the form parameters
    @user = User.find(params[:id])
    # Attempt to destroy
    if @user.update_attributes(user_params)
      # If delete succeeds, redirect to the index action
      flash[:notice] = "User updated successfully."
      redirect_to(users_path)
    else
      # if delete fails display again.
      render('edit')
    end
  end


  def delete
    @user = User.find(params[:id])
  end

  def destroy
    # Find a new object using the form parameters
    @user = User.find(params[:id])
    # Attempt to destroy
    if @user.destroy
      # If delete succeeds, redirect to the index action
      flash[:notice] = "User '#{@user.name}' successfully."
      redirect_to(users_path)
    else
      # if delete fails display again.
      render('delete')
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :user_name, :email,
                                    :is_site_admin, :password, :created_at)
  end

end
