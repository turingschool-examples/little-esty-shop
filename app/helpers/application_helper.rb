module ApplicationHelper
  def price_round(totalcost)
    '$' + sprintf("%.2f", totalcost/100.to_f)
  end
end
