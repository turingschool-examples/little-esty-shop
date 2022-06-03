class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates :quantity, presence: true
  validates :unit_price, presence: true
  validates :status, presence: true

  enum status: {'pending' => 0, 'shipped' => 1, 'packaged' => 2}

  def self.incomplete_invoice_ids
    where.not(status: 1).distinct.pluck(:invoice_id)
  end
end
