class Invoice < ApplicationRecord
  enum status: [ :in_progress, :completed, :cancelled ]

end
