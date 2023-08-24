class CreateConstellations < ActiveRecord::Migration[7.0]
  def change
    create_table :constellations do |t|
      t.string :name
      t.string :symbolism
      t.integer :bayer_stars
      t.integer :stars_with_planets
      t.boolean :in_zodiac

      t.timestamps
    end
  end
end
