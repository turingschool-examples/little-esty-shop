class Invoice < ApplicationRecord
  belongs_to :customer
  has_many :invoice_items
  has_many :items, through: :invoice_items

  enum status: [:cancelled, :in_progress, :completed]

  validates :status, inclusion: { [:cancelled, :in_progress, :completed] }
end
