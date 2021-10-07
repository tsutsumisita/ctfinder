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
    participant_to_this = Participant.find_by(user: current_user, tournament: @tournament)
    if current_user && !participant_to_this.nil?
      @post = participant_to_this.post.build()
    end
    @posts = @tournament.post
  end

  def participant_destroy
    current_user_participants = Participant.includes(:user).where(user: current_user)
    target_participant = current_user_participants.find_by(tournament_id: params[:id])
    unless target_participant.nil?
      target_participant.destroy
      begin
        RecentAction.find_by(user: current_user).destroy
      rescue => e
        p e.backtrace
        exit!
      end
      recent_actions = Post.where(participant: current_user_participants) + Participant.where(user: current_user)
      recent_action = recent_actions.sort_by{|ra| ra[:created_at] }.last
      RecentAction.create!(
        user: current_user,
        tournament: recent_action.tournament, 
        action: if recent_action.class == Post then 1 else 2 end,
        created_at: recent_action.created_at
      ) unless recent_action.nil?
    else
      flash[:danger] = "まだ参加していません"
    end
    redirect_to tournaments_url
  end

end