class CreateStars < ActiveRecord::Migration[7.0]
  def change
    create_table :stars do |t|
      t.string :name
      t.integer :distance
      t.float :mass
      t.float :radius
      t.boolean :visible
      t.references :constellation, null: false, foreign_key: true

      t.timestamps
    end
  end
end
