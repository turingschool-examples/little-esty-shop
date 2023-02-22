class Invoice < ApplicationRecord
  enum status: [ 'in progress', :completed, :cancelled ]

end
