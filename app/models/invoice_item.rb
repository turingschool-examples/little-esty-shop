class InvoiceItem < ApplicationRecord
  enum status: { pending: 0, packaged: 1, shipped: 2 }
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item

  def get_name_from_invoice
    item.name
  end

  def display_price
    cents = self.unit_price
    '%.2f' % (cents / 100.0)
  end

  def display_status
    if self.status = 0 ; 'Pending'
    elsif self.status = 1 ; 'Packaged'
    elsif self.status = 2 ; 'Shipped'
    else "Error"
    end
  end
end
