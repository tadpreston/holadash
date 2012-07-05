class CreateEnvelopes < ActiveRecord::Migration
  def change
    create_table :envelopes do |t|
      t.integer   :message_id
      t.integer   :recipient_id
      t.string    :recipient_type
      t.boolean   :read_flag, default: false
      t.boolean   :trash_flag, default: false
      t.datetime  :sent_at

      t.timestamps
    end

    add_index :envelopes, :message_id
    add_index :envelopes, :recipient_id
  end
end