class Invoice < ApplicationRecord
  has_many :transactions
  belongs_to :customer

  validates :status, presence: true
  enum status: [ :in_progress, :completed, :cancelled ]
end
