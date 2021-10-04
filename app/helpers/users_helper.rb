module UsersHelper  

  def matching_find
    @matching = Matching.find_by(user1_id: session[:user_id], user2_id: params[:id])
    @matching = Matching.find_by(user1_id: params[:id], user2_id: session[:user_id]) if @matching.nil?
    !@matching.nil?
  end

end
