module ApplicationHelper

  def date_formatter(string)
      string.strftime('%A, %B %d, %Y')
  end

  def sortable(data, params)
    if params[:sort] != nil && ActiveRecord::Base.connection.column_exists?(params[:controller].delete_prefix("admin/").to_sym, params[:sort])
        data.order(params[:sort])
    else 
      data
    end
  end
end
