class Post < ApplicationRecord
  
  belongs_to :participant
  belongs_to :tournament
  has_one :action, dependent: :destroy 


  validates :content, presence:true, length: { maximum: 140, minimum: 1 }

end
