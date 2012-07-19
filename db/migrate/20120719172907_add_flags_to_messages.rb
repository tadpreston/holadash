class AddFlagsToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :trash_flag, :boolean, default: false
    add_column :messages, :delete_flag, :boolean, default: false
  end
end
