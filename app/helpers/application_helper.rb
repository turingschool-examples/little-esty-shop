module ApplicationHelper

  def current_class?(test_path)
    return 'nav-active' if request.path.include?(test_path)
    ''
  end

  def path_request
    request.path
  end

  def price_round(totalcost)
    '$' + sprintf("%.2f", totalcost/100.to_f)
  end
end
