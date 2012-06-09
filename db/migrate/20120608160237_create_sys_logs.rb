class CreateSysLogs < ActiveRecord::Migration
  def change
    create_table :sys_logs do |t|
      t.text :message
      t.string :message_type
      t.string :actioned_by
      t.belongs_to :loggable, polymorphic: true

      t.timestamps
    end

    add_index :sys_logs, [:loggable_id, :loggable_type]
  end
end
