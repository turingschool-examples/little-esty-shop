class InvoiceItem < ApplicationRecord
  belongs_to :item
  belongs_to :invoice
  has_many :transactions, through: :invoice

  validates :quantity, presence: true, numericality: {only_integer: true}
  validates :unit_price, presence: true, numericality: {only_integer: true}

  enum status: { "pending" => 0, :packaged => 1, "shipped" =>2 }

  scope :total_revenue, ->{sum('invoice_items.quantity * invoice_items.unit_price')}

  scope :grouped_total_revenue, -> {select('SUM (invoice_items.quantity * invoice_items.unit_price) AS revenue').group(:id)}

  def self.revenue
    joins(invoice: :transactions)
    .merge(Transaction.successful)
    .total_revenue
  end
end
