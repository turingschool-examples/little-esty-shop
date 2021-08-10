class Invoice < ApplicationRecord
  enum status: { cancelled: 0, 'in progress' => 1, completed: 2 }

  belongs_to :customer
  has_many :transactions, dependent: :destroy
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items
  has_many :merchants, through: :items
  has_many :discounts, through: :merchants

  validates :status, presence: true, inclusion: { in: Invoice.statuses.keys }

  def invoice_revenue
    (invoice_items.sum("invoice_items.unit_price * invoice_items.quantity"))/100.00
  end

  def invoice_revenue_minus_discount
    invoice_items.sum do |ii|
      ii.revenue_after_discount
    end
  end

end
