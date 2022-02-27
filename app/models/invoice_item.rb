class InvoiceItem < ApplicationRecord
  enum status: { pending: 0, packaged: 1, shipped: 2 }
  belongs_to :invoice
  belongs_to :item
  has_many :merchants, through: :item

  def get_name_from_invoice
    item.name
  end

  # def self.not_shipped
  #   invoice_ids = InvoiceItem.where("status != 2")
  #                             .order("DESC")
  #   # .pluck(:invoice_id)
  #   # invoice_items.where("status != 2")
  # end
end
