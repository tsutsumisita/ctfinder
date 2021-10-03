class TournamentsController < ApplicationController

  def index
    @tournament = Tournament.all
    # TODO: only future tournament
  end
  
  def show
    @tournament = Tournament.find(params[:id])
    redirect_to root_url if @tournament.nil? #, :alert 'この大会は存在しません'
    @participants = @tournament.participants
    @participant = @participants.find(user: current_user)
    @posts = @tournament.post
    @post = @participant.post.build(post_params)
  end

end