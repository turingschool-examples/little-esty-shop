class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item

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
end
