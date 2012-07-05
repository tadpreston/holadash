class InboxController < ApplicationController
  def index
    @envelopes = current_user.envelopes
    @unread = current_user.unread_envelopes.count
    @drafts = current_user.draft_messages
    @sent   = current_user.sent_messages
  end

  def new
  end

  def show
  end

  def create
  end

  def destroy
  end
end
