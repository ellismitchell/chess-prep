class CreatePositions < ActiveRecord::Migration[5.1]
  def change
    create_table :positions do |t|
      t.belongs_to :user, foreign_key: true
      t.string :fen
      t.decimal :likelihood

      t.timestamps
    end
  end
end
