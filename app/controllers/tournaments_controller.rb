class TournamentsController < ApplicationController

  before_action :logged_in_user, only: [:join, :participant_destroy]

  def index
    @tournaments = Tournament.includes(:participants, :post)
    if current_user
      participant_tournament_ids = current_user.participants.map { |h| h[:tournament_id] }
      @ts_and_ps = @tournaments.map { |t| if participant_tournament_ids.include?(t.id) then { tournament: t, join: true } else { tournament: t, join: false } end }
    end
  end

  def join
    @tournament = Tournament.find(params[:id])
    participant = current_user.participants.build(tournament: @tournament, name: current_user.name)
    if !@tournament.nil? && participant.save
      if RecentAction.where(user: current_user).exists?
        RecentAction.find_by(user: current_user).destroy
      end
      unless RecentAction.new(action: 2, user: current_user, tournament: @tournament).save
        flash[:debug] = "failed to save recent action."
        redirect_to root_url
      end
      redirect_to tournaments_url
    else
      flash[:danger] = "参加に失敗しました"
    end
  end
  
  def show
    @tournament = Tournament.find(params[:id])
    redirect_to root_url if @tournament.nil?
    @participants = @tournament.participants
    @current_user_participant = Participant.find_by(user: current_user)
    if current_user && !@current_user_participant.nil?
      @post = @current_user_participant.post.build()
    end
    @posts = @tournament.post
  end

  def participant_destroy
    participant = Participant.where(user: current_user, tournament_id: params[:id])
    if participant.exists?
      participant[0].destroy
    else
      flash[:danger] = "まだ参加していません"
    end
    redirect_to tournaments_url
  end

end
