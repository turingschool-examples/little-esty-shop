class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy

  enum status: {enabled: 0, disabled: 1}

  # enum :status [:enabled, :disabled]

  validates_presence_of :name
  validates_presence_of :description
  validates_presence_of :unit_price
  # validates_presence_of :status

end
