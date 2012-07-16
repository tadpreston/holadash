class AddAuthorFlagToEnvelopes < ActiveRecord::Migration
  def change
    add_column :envelopes, :author_flag, :boolean

    Message.all.each do |message|
      message.envelopes.create(recipient_id: message.author_id, author_flag: true)
    end
  end
end
