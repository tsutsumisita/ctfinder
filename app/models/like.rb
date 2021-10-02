class LikeIdValidator < ActiveModel::Validator
    def validate(r)
        unless r.liker_id.present? && r.liked_id.present? && r.liker_id != r.liked_id
            r.errors[:like_id] << "cannot like myself."
        end
    end
end

class Like < ApplicationRecord
    include ActiveModel::Validations
    
    belongs_to :liker, class_name: "User"
    belongs_to :liked, class_name: "User"

    validates_with LikeIdValidator
end