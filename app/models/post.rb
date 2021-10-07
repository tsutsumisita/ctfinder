class Post < ApplicationRecord
  
  belongs_to :participant
  belongs_to :tournament

  validates :content, presence:true, length: { maximum: 140, minimum: 1 }

end
