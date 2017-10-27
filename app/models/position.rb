class Position < ApplicationRecord
  belongs_to :user
  validates :fen, uniqueness: { scope: :user_id }
end
