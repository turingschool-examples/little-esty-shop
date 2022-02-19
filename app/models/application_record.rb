class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def format_created_at(date)
    date.strftime("%A, %B %d, %Y")
  end
end
