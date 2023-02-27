class Item < ApplicationRecord

  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  belongs_to :merchant

  enum status: [:disabled, :enabled]

	attribute :quantity, :integer, default: 1

  validates :name, :description, :unit_price, presence: :true

end
