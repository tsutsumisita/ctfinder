class Post < ApplicationRecord
  
  belongs_to :participant

  validates :content, presence:true, length: { maximum: 140, minimum: 1 }

end