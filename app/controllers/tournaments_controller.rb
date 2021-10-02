class TournamentsController < ApplicationController

  def index
    @tournament = Tournament.all
    # TODO: only future tournament
  end
  
  def show
    @tournament = Tournament.find(params[:id])
    redirect_to root_url if @tournament.nil?
    @participants = @tournament.participants
    @posts = @tournament.posts
  end

end