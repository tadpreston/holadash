class EnvelopesController < ApplicationController
  def trash
    envelope = Envelope.find(params[:envelope_id])
    envelope.trash
    respond_to do |format|
      format.js { render layout: false }
    end
  end

  def delete
    envelope = Envelope.find(params[:envelope_id])
    envelope.delete
    respond_to do |format|
      format.js { render 'trash', layout: false }
    end
  end

  def mark_important
    envelope = Envelope.find(params[:envelope_id])
    envelope.mark_important
    respond_to do |format|
      format.js { render layout: false }
    end
  end
end
