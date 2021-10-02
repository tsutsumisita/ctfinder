class Tournament < ApplicationRecord
    
    has_many :participants, dependent: :destroy

    validates :name, presence: true, uniqueness: true
    validates :date, presence: true

end