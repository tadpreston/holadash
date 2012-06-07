class CreateClubs < ActiveRecord::Migration
  def change
    create_table :clubs do |t|
      t.string :name
      t.integer :region_id
      t.text :address

      t.timestamps
    end
  end
end
