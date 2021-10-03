module LikesHelper
    include SessionsHelper
    
    def like?
        return current_user && (!Matching.find_by(user1_id: current_user.id, user2_id: params[:id]).nil? \
        || !Matching.find_by(user1_id: params[:id], user2_id: current_user.id).nil?)
    end

end
