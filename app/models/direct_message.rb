class DirectMessage < ApplicationRecord
  
  belongs_to :matching

  validates :content, length: { maximum: 140, minimum: 1 }, null: false
end
