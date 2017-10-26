class CreateMoves < ActiveRecord::Migration[5.1]
  def change
    create_table :moves do |t|
      t.belongs_to :user, foreign_key: true
      t.string :position
      t.string :resulting_position
      t.string :san
      t.decimal :likelihood
      t.datetime :due
      t.integer :streak

      t.timestamps
    end
  end
end
