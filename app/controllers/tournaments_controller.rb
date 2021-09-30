class TournamentsController < ApplicationController
  
  def show
    @tournament = Tournament.find(params[:id])
    redirect_to root_url if @tournament.nil?
    @participants = @tournament.participants
    # @participants = Participant.find_by(tournament_id: @tournament.id)
    # @bss = Bss.find_by(tournament_id: @tournament.id)
  end

end