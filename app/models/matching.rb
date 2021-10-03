class MatchingIdValidator < ActiveModel::Validator
    def first_matching(r)
        Matching.find_by(user1: r.user1, user2: r.user2).nil? && \
        Matching.find_by(user1: r.user2, user2: r.user1).nil?
    end
    def validate(r)
        unless first_matching(r) && r.user1.present? && r.user2.present? && r.user1 != r.user2
            r.errors[:matching] << "cannot matching."
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