module ApplicationHelper

  def date_formatter(string)
      string.strftime('%A, %B %d, %Y')
  end 

  def format_money(integer)
      "$#{(integer.to_f/100).to_s}"
  end
end
