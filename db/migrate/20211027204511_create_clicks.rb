class CreateClicks < ActiveRecord::Migration[6.1]
  def change
    create_table :clicks do |t|
      t.string :geolocation
      t.belongs_to :link, null: false, foreign_key: true

      t.timestamps
    end
  end
end
