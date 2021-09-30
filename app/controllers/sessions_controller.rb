class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(email: params[:session][:email])
    if user && user.authenticate(params[:session][:password])
      login user
      redirect_to root_url
    else
      # TODO faied to login

    end
  end

end