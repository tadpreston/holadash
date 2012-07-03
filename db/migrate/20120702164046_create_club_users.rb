class CreateClubUsers < ActiveRecord::Migration
  def change
    create_table :club_users do |t|
      t.integer :club_id
      t.integer :user_id

      t.timestamps
    end
  end
end
