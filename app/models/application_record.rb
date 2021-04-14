class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  # def self.created_at_format
  #   strftime("%A, %B %d, %Y")
  # end
end
