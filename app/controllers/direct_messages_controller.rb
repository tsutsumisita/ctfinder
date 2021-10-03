class DirectMessagesController < ApplicationController

  def create
    matching = Matching.find_by(user1_id: session[:user_id], user2_id: params[:id])
    if matching.nil? then matching = Matching.find_by(user1_id: params[:id], user2_id: session[:user_id]) end

    unless matching.nil? then
      @matching = matching
      @content = paramas[:content]
        
    else
      flash.now[:danger] = "ダイレクトメッセージの送信に失敗しました"
      render 'show'
    end

  end
end
