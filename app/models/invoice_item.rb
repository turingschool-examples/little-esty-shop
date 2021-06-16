class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  has_many :bulk_discounts, through: :merchants

  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true

  enum status: { pending: 0, packaged: 1, shipped: 2}, _prefix: :status

  def item_name
    self.item.name
  end

  def status_for_view
    rev_statuses = {0 => 'Pending', 1 => 'Packaged', 2 => 'Shipped'}
    rev_statuses[self.status]
  end

  def highest_discount
    discount_record = bulk_discounts.where('quantity_threshold <= ?', self.quantity).order(percentage: :desc).first
  end

  def highest_discount_percent
    if !self.highest_discount.blank?
      highest_discount_percent = (self.highest_discount.percentage.to_f / 100.00)
    else
      highest_discount_percent = 0
    end
  end

  def discount?
    self.highest_discount_percent != 0
  end

  def total_rev
    (quantity * unit_price) - ((quantity * unit_price) * self.highest_discount_percent)
  end
end
