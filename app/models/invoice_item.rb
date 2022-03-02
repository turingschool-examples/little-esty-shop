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

  def change_status(result)
    self.pending! if result == 'pending'
    self.packaged! if result == 'packaged'
    self.shipped! if result == 'shipped'
  end

  private
  def integer_status
    self.status = 0 if self.status == 'pending'
    self.status = 1 if self.status == 'packaged'
    self.status = 2 if self.status == 'shipped'
  end
end
