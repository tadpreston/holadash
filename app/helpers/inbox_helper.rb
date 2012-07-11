module InboxHelper

  def send_tos(message)
    unless message.send_to.blank?
      "#{message.send_to} #{message.copy_to}".truncate(30)
    else
      "<No recipients>"
    end
  end
end
