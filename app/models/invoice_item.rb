class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  validates :item_id, presence: true, numericality: true
  validates :invoice_id, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates :status, presence: true
  validates :quantity, presence: true, numericality: true

  enum status: {pending: 0, packaged: 1, shipped: 2}

  before_validation :integer_status
  private
  def integer_status
    self.status = 0 if self.status == 'pending'
    self.status = 1 if self.status == 'packaged'
    self.status = 2 if self.status == 'shipped'
  end

end
