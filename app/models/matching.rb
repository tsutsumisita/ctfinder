class MatchingIdValidator < ActiveModel::Validator
    def validate(r)
        unless r.user1_id.present? && r.user2_id.present? && r.user1_id != r.user2_id
            r.errors[:matching_id] << "cannot like myself."
        end
    end
end

class Matching < ApplicationRecord
    include ActiveModel::Validations
    
    belongs_to :user1, class_name: "User"
    belongs_to :user2, class_name: "User"

    has_many :direct_message, dependent: :destroy

    validates_with MatchingIdValidator

end