module ApplicationHelper
  def format_currency(number)
    sprintf('$%0.2f', number/100.0).gsub(/\B(?=(\d{3})*\b)/, ',')
  end

  def format_date(date)
    date.strftime("%A, %B %d, %Y")
  end
end
