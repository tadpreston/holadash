class AddIndexesToUser < ActiveRecord::Migration
  def change
    add_index :users, :username
    add_index :users, :employee_id
  end
end
