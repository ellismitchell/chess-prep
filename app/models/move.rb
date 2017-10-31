class Move < ApplicationRecord
  belongs_to :user
  belongs_to :parent_position, class_name: 'Position', foreign_key: 'position_id'
  has_many :positions_moves, :dependent => :destroy
  has_many :resulting_positions, through: :positions_moves, source: :position 
  validates :position, uniqueness: { scope: :user_id }
  before_destroy :reset_parent

  private
  def reset_parent
  	if self.parent_position.moves.length <= 1
  		self.parent_position.learned = false
  		self.parent_position.save
  	end
  end 
end
