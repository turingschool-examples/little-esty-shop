class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy

  enum status: { Disabled: 0, Enabled: 1 }

  validates_presence_of :name
  validates_presence_of :description, presence: true
  validates_presence_of :unit_price, presence: true
  validates_presence_of :created_at
  validates_presence_of :updated_at
  

end
