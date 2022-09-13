class Invoice < ApplicationRecord
  belongs_to :customer
  enum status: [ :in_progress, :completed, :cancelled]
end
