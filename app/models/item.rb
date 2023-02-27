class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :transactions, through: :invoices
  belongs_to :merchant
	enum status: [ "enabled", "disabled" ]


  def self.enabled_items
    where(status: 0)
  end

  def self.disabled_items
    where(status: 1)
  end

	def self.top_five_most_popular_items
		joins(:transactions)
		.where(transactions: {result: 0})
		.select("items.*, SUM(invoice_items.unit_price*invoice_items.quantity) as revenue")
		.group(:id)
		.order("revenue DESC")
		.limit(5)
	end
end
