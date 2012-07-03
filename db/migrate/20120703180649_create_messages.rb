class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :from_id
      t.string :subject
      t.text :body
      t.string :status

      t.timestamps
    end

    add_index :messages, :from_id
    add_index :messages, :subject
  end
end
