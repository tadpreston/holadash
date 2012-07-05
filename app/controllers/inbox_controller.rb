class InboxController < ApplicationController
  def index
    @envelopes = current_user.envelopes
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
