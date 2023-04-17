module ApplicationHelper
  def format_date(date)
    date.strftime("%-m/%-d/%y")
  end
end
