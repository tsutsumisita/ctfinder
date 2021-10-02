class Participant < ApplicationRecord
    
    belongs_to :user
    belongs_to :tournament
    has_many :post, dependent: :destroy 

end