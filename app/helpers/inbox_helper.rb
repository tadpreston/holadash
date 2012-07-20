module InboxHelper

  def send_tos(message)
    unless message.send_to.blank?
      "#{message.send_to} #{message.copy_to}".truncate(30)
    else
      "<No recipients>"
    end
  end

  def subject(message)
    unless message.subject.blank?
      message.subject
    else
      '<No Subject>'
    end
  end

  def trash_link(trash_item)
    if trash_item.instance_of?(Message)
      link_to message_path(trash_item), title: 'View Message', remote: true do
        content_tag :strong, class: 'blank' do
          trash_item.author.full_name
        end
        content_tag(:br)
        subject(trash_item)
      end
    else
      link_to message_path(trash_item.message), title: 'View Message', remote: true do
        content_tag :strong, class: 'blank' do
          trash_item.from
        end
        content_tag(:br)
        subject(trash_item.message)
      end
    end
  end

  def sent_at(trash_item)
    if trash_item.instance_of? Message
      sent_time = trash_item.sent_at
    else
      sent_time = trash_item.message.sent_at
    end
    sent_time.strftime('%b %e %H:%M')
  end
end
