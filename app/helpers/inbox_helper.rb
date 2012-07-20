module InboxHelper

  def send_tos(message)
    unless message.send_to.blank?
      "#{message.send_to} #{message.copy_to}".truncate(30)
    else
      "<No recipients>"
    end
  end

  def subject(item)
    message = item.instance_of?(Message) ? item : item.message
    unless message.subject.blank?
      message.subject
    else
      '<No Subject>'
    end
  end

  def sent_at(item)
    message = item.instance_of?(Message) ? item : item.message
    message.sent_at.strftime('%b %e %H:%M')
  end
end
