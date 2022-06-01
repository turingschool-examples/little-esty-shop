class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def created_at_format
    created_at.strftime('%A, %B %e, %Y')
  end

end
