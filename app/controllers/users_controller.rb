class UsersController < ApplicationController
  
  # get '/users/index'
  def index
    @user = User.all
  end

  # post '/users/search'
  def search
  end

  def new
  end

  def edit
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to root_url, success: "CtFinderへようこそ！"
    else
      flash.now[:danger] = "ユーザーの保存に失敗しました"
      render 'new' 
    end
  end

  def destroy
    user = current_user
    user.destroy unless !user.nil?
    redirect_to root_url, success: "さようなら！！"
  end

  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :web, :crypt, :reversing, :pwn, :misc, :self_introduction)
  end

end
