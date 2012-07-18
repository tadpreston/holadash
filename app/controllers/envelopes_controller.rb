class EnvelopesController < ApplicationController
  def trash
    envelope = Envelope.find(params[:envelope_id])
    envelope.trash
    respond_to do |format|
      format.js { render layout: false }
    end
  end
end
