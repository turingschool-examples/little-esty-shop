class InvoiceItem < ApplicationRecord
  belongs_to :invoice
  belongs_to :item
  #still need to create joins table
  def create
  end
end
