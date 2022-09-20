module ApplicationHelper

  def current_class?(test_path)
    return 'nav-active' if request.path == test_path
    ''
  end
end
