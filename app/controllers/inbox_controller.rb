class InboxController < ApplicationController
  def index
    get_data
  end

  def refresh
    get_data
  end

  private

  def get_data
    @envelopes = Envelope.belongs_to_user(current_user.id).inbox.order_by_sent_at
    @unread = Envelope.belongs_to_user(current_user.id).inbox.unread.count
    @trashed = Envelope.belongs_to_user(current_user.id).trashed.order_by_sent_at

    @drafts = Message.belongs_to_user(current_user.id).draft
    @sent = Message.belongs_to_user(current_user.id).sent
  end
end
