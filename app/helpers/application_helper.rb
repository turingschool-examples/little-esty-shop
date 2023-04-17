module ApplicationHelper
  def format_date(date)
    date.strftime("%-m/%-d/%y")
  end

  def format_revenue(amount)
    "$#{amount.fdiv(100).round()}"
  end
end
