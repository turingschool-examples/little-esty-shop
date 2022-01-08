class Item < ApplicationRecord
  has_many :invoice_items
  has_many :invoices, through: :invoice_items
  has_many :customers, through: :invoices
  belongs_to :merchant

  validates :name, :description, :unit_price, presence: true
  enum item_status: { disabled: 0, enabled: 1}

  def enabled
    items.where(item_status: 1)
  end

  def disabled
    items.where(item_status: 0)
  end

  # are the successful transactions redundant here after doing it in top_five_items
  # good or bad to include the updated_at on the end?
  def top_item_best_day
    invoices.joins(:transactions)
            .select("invoices.*, sum(quantity) as total_sales")
            # .where(transactions: {result: "success"})
            .group(:id)
            .order(total_sales: :desc)
            .first.updated_at
  end
end
