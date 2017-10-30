class AddLearnedToPositions < ActiveRecord::Migration[5.1]
  def change
    add_column :positions, :learned, :boolean
  end
end
