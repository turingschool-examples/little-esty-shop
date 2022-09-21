module ApplicationHelper

  def current_class?(test_path)
    if test_path == ('/admin')
      return 'nav-active' if path_request == (test_path)

    elsif test_path.include?('admin') && test_path != '/admin'
      return 'nav-active' if path_request.include?(test_path)

    elsif path_request.include?(test_path)
      return 'nav-active'
    end
    ''
  end

  def path_request
    request.path
  end

  def price_round(totalcost)
    '$' + sprintf("%.2f", totalcost/100.to_f)
  end

end
