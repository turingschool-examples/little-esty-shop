module ApplicationHelper
  def format_currency(number)
    return number.map { |n| format_currency(n) } if number.is_a?(Array)
    sprintf('$%0.2f', number/100.0).gsub(/\B(?=(\d{3})*\b)/, ',')
  end

  def format_date(date)
    date.strftime("%A, %B %d, %Y")
  end

  def format_item_info(item_info)
    item_info.length == 1 ? item_info.first : item_info
  end
end
