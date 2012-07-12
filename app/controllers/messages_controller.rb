class MessagesController < ApplicationController
  def show
    @message = Message.find params[:id]
    @message.mark_as_read current_user
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def new
    @message = Message.new(author_id: current_user.id)
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def edit
    @message = Message.find params[:id]
  end

  def create
    @message = current_user.messages.new(params[:message])
    if @message.save
      if params[:action_type] == 'send'
        @message.deliver
      end
      respond_to do |format|
        format.js { render layout: false }
      end
    else
    end
  end

  def update
    @message = Message.find params[:id]
    if @message.update_attributes(params[:message])
      if params[:action_type] == 'send'
        @message.deliver
      end
      respond_to do |format|
        format.js { render layout: false }
      end
    else
    end
  end

  def reply
    @orig_msg = Message.find(params[:message_id])
    @message = @orig_msg.reply(params[:reply_type])
    respond_to do |format|
      format.js { render layout: false }
    end
  end
end
