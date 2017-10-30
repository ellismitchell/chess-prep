class AddParentPositionToMoves < ActiveRecord::Migration[5.1]
  def change
  	add_reference :moves, :position, foreign_key: true 
  end
end
