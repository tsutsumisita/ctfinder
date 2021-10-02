class LikesController < ApplicationController

    def create
        liked_user = User.find_by(params[:liked_id])
        if current_user.nil? || liked_user.nil? || current_user.id != liked_user.id
            redirect_to root_url
            return
        end
        like = Like.new(liker_id: current_user.id, liked_id: liked_user.id)
        redirect_to root_url unless like.save
    end

end
