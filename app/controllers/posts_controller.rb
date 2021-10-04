class PostsController < ApplicationController

    before_action :logged_in_usr, only: [:create]

    def create
        @tournament = Tournament.find(params[:id])
        @participant = @tournament.participants.find(user: current_user)
        @post = @participant.posts.build(post_params)
        if @post.save
            flash.now[:success] = "投稿しました"
            redirect_to tournament_path
        else
            flash[:danger] = "投稿に失敗しました"
        end
    end

end