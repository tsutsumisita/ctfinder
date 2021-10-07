class NameValidator < ActiveModel::Validator
    def validate(record)
        unless record.name == User.find(record.user_id).name
            record.errors[:name] << "failed to name validation"
        end
    end
end

class Participant < ApplicationRecord
    include ActiveModel::Validations

    belongs_to :user
    belongs_to :tournament
    has_many :post, dependent: :destroy 

    validates_with NameValidator
end
