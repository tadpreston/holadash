class InboxController < ApplicationController
  def index
    get_data
  end

  def refresh
    get_data
  end

  private

  def get_data
    @inbox = Envelope.belongs_to_user(current_user.id).inbox.order_by_sent_at
    @unread = Envelope.belongs_to_user(current_user.id).inbox.unread.count
    @trash = Envelope.belongs_to_user(current_user.id).trash
    @sent = Envelope.belongs_to_user(current_user.id).sent
    @drafts = Message.draft(current_user.id)
  end
end
