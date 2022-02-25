module ApplicationHelper

  def date_formatter(string)
      string.strftime('%A, %B %d, %Y')
  end

end
