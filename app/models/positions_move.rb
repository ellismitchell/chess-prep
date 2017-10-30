class PositionsMove < ApplicationRecord
  belongs_to :move
  belongs_to :position

  before_destroy :destroy_positions

  private
  def destroy_positions
		if self.position.parent_moves.length <= 1
			self.position.destroy
		end
  end
end
