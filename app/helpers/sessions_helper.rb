module SessionsHelper

    def login(login_user)
        session[:user_id] = login_user.id
    end

    def current_user
        if !session[:user_id].nil?
            @current_user ||= User.find_by(id: session[:user_id])
        end
    end

    def logged_in?
        !current_user.nil?
    end

    def log_out
        session.delete(:user_id)
        @current_user = nil
    end

end