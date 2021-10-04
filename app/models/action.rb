class Action < ApplicationRecord
  belongs_to :participant
  belongs_to :post
  belongs_to :user
end
