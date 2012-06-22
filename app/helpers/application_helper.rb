module ApplicationHelper
  def dashboard_date
    c_date = Date.today
    "#{c_date.strftime('%b').downcase} <strong>#{c_date.strftime('%d')}</strong>"
  end
end
