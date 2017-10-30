class Position < ApplicationRecord
  belongs_to :user
  has_many :moves, foreign_key: 'position_id', dependent: :destroy
  has_many :positions_moves, dependent: :destroy
  has_many :parent_moves, through: :positions_moves, source: :move
  validates :fen, uniqueness: { scope: :user_id }
end
