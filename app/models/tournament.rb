class Tournament < ApplicationRecord
    
    has_many :participants, dependent: :destroy
    has_many :post, dependent: :destroy
    has_many :recent_action, dependent: :destroy

    validates :name, presence: true, uniqueness: true
    validates :date, presence: true

end