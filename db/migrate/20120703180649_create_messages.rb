class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.integer :author_id
      t.string :subject
      t.text :body
      t.string :status, default: 'draft'
      t.string :importance, default: 'normal'

      t.timestamps
    end

    add_index :messages, :author_id
    add_index :messages, :subject
  end
end
