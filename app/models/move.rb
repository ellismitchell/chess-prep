class Move < ApplicationRecord
  belongs_to :user
  validates :position, uniqueness: { scope: :user_id }
end
