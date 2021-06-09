class InvoiceItem < ApplicationRecord
  validates :quantity, presence: true, numericality: true
  validates :unit_price, presence: true, numericality: true
  validates_presence_of :status
  belongs_to :invoice
  belongs_to :item

  has_many :transactions, through: :invoice

  enum status: ['pending', 'packaged', 'shipped']

  def self.find_invoice_items(params)
    joins(:item)
      .select('items.*, invoice_items.invoice_id, invoice_items.status, invoice_items.quantity')
      .where('invoice_id = ?', params)
  end

  def convert_to_dollar
    if unit_price.nil?
      0
    else
      unit_price.to_f / 100
    end
  end
end

# InvoiceItem.joins(:item).select('items.*, invoice_items.*').where('invoice_id = ?', params)

# Query_1
# SELECT items.*, invoice_items.* FROM "invoice_items" INNER JOIN "items" ON "items"."id" = "invoice_items"."item_id" WHERE (invoice_id = 9)
#
# Query_2
# SELECT invoice_items.*, items.* FROM "invoice_items" INNER JOIN "items" ON "items"."id" = "invoice_items"."item_id" WHERE (invoice_id = 9)
