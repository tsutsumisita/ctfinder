class RecentAction < ApplicationRecord
  
  belongs_to :user
  belongs_to :tournament

  validates :action, presence: true, length: { maximum: 2, minimum: 1 } # 1 => post, 2 => participant
end