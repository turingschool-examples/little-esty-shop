class Transaction < ApplicationRecord
  enum status: [:cancelled, :completed, :in_progress]

end
