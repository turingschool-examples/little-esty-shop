class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  self.connection.tables.each do |t|
    self.connection.reset_pk_sequence!(t)
  end
end
