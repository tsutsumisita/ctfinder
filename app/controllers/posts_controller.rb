class PostsController < ApplicationController

    before_action :logged_in_usr, only: [:create]

    def create
        # @post = current_user.
    end

    def logged_in_user
        unless logged_in?
            flash[:alert] = "ログインしてください"
            redirect_to login_url
        end
    end

end
