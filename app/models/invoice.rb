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
    invoice_items.sum("invoice_items.unit_price * invoice_items.quantity")
  end

  # def total_invoice_discount
  #   invoice_items.joins(:discounts)
  #                .select('invoice_items.id, max(invoice_items.quantity * invoice_items.unit_price * (discounts.percentage / 100)) as total_discount')
  #                .where('invoice_items.quantity >= discounts.threshold')
  #                .group('invoice_items.id')
  #                .order('total_discount desc')
  #                .sum()
  #                # require "pry"; binding.pry
  # end

  def total_invoice_discount
    invoice_items.joins(:discounts)
                  .select("invoice_items.id, max(invoice_items.unit_price * invoice_items.quantity * (discounts.percentage / 100.00)) as total_discount")
                  .where("invoice_items.quantity >= discounts.threshold")
                  .group("invoice_items.id")
                  .order(total_discount: :desc)
                  require "pry"; binding.pry
                  # .sum(&:total_discount)
  end
end
