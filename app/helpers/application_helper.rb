module ApplicationHelper
  def format_price(num)
    num.to_s.insert(-3, ".").prepend("$")
  end


end
