class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  enum status: ['pending', 'packaged', 'shipped']

  def self.unshipped_items
    where(status: 'pending').or(where(status: 'packaged')).order(:created_at)
  end
end
