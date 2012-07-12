class AddSentAtToMessages < ActiveRecord::Migration
  def change
    add_column :messages, :sent_at, :datetime

    add_index :messages, :sent_at

    Message.where('status = :s', s: Message::StatusSent).each do |message|
      message.update_attributes(sent_at: message.updated_at)
    end
  end
end
