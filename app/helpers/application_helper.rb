module ApplicationHelper

  def date_formatter(string)
      string.strftime('%A, %B %d, %Y')
  end

  def sortable(data, params)
    if params[:sort] != nil 
      data.order(params[:sort])
    else 
      data
    end
  end
end
