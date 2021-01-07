module ApplicationHelper
  def format_date(date)
    date.strftime("%A, %B %-d, %Y")
  end
end
