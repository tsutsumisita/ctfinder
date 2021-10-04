class DirectMessagesController < ApplicationController
  before_action :matching_find, only: [:show, :create]

  def show
    @dms = DirectMessage.where(matching: @matching).order(created_at: :asc)
  end

  def create
    unless matching.nil?
      dm = DirectMessage.new(matching: @matching, content: params[:content])
      if dm.save
	redirect_to "users/#{params[:id]}/direct_messages/", notice: "ダイレクトメッセージが送信されました"
      else
        flash.now[:danger] = "ダイレクトメッセージの送信に失敗しました"
      end
    end
  end

end
