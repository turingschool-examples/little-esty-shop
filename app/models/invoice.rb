class Invoice < ApplicationRecord
  validates_presence_of :status
  belongs_to :customer

  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchant, through: :items

  enum status: ['in progress', 'cancelled', 'completed']

  def formatted_date
    created_at.strftime("%A, %B %d, %Y")
  end
end
