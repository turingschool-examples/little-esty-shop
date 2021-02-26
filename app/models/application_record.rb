class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def convert_time
    strftime("%A, %B %d, %Y")
  end
end
