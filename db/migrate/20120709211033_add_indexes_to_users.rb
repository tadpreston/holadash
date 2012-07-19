class AddIndexesToUsers < ActiveRecord::Migration
  def change
    add_index :users, :first_name
    add_index :users, :last_name
  end

#  def up
#    execute "create index users_first_name on users using gin(to_tsvector('english', first_name))"
#    execute "create index users_last_name on users using gin(to_tsvector('english', last_name))"
#  end
#
#  def down
#    execute "drop index users_first_name"
#    execute "drop index users_last_name"
#  end
end
