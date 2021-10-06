class TournamentsController < ApplicationController

  before_action :logged_in_user, only: [:join]

  def index
    @tournaments = Tournament.all
    # TODO: only future tournament
    if current_user
      participant_tournament_ids = current_user.participants.map { |h| h[:tournament_id] }
      @ts_and_ps = @tournaments.map { |t| if participant_tournament_ids.include?(t.id) then { tournament: t, join: true } else { tournament: t, join: false } end }
    end
  end

  def join
    @tournament = Tournament.find(params[:tournament_id])
    participant = current_user.participants.build(tournament: @tournament, name: current_user.name)
    if !@tournament.nil? && participant.save
      # if ParticipantAction.where(user: current_user).exists?
	    #   ParticipantAction.find_by(user: current_user).destroy
      # end
      # ParticipantAction.create!(participant: participant, user: current_user)
      if RecentAction.where(user: current_user).exists?
        RecentAction.find_by(user: current_user).destroy
      end
      unless RecentAction.new(action: 2, user: current_user, tourment: @tournament).save
        flash[:debug] = "failed to save recent action."
        redirect_to root_url
      end
      render :index
    else
      flash[:danger] = "参加に失敗しました"
    end
  end
  
  def show
    @tournament = Tournament.find(params[:id])
    redirect_to root_url if @tournament.nil? #, :alert 'この大会は存在しません'
    @participants = @tournament.participants
    if current_user && Participant.exists?(user: current_user)
      @participant = @participants.find(user: current_user)
      @post = @participant.post.build(post_params)
    end
    @posts = @tournament.post
  end

end
