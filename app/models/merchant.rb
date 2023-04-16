class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoice_items, through: :items
  has_many :invoices, -> { distinct }, through: :invoice_items
  has_many :transactions, -> { distinct }, through: :invoices
  has_many :customers, -> { distinct }, through: :invoices

  validates :name, presence: true

  def self.all_enabled
    where(is_enabled: true).order(:name)
  end

  def self.all_disabled
    where(is_enabled: false).order(:name)
  end

  def self.find_top_5
    joins(items: { invoice_items: { invoice: :transactions }})
    .where(transactions: { result: "success" })
    .group('merchants.id')
    .select('merchants.*, SUM(invoice_items.quantity * invoice_items.unit_price) AS revenue')
    .order('revenue DESC')
    .limit(5)
  end

  def enabled_status
    if is_enabled?
      "Enabled"
    else
      "Disabled"
    end
  end


end
