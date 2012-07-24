class AddImportanceFlagToEnvelope < ActiveRecord::Migration
  def change
    add_column :envelopes, :importance_flag, :boolean, default: false
  end
end
