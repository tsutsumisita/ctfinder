class TournamentsController < ApplicationController
  
  def show
    @tournament = Tournament.find(params[:id])
    redirect_to root_url unless @tournament.nil?
    # @participants = Participants.find_by(tournament_id: @tournament.id)
    # @bss = Bss.find_by(bss_id: @bss.id)
  end

end