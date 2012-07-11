class AddDisplayNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :display_name, :string

    add_index :users, :display_name

    User.all.each do |user|
      user.update_attributes(display_name: "#{user.first_name} #{user.last_name}")
    end

  end
end
