class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item

  def create
  end
end
