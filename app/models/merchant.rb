class Merchant < ApplicationRecord
  has_many :items
  validates :name, presence: true

  #looking at this now, would this also work as a class method in the customer model?
  def transactions_top_5
      Customer.joins(invoices: :transactions).where( transactions: {result: 1}).group(:id).order("transactions.count desc").limit(5)
  end

  def enabled_items
    items.where(enabled: true)
  end

  def disabled_items
    items.where(enabled: false)
  end

  #could this also be a class method?
  def top_5_items
    Item.joins(invoices: :transactions)
      .group(:id, :name)
      .where( transactions: {result: 1}, merchant_id: self.id)
      .select(:name, :id, "sum(invoice_items.unit_price*quantity) as revenue")
      .order(revenue: :desc)
      .limit(5)
  end
end
