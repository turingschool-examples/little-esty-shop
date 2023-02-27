class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy
  has_many :customers, through: :invoices, dependent: :destroy
  has_many :transactions, through: :invoices, dependent: :destroy
  

  enum status: [:disabled, :enabled]

	attribute :quantity, :integer, default: 1

  validates :name, :description, :unit_price, presence: :true

end
