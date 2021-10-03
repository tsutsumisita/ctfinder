class DmValidator < ActiveModel::Validator
  def validate(r)
    unless [r.matching.user1, r.matching.user2].include?(r.sender)
      r.errors[:dm] << "direct message validation error."
    end
  end
end

class DirectMessage < ApplicationRecord
  include ActiveModel::Validations
  
  belongs_to :matching
  belongs_to :sender, class_name: "User"

  validates :content, length: { maximum: 140, minimum: 1 }, null: false
  validates_with DmValidator
end
