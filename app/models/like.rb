class LikeIdValidator < ActiveModel::Validator
    def validate(r)
        unless r.liker.present? && r.liked.present? && r.liker != r.liked
            r.errors[:like] << "cannot like myself."
        end
    end
end

class Like < ApplicationRecord
    include ActiveModel::Validations
    
    belongs_to :liker, class_name: "User"
    belongs_to :liked, class_name: "User"

    validates_with LikeIdValidator
end