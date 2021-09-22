class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item
  validates_presence_of :status

  enum status: {
    packaged: 0,
    pending: 1,
    shipped: 2
  }

  def create
  end

end
