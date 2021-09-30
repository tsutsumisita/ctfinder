class SessionsController < ApplicationController
  
  def new
  end

  def create
    user = User.find_by(name: params[:session][:name])
    if user && user.authenticate(params[:session][:password])
      login user
      redirect_to '/'
    end
    # TODO faied to login
  end

end