class Invoice < ApplicationRecord
  enum status: [:cancelled, :in_progress, :completed]    
end