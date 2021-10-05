class DirectMessagesController < ApplicationController
  before_action :matching_redirect, only: [:show, :create]

  def show
    @direct_message = DirectMessage.new()
    @dms = DirectMessage.where(matching: @matching).order(created_at: :asc)
  end

  def create
    unless @matching.nil?
      dm = DirectMessage.new(dm_params)
      dm.matching = @matching
      dm.sender_id = current_user.id
      if dm.save
        flash[:success] = "ダイレクトメッセージが送信されました"
        redirect_to "/users/#{params[:id]}/direct_messages/"
      else
        flash[:danger] = "ダイレクトメッセージの送信に失敗しました"
        redirect_to "/users/#{params[:id]}/direct_messages/"
      end
    end
  end

  def matching_redirect
    unless matching_find
        flash[:alert] = "マッチングしていません"
        redirect_to controller: :users, action: :show
    end
  end

  private
    def dm_params
      params.require(:direct_message).permit(:content )
    end

end
