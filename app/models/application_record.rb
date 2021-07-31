class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def format_date(date)
    date.strftime("%A, %B %d, %Y")
  end
  
end
