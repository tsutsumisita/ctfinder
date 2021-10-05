class ParticipantAction < ApplicationRecord
  belongs_to :participant
  belongs_to :user
end
