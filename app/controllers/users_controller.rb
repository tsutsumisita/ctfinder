class UsersController < ApplicationController
  
  def new
  end

  def edit
  end

  def show
    @user = current_user
    @user = User.find(params[:id]) unless @user.nil?
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to root_url
    else
      render 'new'
    end
  end

  def destroy
    user = current_user
    user.destroy unless !user.nil?
    redirect_to root_url
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password)
  end

end
