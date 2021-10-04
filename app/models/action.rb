class Action < ApplicationRecord
  belongs_to :participant, class_name: "Participant"
  belongs_to :post, class_name: "Post"
  belongs_to :user, class_name: "User"
end
