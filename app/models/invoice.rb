class Invoice < ApplicationRecord
  enum status: [:cancelled, :completed, 'in progress' ]
end 