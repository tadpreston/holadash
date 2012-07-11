class InboxController < ApplicationController
  def index
    get_data
  end

  def refresh
    get_data
  end

  private

  def get_data
    @envelopes = current_user.envelopes
    @unread = current_user.unread_envelopes.count
    @drafts = current_user.draft_messages
    @sent   = current_user.sent_messages
  end
end
