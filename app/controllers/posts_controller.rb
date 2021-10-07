class PostsController < ApplicationController

    before_action :logged_in_user, only: [:create]

    def create
        @tournament = Tournament.find(params[:id])
        @participant = Participant.find_by(tournament: @tournament, user: current_user)
        @post = Post.new(post_params)
        @post.participant = @participant
        @post.tournament = @tournament
        if @post.save
            if RecentAction.where(user: current_user).exists?
                RecentAction.find_by(user: current_user).destroy
            end
            unless RecentAction.new(action: 1, user: current_user, tournament: @tournament).save
                flash[:debug] = "failed to recent action."
                redirect_to root_url
            end
        else
            flash[:danger] = "投稿に失敗しました"
        end
        redirect_to @tournament
    end

    private
    
        def post_params
            params.require(:post).permit(:content)
        end

end
