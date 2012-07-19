class AddFlagsToEnvelopes < ActiveRecord::Migration
  def change
    add_column :envelopes, :delete_flag, :boolean, default: false
  end
end
