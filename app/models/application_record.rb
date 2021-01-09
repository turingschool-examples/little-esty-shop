class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def date
    created_at.strftime("%A, %b %d, %Y")
  end
end
