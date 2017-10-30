class CreatePositionsMoves < ActiveRecord::Migration[5.1]
  def change
    create_table :positions_moves do |t|
      t.belongs_to :position, foreign_key: true
      t.belongs_to :move, foreign_key: true
    end
  end
end
